#!/bin/bash

# make sure there are at least 1 argument passed
if [ $# -eq 0 ]; then
	echo "Please provide at least one process name"
	exit 1
fi

# caffienate all the processes passed
for process in $@ ; do
	# get the PID
	pid=$(ps -A | egrep -i $process | head -n 1 | awk '{print $1}')
	echo "Caffeinating \"$(ps -A | egrep -i $process | head -n 1)\""
	caffeinate -d -w $pid & disown
done
