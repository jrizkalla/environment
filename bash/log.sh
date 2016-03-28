#!/bin/bash

# Collect all strings passed in one string
str=""
for s in $@; do
    str+="$s "
done

progName="$(basename $(ps -o comm= $$))"
if [ -n "$str" ]; then
    echo -e "[$(date +%T)] $progName: $str" >> "$HOME/.log_file"
else
    # Read from stdin and echo to file
    while [ 1 ]; do
        read line
        if [ $? -ne 0 ]; then break; fi
        
        echo -e "[$(date +%T)] $progName: $line" >> "$HOME/.log_file"
    done
fi
