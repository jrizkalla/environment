import simplejson as json
#?except ImportError:
#?    import json
import re
import urllib2
try:
    import vim
    vim_command = vim.command
except ImportError:
    def vim_command(*args, **kwargs): pass
    
    
import time

from threading import Semaphore, RLock, Thread
from collections import namedtuple
from functools import partial
from contextlib import contextmanager

DEFAULT_PORT = 8081
# Used to order results based on their context
# The first item has the highest priority (before the reverse)
CONTEXT_ORDER = list(reversed(
"""source.codecompletion.context.local
source.codecompletion.context.thisclass
source.codecompletion.context.superclass
source.codecompletion.context.thismodule
source.codecompletion.context.othermodule
source.codecompletion.context.none""".split("\n")))


def vim_return(expr):
    vim_command("let s:result = {}".format(str(expr)))


CompleteRequest = namedtuple("CompleteRequest", "path lineno prefix offset")
CompleteResponse = namedtuple("CompleteResponse", "request data")
class SourceKittenDaemon:
    """
    The class that talks to the deamon and retreives the data.
    """
    
    def __init__(self, port=DEFAULT_PORT):
        """
        Creates the source kitten daemon process (if it's not alreay running).
        Also creates the deamon that communicates with that daemon.
        """
        
        self.port = int(port)
        try:
            request = urllib2.Request("http://localhost:{}/ping".format(port))
            response = urllib2.urlopen(request).read()
            if response != b"OK":
                raise TypeError()
        except Exception as e:
            import os
            from os import path
            # Start the process
            # First, go up the file tree looking for *.xcodeproj
#?            currdir = os.getcwd()
#?            directories = path.dirname(currdir)
            # TODO: find project file and run process
            
        
        self.daemon_thread = Thread(
                target=self.__daemon_main,
                name="Source Kitten Communication daemon")
        self.daemon_thread.daemon = True
        
        self.request_queue = []
        self.request_queue_lock = RLock()
        self.request_queue_count = Semaphore(0)
        
        self.__should_quit = False
        
        self.cached_data = None # Type: CompleteRequest
        
        self.daemon_thread.start() # start the daemon
        
    @contextmanager
    def _queue_lock(self):
        self.request_queue_lock.acquire()
        yield
        self.request_queue_lock.release()
        
    def request(self, path, lineno, prefix, offset):
        # see if the data is cached
        with self._queue_lock():
            # to access cached_data
            if self.cached_data is not None:
                return self.cached_data.data
#?                _, clineno, cprefix, _ = self.cached_data.request
#?                if lineno == clineno and (
#?                        prefix.startswith(cprefix)
#?                        or cprefix.startswith(prefix)):
#?                    return self.cached_data.data
                
            if len(self.request_queue) < 1:
                self.request_queue.append(None)
            self.request_queue[0] = CompleteRequest(path, lineno, prefix, offset)
            # don't use it as a queue, just as a variable
        self.request_queue_count.release()
        print("sending request. request_queue_count is {}".format(self.request_queue_count._Semaphore__value))
            
        return None
        
        
    def stop(self):
        self.__should_quit = True
        with self._queue_lock():
            self.request_queue = []
            
        self.request_queue_count.release() # wake up the daemon
        
        
    def __daemon_main(self):
        while True:
            self.request_queue_count.acquire()
            
            if self.__should_quit:
                break
            
            with self._queue_lock():
                try:
                    request = self.request_queue[0]
                except IndexError: # not sure why this happens TODO: fix
                    continue
                self.request_queue.pop()
            
            path, lineno, prefix, offset = request
            
            # send a code completion request
            url_request = urllib2.Request("http://localhost:{}/complete"
                .format(self.port))
            url_request.add_header("X-Path", path)
            url_request.add_header("X-Offset", offset)
            response = urllib2.urlopen(url_request).read()
            val = json.loads(response)
            
            with self._queue_lock():
                self.cached_data = CompleteResponse(request=request, data=val)



class SourceKittenDaemonVim(object):
    __token_regex = re.compile("<#.*?#>")
    __token_type_regex = re.compile(r"<#T##(.*?):\s*(.*?)#>")

    def __init__(self, port=DEFAULT_PORT):
        self.__daemon = SourceKittenDaemon(port)
        
        
    def complete(self, lineno, prefix, path, offset):
        # first see if the line is cached
            
        completions = self.__daemon.request(path, lineno, prefix, offset)
        if completions is None:
            completions = [ ]
        else:
            completions = [ x for x in
                    map(type(self).convert_to_completions, completions) ]
            
        # sort the completions with the most appropriate for the line
        key_fn = partial(type(self).rank_match, prefix)
        completions.sort(key=key_fn)
        completions = [ prefix ] + completions
#?                    if x and SourceKittenDaemonVim.matches(prefix, x)]
        vim_return(completions)
        return completions
        

    @classmethod
    def convert_to_completions(cls, response):
        try:
            return {
                "word": cls.remove_tokens(str(response["sourcetext"])),
                "abbr": str(cls.remove_abbr_tokens(response["sourcetext"])),
                "context": str(response["context"]),
            }
        except KeyError:
            return None
        
    @classmethod
    def rank_match(cls, prefix, match):
        """
        Simply returns the number of characters that match the prefix
        """
        val = -sum(1 for pc, mc in zip(prefix, match["word"]) if pc == mc)
        # add another component based on the context
        try:
            context = -next(i for i, ctx in enumerate(CONTEXT_ORDER) 
                    if ctx == match["context"])
        except StopIteration:
            # ERROR: I forgot a context in the list
            vim_command("echoerr " + "'Unknown context " 
                    + match["context"] + "'")
            context = 0
            
        return val + (context * 0.1)
#?        return -1 if match["word"] == "scnView" else 0
#?        print("rank for prefix '{}' with match '{}' is {}".format(prefix, match["word"], val))

    @classmethod
    def remove_tokens(cls, string):
        return re.sub(cls.__token_regex, "", string)
    
    @classmethod
    def remove_abbr_tokens(cls, string):
        match = cls.__token_type_regex.match(string)
        if match:
            return "{}: {}".format(match.group(1), match.group(2))
        else:
            return string

    @classmethod
    def matches(cls, prefix, dictionary):
        if not prefix:
            return True
        word = dictionary["word"]
        return word.startswith(prefix)
    
    
if __name__ == "__main__":
    daemon = SourceKittenDaemonVim()
    d = daemon
