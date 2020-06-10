#!/usr/bin/env python3

import sys
vers = sys.version_info
if vers.major < 3 or vers.minor < 6:
    print("Please run with Python 3.6 or newer. Exiting")
    sys.exit(5)
del vers

EXEC_NAME = "~/server.py"

from typing import *
import os
import argparse
from pathlib import Path
import json
import tempfile
import contextlib
import functools
from subprocess import call, check_call, check_output, DEVNULL
import uuid
import time
from itertools import chain
import getpass
from copy import copy, deepcopy

class parser:
    main = argparse.ArgumentParser(description="Manage multiple ssh servers without going crazy",
            epilog="Server JSON format: { servers: [ {id: str, hostname; str, username: str} ])")
    main.add_argument("--master", nargs="?", help="Force run as the master. Must provide .server_config.json file", const="~/.server_config.json")
    main.add_argument("--minion", nargs=2, help="Force run as a minion. Must provide the server hostname and username. Must be able to ssh into the server without a password")
    main.add_argument("--redirect-form", help="Specify commands in Json format")
    main.add_argument("--dry-run", action="store_true", default=False, help="Don't make any permenant changes. Just print the commands")
    main.add_argument("-s", "--silent", action="store_true", default=False, help="Don't print anything that's not an error")
    sub = main.add_subparsers()
    
    info = sub.add_parser("info", help="Display information about the current configuration.")
    info.set_defaults(action="info")
    
    serv = sub.add_parser("server", help="Server commands")
    serv.set_defaults(action="serv")
    
    ls = sub.add_parser("ls", help="List all the servers")
    ls.set_defaults(action="ls")
    ls.add_argument("--json", action="store_true", default=False, help="Ouput the list of servers in json format")
    
    ssh = sub.add_parser("ssh", help="ssh into one of the servers")
    ssh.set_defaults(action="ssh")
    ssh.add_argument("server_name", nargs="?", default=None, help="The server name. Defaults to the master server")
    ssh.add_argument("--print-url", action="store_true", default=False, help="Just print the ssh URL")
    
    vnc = sub.add_parser("vnc", help="vnc one of the servers")
    vnc.set_defaults(action="vnc")
    vnc.add_argument("server_name", nargs="?", default=None, help="The server name. Defaults to the master server")
    vnc.add_argument("--print-url", action="store_true", default=False, help="Just print the vnc URL")
    
    rsync = sub.add_parser("rsync", help="Move a file from one server to another")
    rsync.set_defaults(action="rsync")
    rsync.add_argument("from_server", help="From server name and location")
    rsync.add_argument("to_server", help="To server name and location. If location is not specified, send the file to the same location on the server.")
    
    send = sub.add_parser("send", help="Send a file to a server")
    send.set_defaults(action="send")
    send.add_argument("server", help="The server name and location. If location is not specified, send the file to the same location on the server.")
    
    get = sub.add_parser("get", help="Get a file from a server")
    get.set_defaults(action="get")
    get.add_argument("server", help="The server ")
    


# util functions
def error(text: str, ret: int = 1):
    print(text, file=sys.stderr)
    sys.exit(ret)
    
@contextlib.contextmanager
def tmpfile(fl: Path):
    try:
        yield
    finally:
        if fl.exists():
            fl.unlink()
def _iterdir_noerr(self):
    i = iter(self.iterdir())
    while True:
        try:
            yield next(i)
        except FileNotFoundError: pass
        except StopIteration: break
Path.iterdir_noerr = _iterdir_noerr
        


