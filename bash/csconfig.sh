#/bin/bash

printRed () {
	echo -e -n "\x1b[0;;31m"
	echo $@
	echo -e -n "\x1B[0;0m"
}

# Read the command name
com="cs"
if [ $# -eq 1 ]; then
    com=$1
fi

if [ $# -gt 1 ]; then
    printRed "Usage: source csconf [command name]";
    return 1;
fi

cs_function_wrapper(){
    dir=""
    if [ $# -eq 0 ]; then
        dir="$HOME"
    elif [ $# -eq 1 ]; then
        dir="$1"
    else
        printRed "Usage: cs [directory]";
        return 1;
    fi

    cd "$dir"
    retCode=$?;
    if [ $retCode -ne 0 ]; then
        echo "cd failed with return code " $retCode;
        return $retCode;
    fi

    ls -G .
}

alias $com='cs_function_wrapper'
