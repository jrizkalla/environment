#!/usr/bin/env python3

import sys
from pathlib import Path
from subprocess import check_output, run, PIPE
import json

def main(argv):
    
    if len(argv) > 2 and argv[1] == "add":
        script = argv[2]
        try:
            with (Path.home() / ".build.json").open("r") as json_file:
                scripts = json.load(json_file)
        except FileNotFoundError:
            scripts = {}
            
        full_path = Path(script).expanduser().absolute().resolve()
        curr_branch = check_output("git branch | grep --color=auto \* | cut -d ' ' -f2", shell=True).decode().strip()
        key = str(Path.cwd().absolute()) + ":" + curr_branch
        key = key.lower().strip()
        if key in scripts:
            resp = input("Warning. Script for {} exists. Override? (y/n) ".format(key))
            if not resp.lower() in ("yes", "y"):
                return 1
        
        scripts[key] = {
                "path": str(full_path),
                "args": argv[3:]
                }
        
        with (Path.home() / ".build.json").open("w") as json_file:
            json.dump(scripts, json_file, indent=2)
            
    elif len(argv) >= 2 and argv[1] == "show":
        
        curr_dir = Path.cwd().absolute()
        curr_branch = check_output("git branch | grep --color=auto \* | cut -d ' ' -f2", shell=True).decode().strip().lower()
        
        try:
            with (Path.home() / ".build.json").open("r") as json_file:
                scripts = json.load(json_file)
                
                
        # Walk up the directory tree
            dir_ = curr_dir
            while dir_ != Path("/"):
                script_id = str(dir_).lower() + ":" + curr_branch
                if script_id in scripts: break
                dir_ = dir_.parent
            
            script = scripts[str(dir_).lower() + ":" + curr_branch]
            if len(argv) > 2 and argv[2] in ("-a", "--all"):
                print("Script: {}\nArgs: {}".format(script["path"], script["args"]))
            else:
                print(script["path"])
        except:
            print("No script for current {} branch {}".format(curr_dir.name, curr_branch))
                    
    else:
        curr_dir = Path.cwd().absolute().resolve()
        curr_branch = check_output("git branch | grep --color=auto \* | cut -d ' ' -f2", shell=True).decode().strip().lower()
        
        try:
            with (Path.home() / ".build.json").open("r") as json_file:
                scripts = json.load(json_file)
        except FileNotFoundError:
            scripts = {}
            
        # Walk up the directory tree
        dir_ = curr_dir
        while dir_ != Path("/"):
            script_id = str(dir_).lower() + ":" + curr_branch
            if script_id in scripts: break
            dir_ = dir_.parent
            
        
        try:
            script = scripts[script_id]
        except KeyError:
            print("Error. Script for {} and branch {} doesn't exist.\n Use `{} add` to add one".format(curr_dir.name, curr_branch, argv[0]))
            return 1
            
        print(f"Running {[script['path']] + script['args'] + argv[1:]}")
        run([script["path"]] + script["args"] + argv[1:])

if __name__ == "__main__":
    sys.exit(main(sys.argv))
