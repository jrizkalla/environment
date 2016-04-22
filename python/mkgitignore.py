#!/usr/bin/env python

import sys;
import os;

files = {};

# Vim files
files["general"] = ["*.swp", "*.swo"];
# OS X files
files["general"] += [".DS_Store"];


files["tex"] = ["*.log", "*.aux", "*.toc", "*.out", "*.fls", "*.fdb_latexmk", "*.pdf", "*.dvi", "*.ps"];
files["latex"] = files["tex"];

files["c"] = ["*.d", "*.elf", "*.o", ".out", "*.map"];
files["c++"] = files["c"];
files["cpp"] = files["c"];
files["cc"] = files["c"];

files["java"] = ["*.class", "*.jar"];

files["python"] = ["*.py[cdo]"];
files["py"] = files["python"];


def printGitignore(*langs, **settings):
    '''
Prints a .gitignore file:

Params:
    *langs = the languages to print the .gitignore for
    **settings:
        - "subdirectoryLevel" - the level of subdirectores to print to (0 is for the current directory only). 0 by default
        - "outputStream" - the output stream to print to. sys.stdout by default
        
    Ignored files:
        - Vim files: .swp, .swo
        - OS X files: .DS_Store
        - LaTeX files: .log, .aux, .toc, .out, .fls, .fdb_latexmk, .pdf, .dvi
        - C/C++: .d, .elf, .map
    '''
    
    level = settings["subdirectoryLevel"] if settings.has_key("subdirectoryLevel") else 0;
    out = settings["outputStream"] if settings.has_key("outputStream") else sys.stdout;
    
    langs = ["general"] + list(langs);
    
    for lang in langs:
        lang = lang.lower();
        if not type(lang) is type(""):
            raise TypeError("Languages must all be strings");
        
        out.write("\n# " + lang + " files\n");
        for l in range(0, level+1):
            for file in (files[lang] if files.has_key(lang) else []):
                out.write(("*/" * l) + file + "\n");
            out.write("\n");
            
            
if __name__ == "__main__":
    def printHelp(out):
        out.write('''Usage: mkgitignore [-l <num>] [-o <output filename>] [-h] language [, language...]
Options:
    -l <num> level of subdirectories to include in the .gitignore
    -o <file> the output filename. The default is '.gitignore'
    --stdout output to stdout
    --stderr output to stderr
    -h print this help message
''');

    
    num = 0;
    outFile = ".gitignore"
    langs = [];
    i = 1;
    while i < len(sys.argv):
        if sys.argv[i] == "-h" or sys.argv[i] == "-help" or sys.argv[i] == "--help" or sys.argv[i] == "help":
            printHelp(sys.stdout);
            sys.exit(0);
        elif sys.argv[i] == "-l":
            try:
                num = int(sys.argv[i+1]);
            except:
                printHelp(sys.stderr);
                sys.exit(1);
            i += 1;
        elif sys.argv[i] == "-o":
            try:
                outFile = sys.argv[i+1];
            except:
                printHelp(sys.stderr);
                sys.exit(1);
            i += 1;
        elif sys.argv[i] == "--stdout":
            outFile = "/stdout"
        elif sys.argv[i] == "--stderr":
            outFile = "/stderr"
        else:
            langs += [sys.argv[i]];
        i += 1;
     
    if outFile == "/stdout":
        f = sys.stdout;
    elif outFile == "/stderr":
        f = sys.stderr;
    elif os.path.exists(outFile):
        sys.stdout.write("'%s' already exists. Do you want to override it, append it, or quit [oaq]? " % outFile);
        input = sys.stdin.readline();
        input = input.lower().strip();
        if input == "o" or input == "override":
            f = file(outFile, "w");
        elif input == "a" or input == "append" or input == "no" or input == "n":
            f = file(outFile, "a");
        else:
            sys.exit(30);
    else:
        f = file(outFile, "w");
        
    printGitignore(*langs, subdirectoryLevel=num, outputStream=f);
