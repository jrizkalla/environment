#!/usr/bin/env bash
# Script to install a basic Vimrc on a new system (over ssh)

if [ $# -ne 1 ]; then
    echo "Usage: $0 username@hostname[:port]" >&2
    exit 1
fi

hostname="$1"
vimrc="$(mktemp)"

function _cleanup {
    rm -f "$vimrc"
}

trap _cleanup EXIT

cat > "$vimrc" <<EOF

set nocompatible
syntax on
set number
set relativenumber

inoremap jk <esc>
inoremap jK <esc>
inoremap Jk <esc>
inoremap JK <esc>

set autoindent
set tabstop=4
set shiftwidth=4
set expandtab

set smartcase
set mouse=a

EOF

scp "$vimrc" "$hostname":~/.vimrc
