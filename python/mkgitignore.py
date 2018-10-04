#!/usr/bin/env python3

from urllib import request as http
from urllib.parse import quote
import re
import typing as T
import sys
import argparse
from os import path
from itertools import chain

try:
    eval('f""')
except SyntaxError:
    print("Python 3.6 required", file=sys.stderr)


LIST_SEPERATOR = re.compile("[\s,]")
TMP_CACHE = "/tmp/mkgitignore_langs.txt"

def get_langs(url: str = "https://www.gitignore.io/api/list") -> T.Set[str]:
    try:
        with open(TMP_CACHE, "r") as tmp_file:
            return set(l.strip() for l in tmp_file.readlines())
    except:
        # fallback on the url
        resp = http.urlopen(url)
        if resp.getcode() != 200: 
            raise http.URLError(f"Error: {resp.getcode()} {resp.reason}")
        res = set(LIST_SEPERATOR.split(resp.read().decode().strip()))
        try:
            with open(TMP_CACHE, "w") as tmp_file:
                for r in res:
                    print(r, file=tmp_file)
        except: pass
        return res

def get_gitignore(langs: T.Iterable[str], base_url="https://www.gitignore.io/api/"):
    langs = list(langs)
    
    supported_langs = get_langs()
    
    for l in langs:
        if l not in supported_langs:
            raise Exception(f"language '{l}' is not supported by gitignore.io")
    # make sure that they're all supported
    
    query = quote(",".join(l.lower().strip() for l in langs))
    if query == "":
        return ""
    url = base_url + ("" if base_url[-1] == "" else "/") + query
    try:
        resp = http.urlopen(url)
    except:
        print(f"Failed to get url: {url}")
        raise
    
    if resp.getcode() != 200: 
        raise http.URLError(f"Error: {resp.getcode()} {resp.reason}")
    return resp.read().decode()

arg_parser = argparse.ArgumentParser(
        description="Download .gitignore from gitignore.io")
arg_parser.add_argument("langs", nargs="*", 
        help="Languages included in .gitignore")
arg_parser.add_argument("--list", action="store_true", default=False, 
        help="List supported languages and exit")
arg_parser.add_argument("-o", "--output",
        metavar="FILE", type=argparse.FileType("w"), 
        default=".gitignore", help="Output file")
arg_parser.add_argument("--bare", action="store_true", default=False,
        help="Don't add extra languages (like Vim and Mac OS)")

def main(langs, list, output, bare):
    if list:
        for lang in get_langs():
            print(lang)
    if not bare:
        langs = set(langs + "vim macos".split(" "))
    print(get_gitignore(langs), file=output)

if __name__ == "__main__":
    try:
        ret = main(**vars(arg_parser.parse_args()))
    except Exception as e:
        ret = 1
        print(f"Error: {e}")
    sys.exit(ret if ret is not None else 0)
