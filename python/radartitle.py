#!/usr/bin/env python3
from pathlib import Path
import json
from subprocess import check_output
import sys

GET_TITLE_SCRIPT = """
tell application "Radar"
    GetProblemData columnNames "problemtitle" problemID "{}"
end tell
"""

DICT_FILE = Path.home() / ".radar_names"

def get_title(id_):
    try:
        with open(DICT_FILE, "r") as df:
            problems = json.load(df)
    except FileNotFoundError:
        problems = {}
        
    try:
        return problems[id_]
    except KeyError:
        # fetch it from Radar
        
        script = GET_TITLE_SCRIPT.format(id_)
        title = check_output(f"osascript -e '{script}'", shell=True).decode().strip()
        problems[id_] = title
        # flush dictionary
        try:
            with open(DICT_FILE, "w") as df:
                json.dump(problems, df)
        except: pass
        
        return title


if __name__ == "__main__":
    print(get_title(sys.argv[1]))
