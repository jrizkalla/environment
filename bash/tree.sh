#!/bin/bash


# This script prints all of the current directory (recursively) as a tree

colors="true"
function printDir() {
	if [ $colors == "true" ]; then
		echo -e -n "\x1b[0;;36m"
		echo $@
		echo -e -n "\x1b[0;0m"
	else
		echo $@
	fi
}

function printBlockedDir () {
	if [ $colors == "true" ]; then
		echo -e -n "\x1b[0;;34m"
		echo $@
		echo -e -n "\x1b[0;0m"
	else
		echo $@
	fi
}

function printError () {
	if [ $colors == "true" ]; then
		echo -e -n "\x1b[0;;31m"
		echo $@
		echo -e -n "\x1b[0;0m"
	else
		echo $@
	fi
}


function printHelpMessage() {
	echo "use tree [args]"
	echo "args:"
	echo -e "\t-h        \tprints this help message";
	echo -e "\t-c        \tdon't use colors";
	echo -e "\t-p        \tprints the full path of the files not just their names"
	echo -e "\t-f format \tchanges the string used to indicate the levels to format"
	echo -e "\t-l num    \tDescends maximum num levels"
}

fullPath="false"
space="  "
maxLevels=999999999 # infinity?

#read the global variables
args=( "$@" )
i=0
while [ $i -lt $# ]; do
	if [ ${args[$i]} == "-h" ]; then
		printHelpMessage
		exit 0
	elif [ ${args[$i]} == "-p" ]; then
		fullPath="true"
	elif [ ${args[$i]} == "-c" ]; then
		colors="false"
	elif [ ${args[$i]} == "-f" ]; then
		# read the next arg
		if [ $(($i + 1)) -eq $# ]; then
			printError "Missing argument for -f. Use -h for help"
			exit 1
		fi
		i=$(($i + 1))
		space=${args[$i]}
	elif [ ${args[$1]} == "-l" ]; then
		#read the next arg
		if [ $(($i + 1)) -eq $# ]; then
			printError "Missing argument for -l. Use -h for help"
			exit 1
		fi
		i=$(($i + 1))
		maxLevels=${args[$i]}
	else
		printError "Unrecognized argument. Use -h for help"
		exit 1
	fi
	i=$(($i + 1))
done


function printFiles () {
	if [ $fullPath == "true" ]; then
		ls -d -1 $PWD/** 2>/dev/null
	else
		ls
	fi
}

indentLevel="0";


function printIndent() {
	i=0;
	while [ $i -lt $indentLevel ]; do
		echo -n -e "$space"
		i=$(($i + 1))
	done
}


level=-1
# prints the current directory
function printDirectory() {
	level=$(($level + 1))
	if [ $level -ge $maxLevels ]; then
		level=$(($level - 1))
		return
	fi

	for dir in $(printFiles) ; do 
		if [ -d $dir ]; then
			
			printIndent
			cd $dir 2>/dev/null
			if [ $? -eq 0 ]; then # we can go in the directory, continue
				cd ..

				printDir $dir
				# recurse on $dir
				indentLevel=$(($indentLevel + 1))
				cd $dir
				printDirectory;
				cd ..
				indentLevel=$(($indentLevel - 1))

			else 
				#the directory is blocked for some reason
				printBlockedDir $dir
			fi
			
		else 
			printIndent;
			echo $dir
		fi
	done
	level=$(($level - 1))
}

printDirectory
