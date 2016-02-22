#!/bin/bash

if [ $# -le 0 ]; then 
	echo "error! What process id?"
	exit 1
fi
ps -A | egrep -i $1 | head -n 1 | awk '{print $1}'

