#!/usr/bin/env python3

import urllib.parse as urllib
import urllib3

RANDOM_WORD_WEBSITE='http://watchout4snakes.com/wo4snakes/Random/RandomWord';

def getRandomWord():
    ''' Returns a random word using an online service'''
    
    #req = urllib2.Request(RANDOM_WORD_WEBSITE, urllib.urlencode({"LastWord":""}));
#?    req.add_header("User-Agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A");
    http = urllib3.PoolManager()
    req = http.request("GET", RANDOM_WORD_WEBSITE +"?"+ urllib.urlencode({"LastWord": ""}),
            headers={"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_3) AppleWebKit/537.75.14 (KHTML, like Gecko) Version/7.0.3 Safari/7046A194A"
                });
#?    assert req.get_method() == "POST";
#?    websiteFile = urllib2.urlopen(req);
    
    word = req.data.decode("utf-8")
#?    word = websiteFile.read();
#?    websiteFile.close();
    
    return word;


def getPassword(numWords):
    '''Returns a string of numWords random words'''
    
    passwd = "";
    for i in range(0, numWords):
        passwd += getRandomWord();
        
    return passwd;


if __name__ == "__main__": # running as a script
    import sys;
    num = 1;
    silent = False;
    
    try:
        num = int(sys.argv[1]);
        if len(sys.argv) >= 3:
            if sys.argv[2] == '-s':
                silent = True;
    except:
        sys.stderr.write("Usage: %s <number of words> [-s]\n" % sys.argv[0]);
        sys.exit(1);
     
    try:
        if silent:
            print(getPassword(num));
        else:
            pswd = ""
            sys.stdout.write("Sentence: ");
            for i in range(0, num):
                word = getRandomWord();
                pswd += word;
                sys.stdout.write("%s " % word);
                sys.stdout.flush();
            sys.stdout.write("\nPassword: %s\n" % pswd);
    except:
        sys.stderr.write("Something wrong! Check your internet connection\n");
        raise
