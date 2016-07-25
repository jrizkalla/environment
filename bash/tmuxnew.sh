#!/bin/bash

session_name=''
start_directory=''

if [ $# -ge 1 ]; then
    session_name="$1"
fi
if [ $# -ge 2 ]; then
    start_directory="$2"
fi

tmux_detatch='-d'
if [ -z "$TMUX" ]; then
    tmux_detatch='';
fi
    

# Does session_name already exist?
if [ $(tmux list-sessions -F "#{session_name}" | egrep "$session_name" | wc -c) -eq 0 ]; then
    # Create a completely new session
    if [ -z "$start_directory" ]; then
        start_directory="$HOME"
    fi
    cd "$start_directory"
    echo tmux new-session -s "$session_name" $tmux_detatch
    tmux new-session -s "$session_name" $tmux_detatch
else
    # Just create a new session and attach it to the old one (group them)
    echo tmux new-session -t "$session_name" $tmux_detatch
    tmux new-session -t "$session_name" $tmux_detatch
fi
