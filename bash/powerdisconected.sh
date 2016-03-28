#!/bin/bash

source $HOME/.bash_profile

flog "Stopping the music"
play '||' #'+(0)'

echo 'tell current application
    set volume with output muted
    end tell' | osascript

flog "Unmounting hard drive..."
diskutil unmount John  2>&1 | flog
diskutil unmount Documents 2>&1 | flog
flog "Done unmounting"

#/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend
