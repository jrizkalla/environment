env="$HOME/environment"

if [ $# -eq 1 ]; then
    env="$1"
fi

if [ -L "$HOME/.bash_profile" ]; then
    rm -f "$HOME/.bash_profile"
fi
if [ -L "$HOME/.vimrc" ]; then
    rm -f "$HOME/.vimrc"
fi
if [ -L "$HOME/.vim" ]; then
    rm -f "$HOME/.vim"
fi
if [ -L "$HOME/.env_bash_profile" ]; then
    rm -f "$HOME/.env_bash_profile"
fi
if [ -L "$HOME/.zshrc" ]; then
    rm -f "$HOME/.zshrc"
fi
if [ -L "$HOME/.tmux.conf" ]; then
    rm -f "$HOME/.tmux.conf"
fi
if [ -L "$HOME/.tmux" ]; then
    rm -f "$HOME/.tmux"
fi


echo "Removing all links in $env/bin"
for file in $(ls "$env/bin"); do
    if [ -L "$env/bin/$file" ]; then
        rm -f "$env/bin/$file"
    fi
done

rm -f "$HOME/.radar_names"

echo "Removing $env/bash/env_bash_profile.sh"
rm -f "$env/bash/env_bash_profile.sh"

echo "Removing compiled C files at $env/C/bin/"
rm -f "$env/C/bin/"*

echo "Removing downloaded vim plugins"
rm -rf vim/plugins/*

echo "Removing Zsh plugins"
rm -rf zsh/plugins/*
