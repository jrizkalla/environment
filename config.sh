
env="$HOME/environment"

if [ $# -eq 1 ]; then
    env="$1"
fi

echo "Settings up environment in $env"

# Set up the links
ln -s "$env/bash/bash_profile.sh" "$HOME/.bash_profile"
ln -s "$env/vimconfig/vimrc" "$HOME/.vimrc"
ln -s "$env/vimconfig" "$HOME/.vim"

# Change .bash_profile
echo -e "\n# Appended by .config\nexport PATH=\"\$PATH:$env/bin\"\nexport PYTHONPATH=\"\$PYTHONPATH:$env/python\"" >> "$env/bash/bash_profile.sh"

echo "Settings up links in $env/bin"

ln -F -s "$env/bash/pid.sh" "$env/bin/pid"
ln -F -s "$env/bash/settitle.sh" "$env/bin/settitle"
ln -F -s "$env/bash/trash.sh" "$env/bin/trash"
ln -F -s "$env/bash/waitforprocess.sh" "$env/bin/waitforprocess"
ln -F -s "$env/bash/csconfig.sh" "$env/bin/csconfig"

ln -F -s "$env/python/tree.py" "$env/bin/tree"
