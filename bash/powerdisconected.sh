#!/bin/bash

logger -s Running powerdisconnected.sh 2>> ~/Library/Logs/scripts.log
source $HOME/.bash_profile

play '||' #'+(0)' 

echo 'tell current application
    set volume with output muted
    end tell' | osascript 2>&1 | logger -s 2>> ~/Library/Logs/scripts.log
    
diskutil unmount John  2>&1 | logger -s 2>> ~/Library/Logs/scripts.log
diskutil unmount Documents 2>&1 | logger -s 2>> ~/Library/Logs/scripts.log


#/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend
