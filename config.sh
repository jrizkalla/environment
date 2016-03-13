#!/bin/bash

env="$HOME/environment"

if [ $# -eq 1 ]; then
    env="$1"
fi

echo "Settings up environment in $env"

# Set up the links
ln -s "$env/bash/bash_profile.sh" "$HOME/.bash_profile"
ln -s "$env/zsh/zshrc" "$HOME/.zshrc"
ln -s "$env/vimconfig/vimrc" "$HOME/.vimrc"
ln -s "$env/vimconfig" "$HOME/.vim"
ln -s "$env/bash/tmux.conf.sh" "$HOME/.tmux.conf"

# Change .bash_profile
echo -e "\n# Created by .config\nexport PATH=\"\$PATH:$env/bin\"\nexport PYTHONPATH=\"\$PYTHONPATH:$env/python\"" > "$env/bash/env_bash_profile.sh"
echo -e "export ENV=\"$env\"\nsource csconfig cs" >> "$env/bash/env_bash_profile.sh"

ln -s "$env/bash/env_bash_profile.sh" "$HOME/.env_bash_profile"

echo "Settings up links in $env/bin"

ln -F -s "$env/bash/pid.sh" "$env/bin/pid"
ln -F -s "$env/bash/settitle.sh" "$env/bin/settitle"
ln -F -s "$env/bash/trash.sh" "$env/bin/trash"
ln -F -s "$env/bash/waitforprocess.sh" "$env/bin/waitforprocess"
ln -F -s "$env/bash/csconfig.sh" "$env/bin/csconfig"
ln -F -s "$env/bash/log.sh" "$env/bin/flog"
ln -F -s "$env/bash/tmuxhome.sh" "$env/bin/tmuxhome"
ln -F -s "$env/bash/lock.sh" "$env/bin/lock"

ln -F -s "$env/python/tree.py" "$env/bin/tree"
ln -F -s "$env/python/passwordgen.py" "$env/bin/passwordgen"

