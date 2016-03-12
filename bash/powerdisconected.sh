#!/bin/bash


flog "Killing Spotify"
for process in $(pgrep -i Spotify); do
    flog "killing process $process"
    kill -SIGTSTP $process 2>&1 | flog
done

flog "Unmounting hard drive..."
diskutil unmount John  > ~/.log_file 2>&1
diskutil unmount Documents > ~/.log_file 2>&1 
flog "Done unmounting"

#/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend
