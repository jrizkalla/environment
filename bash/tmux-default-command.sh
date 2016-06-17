#!/bin/sh

reat=$(which reattach-to-user-namespace 2> /dev/null)
if [ $? -eq 0 ]; then
    zsh="$(which zsh 2> /dev/null)"
    if [ $? -eq 0 ]; then
        $reat -l "$zsh"
    else
        $reat -l "/bin/bash"
    fi
else
    zsh="$(which zsh 2> /dev/null)"
    if [ $? -eq 0 ]; then
        zsh -l
    else
        bash="$(which bash 2>/dev/null)"
        if [ $? -eq 0 ]; then
            $bash -l
        else
            sh -l
        fi
    fi
fi
