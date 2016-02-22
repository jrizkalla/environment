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


echo "Removing all links in $env/bin"
for file in $(ls "$env/bin"); do
    if [ -L "$env/bin/$file" ]; then
        rm -f "$env/bin/$file"
    fi
done
