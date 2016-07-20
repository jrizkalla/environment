#!/bin/bash

function print_help {
    >&2 echo -e 'Pretty: make output of commands pretty using Vim'
    >&2 echo -e 'Commands:'
    >&2 echo -e '\tls (default args: -lhF)'
}

if [ $# -lt  1 ]; then
    >&2 echo 'Error: missing command.'
    print_help
    exit 1
fi

if [ $1 == 'ls' ]; then
    $1 -lhF ${@:2} | view - --cmd 'let g:fast_startup=1' +'set ft=prls'
fi
