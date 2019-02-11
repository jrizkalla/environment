#!/bin/bash

verbosity=1
out_log="/tmp/env-config.out.log"
err_log="/tmp/env-config.err.log"

last_log=$(mktemp)
last_err=$(mktemp)

function cleanup() {
    rm -f $last_log
    rm -f $last_err
}
trap cleanup EXIT

err_clr="\033[0;31m"
clr_clr="\033[0m"

function run () {
    if [ $verbosity -ge 1 ]; then
        echo -e "\033[1mRunning" "$@" "\033[0m"
    fi
    
    $@ > $last_log 2>> $last_err
    ret=$?
    cat $last_log >> $out_log
    cat $last_err >> $err_log
    if [ $ret -ne 0 ]; then
        echo -e "\033[0;31mError. Command failed with error code $ret\033[0m"
        echo "Stdout: "
        cat $last_log | sed 's/^/  /'
        echo "Stderr: "
        cat $last_err | sed 's/^/  /'
        
        echo "View full log at $out_log and $err_log"
        exit $ret
    fi
    if [ $verbosity -ge 2 ]; then
        echo "Stdout: "
        cat $last_log | sed 's/^/  /'
    fi
    if [ $verbosity -ge 3 ]; then
        echo "Stderr: "
        cat $last_err | sed 's/^/  /'
    fi
}

# clear log files
echo '' > $out_log
echo '' > $err_log

# Is brew isntalled?
type brew >/dev/null 2>&1
ret=$?
if [ $ret -ne 0 ]; then
    echo "Installing Homebrew..."
    run /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

type brew >/dev/null 2>&1
if [ $? -eq 0 ]; then
    run brew install fzf
    run brew install macvim --with-override-system-vim
    run brew install python3
    run brew install tmux
else
    echo "Not installing fzf, macvim, python3, and tmux because brew is missing"
fi

type tmux >/dev/null 2>&1
if [ $ret -ne 0 ]; then
    echo "Installing tmux"
    run brew install tmux
fi

env="$HOME/environment"
export ENV="$env"

if [ $# -eq 1 ]; then
    env="$1"
fi

echo "Settings up environment in $env"

# Set up the links (ignoring errors)
ln -f -s "$env/bash/bash_profile.sh" "$HOME/.bash_profile"
ln -f -s "$env/zsh/zshrc" "$HOME/.zshrc"
ln -f -s "$env/vim/vimrc" "$HOME/.vimrc"
ln -f -s "$env/vim" "$HOME/.vim"
ln -f -s "$env/tmux" "$HOME/.tmux"
ln -f -s "$env/wm/khdrc" "$HOME/.khdrc"
ln -f -s "$env/wm/chunkwmrc" "$HOME/.chunkwmrc"

# tmux links
ln -f -s "$env/tmux/tmux.conf.sh" "$HOME/.tmux.conf"

# Change .bash_profile
echo -e "\n# Created by .config\nexport PATH=\"\$PATH:$env/bin:$env/C/bin\"\nexport PYTHONPATH=\"\$PYTHONPATH:$env/python\"" > "$env/bash/env_bash_profile.sh"
echo -e "export ENV=\"$env\"\n" >> "$env/bash/env_bash_profile.sh"
if [ $(uname) = 'Linux' ]; then
    echo -e 'export TRASH_DIR="$HOME/.local/share/Trash"' >> "$env/bash/env_bash_profile.sh"
fi
echo -e "export OSA_LIBRARY_PATH=\"$env/jxa/lib\"" >> "$env/bash/env_bash_profile.sh"

ln -s "$env/bash/env_bash_profile.sh" "$HOME/.env_bash_profile"

echo "Settings up links in $env/bin"

ln -f -s "$env/bash/pid.sh" "$env/bin/pid"
ln -f -s "$env/bash/settitle.sh" "$env/bin/settitle"
ln -f -s "$env/bash/trash.sh" "$env/bin/trash"
ln -f -s "$env/bash/waitforprocess.sh" "$env/bin/waitforprocess"
ln -f -s "$env/bash/csconfig.sh" "$env/bin/csconfig"
ln -f -s "$env/bash/tmux-default-command.sh" "$env/bin/tmux-default-command"
ln -f -s "$env/bash/pretty.sh" "$env/bin/pretty"
ln -f -s "$env/bash/tmuxnew.sh" "$env/bin/tmuxnew"
ln -f -s "$env/bash/compose.sh" "$env/bin/compose"

ln -f -s "$env/python/tree.py" "$env/bin/tree"
ln -f -s "$env/python/passwordgen.py" "$env/bin/passwordgen"
ln -f -s "$env/python/music.py" "$env/bin/play"
ln -f -s "$env/python/mkgitignore.py" "$env/bin/mkgitignore"
ln -f -s "$env/python/radartitle.py" "$env/bin/radartitle"
ln -f -s "$env/python/run_cmd.py" "$env/bin/cmd"

ln -f -s "$env/tmux/scripts/tmuxhome.sh" "$env/bin/tmuxhome"

# Compile C files
echo "Compiling C programs..."
cd "$env/C/"
run make

# Download Vim plugins
run vim +PlugInstall +qall

# Install tmux plugin manager
run git clone https://github.com/tmux-plugins/tpm "$env/tmux/plugins/tpm"
# install zsh plugins
run "$env/zsh/install-plugins.sh"

# install tmux plugins
run "$env/tmux/plugins/tpm/bin/install_plugins"
