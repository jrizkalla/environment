#!/bin/bash

env="$HOME/environment"

if [ $# -eq 1 ]; then
    env="$1"
fi

echo "Settings up environment in $env"

# Set up the links
ln -s "$env/bash/bash_profile.sh" "$HOME/.bash_profile"
ln -s "$env/zsh/zshrc" "$HOME/.zshrc"
ln -s "$env/vim/vimrc" "$HOME/.vimrc"
ln -s "$env/vim" "$HOME/.vim"
ln -s "$env/tmux" "$HOME/.tmux"

# tmux links
ln -s "$env/tmux/tmux.conf.sh" "$HOME/.tmux.conf"

# Change .bash_profile
echo -e "\n# Created by .config\nexport PATH=\"\$PATH:$env/bin:$env/C/bin\"\nexport PYTHONPATH=\"\$PYTHONPATH:$env/python\"" > "$env/bash/env_bash_profile.sh"
echo -e "export ENV=\"$env\"\nsource csconfig cs" >> "$env/bash/env_bash_profile.sh"
if [ $(uname) = 'Linux' ]; then
    echo -e 'export TRASH_DIR="$HOME/.local/share/Trash"' >> "$env/bash/env_bash_profile.sh"
fi
echo -e "export OSA_LIBRARY_PATH=\"$env/jxa/lib\"" >> "$env/bash/env_bash_profile.sh"

ln -s "$env/bash/env_bash_profile.sh" "$HOME/.env_bash_profile"

echo "Settings up links in $env/bin"

ln -F -s "$env/bash/pid.sh" "$env/bin/pid"
ln -F -s "$env/bash/settitle.sh" "$env/bin/settitle"
ln -F -s "$env/bash/trash.sh" "$env/bin/trash"
ln -F -s "$env/bash/waitforprocess.sh" "$env/bin/waitforprocess"
ln -F -s "$env/bash/csconfig.sh" "$env/bin/csconfig"
ln -F -s "$env/bash/tmux-default-command.sh" "$env/bin/tmux-default-command"
ln -F -s "$env/bash/pretty.sh" "$env/bin/pretty"

ln -F -s "$env/python/tree.py" "$env/bin/tree"
ln -F -s "$env/python/passwordgen.py" "$env/bin/passwordgen"
ln -F -s "$env/python/music.py" "$env/bin/play"
ln -F -s "$env/python/mkgitignore.py" "$env/bin/mkgitignore"

ln -F -s "$env/tmux/scripts/tmuxhome.sh" "$env/bin/tmuxhome"


# Compile C files
echo "Compiling C programs..."
cd "$env/C/"
make
