#!/bin/bash

# Collect all strings passed in one string
str=""
for s in $@; do
    str+="$s "
done

if [ -n "$str" ]; then
    progName=$(basename $(ps -o comm=$PPID))
    echo -e "[$(date +%T)] $(ps -o comm= $PPID): $str" >> "$HOME/.log_file"
fi
