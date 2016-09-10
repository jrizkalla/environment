#!/usr/bin/env python3

import sys
import os
from argparse import ArgumentParser, FileType

files = {}

# Vim files
files["general"] = ["*.sw[op]"]
# OS X files
files["general"] += [".DS_Store"]


files["tex"] = ["*.log", "*.aux", "*.toc", "*.out", "*.fls", "*.fdb_latexmk", "*.pdf", "*.dvi", "*.ps"]
files["latex"] = files["tex"]

files["c"] = ["*.d", "*.elf", "*.o", ".out", "*.map"]
files["c++"] = files["c"]
files["cpp"] = files["c"]
files["cc"] = files["c"]

files["java"] = ["*.class", "*.jar"]

files["python"] = ["*.py[cdo]", "__pychache__/*"]
files["py"] = files["python"]

files["xcode"] = ["DerivedData/*"]

files["swift"] = files["xcode"]


arg_parser = ArgumentParser(description='Generate gitignore.')
arg_parser.add_argument('langs', type=str, nargs='*', metavar='LANGUAGE [LANGUAGE [...] ]', help=\
        '''The languages to create the .gitignore for.''')
arg_parser.add_argument('-l', '--level', default=1, type=int, metavar='NUM',
        help='''The level of subdirectories to include in the gitignore (1 means current directory).
If NUM is -1, add all levels (required git >= 1.8.2).
The default is 1.''')
arg_parser.add_argument('-o', '--output', default='.gitignore', type=FileType('w'), 
        metavar='FILENAME', help='''The output filename. 
Ignored if --stdout or stderr is specified. The default is .gitignore.''')
arg_parser.add_argument('--stdout', action='store_true', help='''Write to stdout. Ignored if --stderr is specified''')
arg_parser.add_argument('--stderr', action='store_true', help='''Write to stderr. Never ignored.''')



def print_gitignore(*langs, **settings):
    '''
    Prints a .gitignore file:

    Params:
        *langs = the languages to print the .gitignore for
        **settings:
            - "subdirectory_level" - the level of subdirectores to print to (0 is for the current directory only). 0 by default
            - "output_stream" - the output stream to print to. sys.stdout by default
    '''
    
    level = settings.get('subdirectory_level', 0)
    out   = settings.get('output_stream', sys.stdout)
    
    langs = ["general"] + list(langs)
    
    for lang in langs:
        lang = lang.lower()
        if not type(lang) is str:
            raise TypeError("Languages must all be strings")
        
        out.write("\n# " + lang + " files\n")
        if level < 0:
            try:
                for f in files[lang]:
                    out.write('**/' + f + '\n')
            except KeyError: pass
        else:
            for l in range(0, level):
                try:
                    for f in files[lang]:
                        out.write(('*/' * l) + f + '\n')
                except KeyError: pass
                
            
def main(argv):
    ns = arg_parser.parse_args(argv[1:])
    
    if ns.stderr:
        output = sys.stderr
    elif ns.stdout:
        output = sys.stdout
    else:
        output = ns.output
        
    try:
        print_gitignore(*ns.langs, subdirectory_level=ns.level, output_stream=output)
    finally:
        ns.output.close()
            
if __name__ == "__main__":
    ret = main(sys.argv)
    sys.exit(ret if ret is not None else 0)
