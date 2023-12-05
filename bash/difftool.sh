#!/usr/bin/env bash


# Simple wrapper around git difftool that doesn't spam the output with
# a million vimdiff commands

GIT_DIFF="git diff"

git status > /dev/null
if [ $? -ne 0 ]; then exit $?; fi

# go to the root or git diff --name-only won't work properly
cd "$(git rev-parse --show-toplevel)"

FZF_PREVIEW="git diff $@ --color=always -- {-1}"

fls_str="$($GIT_DIFF --name-only $@)"
if [ $? -ne 0 ]; then exit $?; fi

IFS=$'\n' read -ra fls -d '\0' <<< "$fls_str"
unset IFS

if [ "${#fls[@]}" -eq 0 ]; then
    echo "No diff"
    exit 0
fi
    

fls_orig=("${fls[@]}")  


# make everything yellow
for i in "${!fls[@]}"; do
    fls[$i]=$"\e[33m"
    fls[$i]+="${fls_orig[$i]}"
    fls[$i]+=$"\e[0m"
done

function search_arr {
    needle="$1"
    shift
    haystack=("$@")
    
    for i in "${!haystack[@]}"; do
        if [ "$needle" == "${haystack[$i]}" ]; then
            echo $i
            return 0
        fi
    done
    return 1
}


while [ 1 ]; do
    fl="$(printf '%b\n' "${fls[@]}" | fzf --no-sort --no-multi --ansi --preview "$FZF_PREVIEW")"
    if [ -z "$fl" ]; then
        # empty file. Exit
        exit 0
    fi

    # just in case diff quits immediately. Time it and add a read if it's too short
    clear
    START_TIME=$(date +%s)
    $GIT_DIFF "$@" -- "$fl"
    END_TIME=$(date +%s)
    if [ $(($END_TIME - $START_TIME)) == 0 ]; then
        read
    fi

    # mark the file as viewed by changing it's color
    idx=$(search_arr $fl "${fls_orig[@]}")
    if [ $? -ne 0 ]; then 
        echo "Fatal error"
        exit 1
    fi
    
    # change the color of that file
    
    fls[$idx]=$"\e[32m"
    fls[$idx]+="${fls_orig[$idx]}"
    fls[$idx]+=$"\e[0m"
    
done

