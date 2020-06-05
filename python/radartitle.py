#!/usr/bin/env python3
from pathlib import Path
import json
from subprocess import check_output, CalledProcessError
import sys
import argparse

arg_parser = argparse.ArgumentParser(description="Get radar title from id by quering Radar")
arg_parser.add_argument("num", help="The radar id")
arg_parser.add_argument("--cache-only", action="store_true", default=False,
        help="Only check the local cache. Makes quering very quick")

GET_TITLE_SCRIPT = """
tell application "Radar"
    GetProblemData columnNames "problemtitle" problemID "{}"
end tell
"""

DICT_FILE = Path.home() / ".radar_names"

def get_title(num, cache_only):
    try:
        with open(DICT_FILE, "r") as df:
            problems = json.load(df)
    except FileNotFoundError:
        problems = {}
        
    try:
        return problems[num]
    except KeyError:
        if cache_only: raise
        # fetch it from Radar
        
        script = GET_TITLE_SCRIPT.format(num)
        title = check_output(f"osascript -e '{script}'", shell=True).decode().strip()
        if title.startswith("0\n"):
            raise CalledProcessError(0, "osascript")
        problems[num] = title
        # flush dictionary
        try:
            with open(DICT_FILE, "w") as df:
                json.dump(problems, df)
        except: pass
        
        return title


if __name__ == "__main__":
    try:
        print(get_title(**vars(arg_parser.parse_args())))
    except:
        sys.exit(1)
