#!/usr/bin/env bash

git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ENV/zsh/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions "$ENV/zsh/plugins/zsh-autosuggestions"
ln -s "$ENV/zsh/my-plugins/complete_funcs" "$ENV/zsh/plugins/complete_funcs"