class Config:
    
    def __init__(self):
        self.dry_run = False
    
    @property
    def config_json(self):
        try:
            return self._config_json
        except AttributeError:
            with self.master_config.open("r") as jf:
                self._config_json = json.load(jf)
            return self._config_json
    
    def print_cmd(self, cmd):
        if self.verbosity <= 0: return
        
        if len(cmd) >= 2 and cmd[0] == cmd[1]:
            cmd = cmd[1:]
        
        cmd_str = " ".join(cmd)
        print(f"$> {cmd_str}")
            

    def __run_subpro(self, fn, cmd_args, *args, **kwargs):
        if self.dry_run and not ("override" in kwargs and kwargs["override"]) :
            cmd_args = ["echo"] + [f"'{a}'" for a in cmd_args]
            if "stdout" in kwargs: del kwargs["stdout"]
        if "override" in kwargs: del kwargs["override"]
        return fn(cmd_args, *args, **kwargs)
    
    def call(self, *args, **kwargs):
        self.print_cmd(args[0])
        if self.dry_run and not ("override" in kwargs and kwargs["override"]): return
        if "override" in kwargs: del kwargs["override"]
        return call(*args, **kwargs)
    
    def check_call(self, *args, **kwargs):
        self.print_cmd(args[0])
        if self.dry_run and not ("override" in kwargs and kwargs["override"]): return
        if "override" in kwargs: del kwargs["override"]
        return check_call(*args, **kwargs)
    
    def execv(self, cmd, args, override=False):
        self.print_cmd([cmd] + args)
        if self.dry_run and not override: return
        
        os.execv(cmd, args)

def parse_server_name(server: str) -> Tuple[Optional[str], Optional[Path]]:
    if server.find(":") == -1:
        return (server, None)
    
    srv, fl, *err = server.split(":")
    if len(err) > 0:
        return (None, None)
    else:
        return (srv, Path(fl))
    



def send_to_master(config: Config, args: argparse.Namespace, return_output=False):
    # create a "unique" file on the server using the client mac address, process number, and timestamp
    req_file = Path(tempfile.gettempdir()) / f"req_{uuid.getnode()}_{os.getpid()}_{time.time()}.json"
    
    filtered_args = { k: v for k, v in vars(args).items() if k not in "master,minion,redirect_form".split(",") }
    
    with tmpfile(req_file):
        with open(req_file, "w") as tmp_file:
            json.dump(filtered_args, tmp_file)
        # scp the file to the server
        config.check_call(["scp", req_file, f"{config.minion_username}@{config.minion_hostname}:/tmp/{req_file.parts[-1]}"], stdout=DEVNULL, override=True)
        # and finally, run the command
        args = (["ssh", f"{config.minion_username}@{config.minion_hostname}", EXEC_NAME, f"--redirect-form /tmp/{req_file.parts[-1]}"], )
        if return_output:
            return config.check_output(*args, override=True).decode()
        else:
            config.check_call(*args, override=True)

def server_fn(fn: Callable[[argparse.Namespace], int]):
    @functools.wraps(fn)
    def _server_fn(config: Config, args: argparse.Namespace):
        if config.is_master:
            fn(config, args)
        else:
            send_to_master(config, args)
            
    return _server_fn


@server_fn
def ls_fn(config, args):
    if args.json:
        print(json.dumps(config.config_json["servers"]))
    else:
        for srv in config.config_json["servers"]:
            print(f"{srv['id']:>30} -- {srv['username']}@{srv['hostname']}")

def mk_sshvnc_fn(protocol: str):
    def _fn(config, args):
        if args.server_name is None:
            if config.is_master:
                # url of myself?
                uname = os.uname()
                username = getpass.getuser()
                hostname = os.uname().nodename
            else:
                username = config.minion_username
                hostname = config.minion_hostname
        else:
            if config.is_master:
                # lookup the hostname
                try:
                    serv = next(serv for serv in config.config_json["servers"] if serv["id"] == args.server_name)
                except StopIteration:
                    exit(f"Unknown server name '{args.server_name}'")
                username = serv["username"]
                hostname = serv["hostname"]
            else:
                # ask the master
                args2 = deepcopy(args)
                args2.print_url = True
                res = send_to_master(config, args2, return_output=True)
                # parse it
                _, res = res.strip().split("://")
                username, hostname = res.split("@")
        
        if args.print_url:
            print(f"{protocol}://{username}@{hostname}")
        else:
            # actually ssh
            call(["echo", f"{protocol}", f"{username}@{hostname}"])
            if protocol == "ssh":
                config.execv("/usr/bin/ssh", ["/usr/bin/ssh", f"{username}@{hostname}"])
            else:
                config.execv("/usr/bin/open", ["/usr/bin/open", f"vnc://{username}@{hostname}"])
    return _fn


