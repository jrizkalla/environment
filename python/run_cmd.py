#!/usr/bin/env python3
"""
Save commands with a description and run them later
"""

import os
import sys
import json
import subprocess
from pathlib import Path
import argparse
from typing import *
from datetime import datetime
from dataclasses import dataclass

@dataclass
class Command:
    __keys = "name desc command date".split(" ")
    name: str
    desc: str
    command: str
    date: datetime
    
    def to_dict(self) -> Dict[str, Any]:
        d = { k : self.__dict__[k] 
                for k in type(self).__keys }
        d["date"] = d["date"].isoformat()
        return d
    
    @classmethod
    def from_dict(cls, d: Dict[str, Any]) -> "Command":
        attrs = {}
        for k in cls.__keys:
            attrs[k] = d[k]
        attrs["date"] = datetime.fromisoformat(attrs["date"])
        return Command(**attrs)
    
class Database:
    def __init__(self, loc):
        self.loc = loc
        try:
            with open(loc, "r") as cf:
                self.cmds = json.load(cf)
        except FileNotFoundError:
            # empty db
            self.cmds = {}

    def add(self, cmd: Command, override: Union[bool, Callable[[], bool]]=False):
        lname = cmd.name.lower().strip()
        
        if lname in self.cmds:
            if not isinstance(override, bool):
                _override = override()
            if not _override:
                raise KeyError(f"'{name}' already defined")
        self.cmds[lname] = cmd.to_dict()
        self.save()
    
    def get(self, name: str) -> Command:
        cmd = self.cmds[name.lower().strip()]
        return Command.from_dict(cmd)
    
    def save(self):
        # convert cmds
        with open(self.loc, "w") as cf:
            json.dump(self.cmds, cf, indent=4)

    def __iter__(self):
        for _, cmd in self.cmds.items():
            yield Command.from_dict(cmd)



def _no_cmd(db: Database, args) -> int:
    parser.print_help()
    return 0

def _list(db: Database, args) -> int:
    if args.names:
        fmt = "{cmd.name}"
    elif args.date:
        fmt = "({cmd.date.year}/{cmd.date.month}/{cmd.date.day}) {cmd.name:>20} -- {cmd.desc}"
    else:
        fmt = "{cmd.name:>15} -- {cmd.desc}"
    for cmd in db:
        print(fmt.format(cmd=cmd))

def _save(db: Database, args) -> int:
    cmd = Command(args.name, args.desc, " ".join(args.command), datetime.now())
    def _override():
        answer = input(f"Command '{cmd.name}' already exists. Override it? (y/n) ")
        return answer.lower().strip() == "y"
    try:
        db.add(cmd, override=_override)
    except KeyError as e:
        print("Refusing to override. Exiting.")
    
def _run(db: Database, args) -> int:
    # lookup the command
    try:
        cmd = db.get(args.name)
        if not args.silent:
            print(f"\033[1m{cmd.command}\033[0m")
        res = subprocess.run(cmd.command, shell=True)
        return res.returncode
    except KeyError:
        print(f"Unable to find command '{args.name}'")
        return 1

def _view(db: Database, args) -> int:
    try:
        cmd = db.get(args.name)
    except KeyError:
        print(f"Unable to find command '{args.name}'")
        return 1
    
    out = ""
    if not any((args.all, args.date, args.desc, args.cmd)):
        args.all = True
        
    if args.all or args.date:
        out += f"{cmd.date.strftime('%Y/%m/%d %I:%M %p')}\n"
    if args.all or args.desc:
        out += f"{cmd.desc}\n"
    if args.all or args.cmd:
        out += f"{cmd.command}\n"
    
    end = "\n" if out == "" else ""
    print(out, end=end)
        
        

parser = argparse.ArgumentParser(description="Save commands and run them later")
subparsers = parser.add_subparsers()
parser.set_defaults(__func=_no_cmd)
        
list_parser = subparsers.add_parser("list", help="View list of commands")
list_parser.set_defaults(__func=_list)
list_parser.add_argument("--names", action="store_true", default=False, help="List saved command names only")
list_parser.add_argument("-d", "--date", action="store_true", default=False, help="Print the dates.")

run_parser = subparsers.add_parser("run", help="Run a command")
run_parser.set_defaults(__func=_run)
run_parser.add_argument("name", help="Command to run.")
run_parser.add_argument("-s", "--silent", action="store_true", default=False, help="Don't print anything other than the command output.")

save_parser = subparsers.add_parser("save", help="Save a command")
save_parser.set_defaults(__func=_save)
save_parser.add_argument("-d", "--desc", default="", help="Provide a description.")
save_parser.add_argument("name", help="The name of the command")
save_parser.add_argument("command", nargs="*", help="The command and it's argument.")


view_parser = subparsers.add_parser("view", help="View details about a command")
view_parser.set_defaults(__func=_view)
view_parser.add_argument("name", help="Command to view.")
view_parser.add_argument("-a", "--all", action="store_true", default=False, help="View all attributes of a command.")
view_parser.add_argument("-e", "--desc", action="store_true", default=False, help="View description.")
view_parser.add_argument("-d", "--date", action="store_true", default=False, help="View date.")
view_parser.add_argument("-c", "--cmd", action="store_true", default=False, help="View command.")


def main(args):
    db_loc = Path(os.environ.get("SAVED_COMMANDS", Path.home() / ".saved_commands")).expanduser()
    db = Database(db_loc)
    
    return args.__func(db, args)
    
if __name__ == "__main__":
    sys.exit(main(parser.parse_args()))
