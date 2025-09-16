#!/bin/bash

env="$HOME/environment"
export ENV="$env"
source $env/bash/pretty_script.sh

# Is brew installed?
type brew >/dev/null 2>&1
ret=$?
if [ $ret -ne 0 ]; then
    - /usr/bin/ruby -e \"\$\(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install\)\"
fi

type brew >/dev/null 2>&1
if [ $? -eq 0 ]; then
    - brew install fzf
    - brew install ripgrep
    - brew install highlight
    - brew install macvim
    - brew install python3
    - brew install tmux
    - brew install koekeishiya/formulae/yabai
    - brew install koekeishiya/formulae/skhd
    - brew install FelixKratz/formulae/borders
    - brew install jq
    - brew install jnv
    - brew install thefuck
else
    echo "Skipping brew install because brew is missing"
fi

checkpoint lns "Settings up environment in $env"

# Set up the links (ignoring errors)
- ln -f -s \"$env/bash/bash_profile.sh\" \"$HOME/.bash_profile\"
- ln -f -s \"$env/zsh/zshrc\" \"$HOME/.zshrc\"
- ln -f -s \"$env/vim/vimrc\" \"$HOME/.vimrc\"
- ln -f -s \"$env/vim\" \"$HOME/.vim\"
- ln -f -s \"$env/tmux\" \"$HOME/.tmux\"
- ln -f -s \"$env/dotfiles/yabairc\" \"$HOME/.yabairc\"
- ln -f -s \"$env/dotfiles/skhdrc\" \"$HOME/.skhdrc\"

# tmux links
- ln -f -s \"$env/tmux/tmux.conf.sh\" \"$HOME/.tmux.conf\"

# Change .bash_profile
echo -e "\n# Created by .config\nexport PATH=\"\$PATH:$env/bin:$env/C/bin\"\nexport PYTHONPATH=\"\$PYTHONPATH:$env/python\"" > "$env/bash/env_bash_profile.sh"
echo -e "export ENV=\"$env\"\n" >> "$env/bash/env_bash_profile.sh"
if [ $(uname) = 'Linux' ]; then
    echo -e 'export TRASH_DIR="$HOME/.local/share/Trash"' >> "$env/bash/env_bash_profile.sh"
fi
echo -e "export OSA_LIBRARY_PATH=\"$env/jxa/lib\"" >> "$env/bash/env_bash_profile.sh"

- ln -s "$env/bash/env_bash_profile.sh" "$HOME/.env_bash_profile"

echo "Settings up links in $env/bin"

- ln -f -s \"$env/bash/pid.sh\" \"$env/bin/pid\"
- ln -f -s \"$env/bash/settitle.sh\" \"$env/bin/settitle\"
- ln -f -s \"$env/bash/trash.sh\" \"$env/bin/trash\"
- ln -f -s \"$env/bash/waitforprocess.sh\" \"$env/bin/waitforprocess\"
- ln -f -s \"$env/bash/csconfig.sh\" \"$env/bin/csconfig\"
- ln -f -s \"$env/bash/tmux-default-command.sh\" \"$env/bin/tmux-default-command\"
- ln -f -s \"$env/bash/pretty.sh\" \"$env/bin/pretty\"
- ln -f -s \"$env/bash/tmuxnew.sh\" \"$env/bin/tmuxnew\"
- ln -f -s \"$env/bash/compose.sh\" \"$env/bin/compose\"
- ln -f -s \"$env/bash/openproj.sh\" \"$env/bin/openproj\"
- ln -f -s \"$env/bash/init_vim_on_ssh.sh\" \"$env/bin/init_vim_on_ssh\"
- ln -f -s \"$env/bash/difftool.sh\" \"$env/bin/difftool\"
- ln -f -s \"$env/bash/previewdockercontainer.sh\" \"$env/bin/previewdockercontainer\"
- ln -f -s \"$env/bash/previewoppassword.sh\" \"$env/bin/previewoppassword\"

- ln -f -s \"$env/python/tree.py\" \"$env/bin/tree\"
- ln -f -s \"$env/python/passwordgen.py\" \"$env/bin/passwordgen\"
- ln -f -s \"$env/python/music.py\" \"$env/bin/play\"
- ln -f -s \"$env/python/mkgitignore.py\" \"$env/bin/mkgitignore\"
- ln -f -s \"$env/python/radartitle.py\" \"$env/bin/radartitle\"
- ln -f -s \"$env/python/run_cmd.py\" \"$env/bin/cmd\"
- ln -f -s \"$env/python/build_script_finder.py\" \"$env/bin/bld\"
- ln -f -s \"$env/python/server.py\" \"$env/bin/srv\"
- ln -f -s \"$env/python/bs.py\" \"$env/bin/bs\"

- ln -f -s \"$env/tmux/scripts/tmuxhome.sh\" \"$env/bin/tmuxhome\"

# Compile C files
echo "Compiling C programs..."
cd "$env/C/"
+ make

# Download Vim plugins
+ vim +PlugInstall +qall

# Install tmux plugin manager
- git clone https://github.com/tmux-plugins/tpm "$env/tmux/plugins/tpm"
# install zsh plugins
+ \"$env/zsh/install-plugins.sh\"

# install tmux plugins
+ \"$env/tmux/plugins/tpm/bin/install_plugins\"