@server_fn
def rsync_fn(config, args):
    print(args)
    srv, srv_fl = parse_server_name(args.from_server)
    if srv_fl is None:
        error("Unable to parse server name and file" if srv is None else "Please provide a file name to rsync")
    clt, clt_fl = parse_server_name(args.to_server)
    if clt_fl is None:
        clt_fl = srv_fl.parent
    
    # lookup the server and client
    try:
        srv = next(serv for serv in config.config_json["servers"] if serv["id"] == srv)
        clt = next(serv for serv in config.config_json["servers"] if serv["id"] == clt)
    except StopIteration:
        error("Unable to find server or client name")
    srv = f"{srv['username']}@{srv['hostname']}"
    clt = f"{clt['username']}@{clt['hostname']}"
    
        
    with tempfile.TemporaryDirectory() as tmp_dir:
        # get the file
        print(tmp_dir)
        config.check_call(["/usr/bin/rsync", "-avz", f"{srv}:{srv_fl}", tmp_dir], stdout=DEVNULL)
        
        # send the file
        tmp_fl = Path(tmp_dir) / srv_fl.name
        config.check_call(["/usr/bin/rsync", "-avz", f"{tmp_fl}", f"{clt}:{clt_fl}"])
    

def not_implemented(config, args):
    error("Not implemented yet")

handlers = {
        "ls": ls_fn,
        "ssh": mk_sshvnc_fn("ssh"),
        "vnc": mk_sshvnc_fn("vnc"),
        "rsync": rsync_fn,
        "send": not_implemented,
        "get": not_implemented,
        }

def main(args):
    
    if args.redirect_form is not None:
        # override all the args with this form.
        rf = Path(args.redirect_form)
        with rf.open("r") as fm:
            args_dict = json.load(fm)
        # delete the form
        rf.unlink()
            
        args = argparse.Namespace()
        args.__dict__.update(args_dict)
        # fix the missing args
        if "master" not in args:
            args.master = None
        if "minion" not in args:
            args.minion = None
        
    # figure out if we're the client of the server
    if args.master is not None and args.minion is not None:
        exit("Can't be master and minion at the same time")
        
    master_config = Path(args.master if args.master is not None 
            else os.environ.get("SERVER_MASTER_CONFIG" ,"~/.server_config.json")).expanduser().resolve()
    if args.master is not None and not master_config.is_file():
        exit("The master config file must be readable json file. Run with --help for the required format")
    elif not master_config.is_file():
        master_config = None
    
    try:
        minion_hostname, minion_username = (args.minion if args.minion is not None 
                else (os.environ["SERVER_MASTER_HOSTNAME"], os.environ["SERVER_MASTER_USERNAME"]))
    except KeyError:
        minion_hostname, minion_username = (None, None)
    
    if args.master is None and args.minion is None:
        is_master = master_config is not None
    else:
        is_master = args.master is not None
    
    # validation that we have the correct information
    if is_master and master_config is None:
        exit("Missing master configuration. Please provide a ~/.server-config.json file (see help for format)")
    elif not is_master and minion_hostname is None:
        exit("Missing master hostname and username. Please provide them with SERVER_MASTER_HOSTNAME and SERVER_MASTER_USERNAME environment variables")
        
        
    if "action" not in args:
        parser.main.print_help()
        exit()
    if args.action == "info":
        print(f"Running as {'master' if is_master else 'minion'}")
        if is_master:
            print(f"Will fetch list of minions from {master_config}")
        else:
            print(f"Will redirect most work to master at {minion_username}@{minion_hostname}")
        sys.exit(0)
    
    config = Config()
    config.is_master = is_master
    config.master_config = master_config
    config.minion_hostname = minion_hostname
    config.minion_username = minion_username
    config.dry_run = args.dry_run
    config.verbosity = 0 if args.silent else 1
    handlers[args.action](config, args)

if __name__ == "__main__":
    main(parser.main.parse_args())
