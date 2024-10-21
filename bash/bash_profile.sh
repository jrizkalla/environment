
alias X11Compile='g++ -L/usr/X11/lib -I/usr/X11/include -lX11'
alias bopen='open -g'
alias c='clear'
alias delete='\rm -i -r'
alias egrep='egrep --color=auto'
alias grep='grep --color=auto'
# Does ls accept -G or --color=auto for color?
ls -G > /dev/null 2>&1
if [ $? -eq 0 ]; then
    alias la='ls -G -A -F'
    alias ls='ls -G -F'
else
    alias la='ls --color=auto -A -F'
    alias ls='ls --color=auto -F'
fi
alias process='ps -A | egrep -i '
alias rm='trash'
#alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias linux="ssh jrizkall@linux.student.cs.uwaterloo.ca"
alias linux2="ssh jrizkall@ubuntu1604-002.student.cs.uwaterloo.ca"
alias linux4="ssh jrizkall@ubuntu1604-004.student.cs.uwaterloo.ca"
alias linux6="ssh jrizkall@ubuntu1604-006.student.cs.uwaterloo.ca"
alias glinux="ssh -X jrizkall@linux.student.cs.uwaterloo.ca"
alias xcode="open -a Xcode "
alias less="less -r"
alias stop="kill SIGTSTP"

alias pmux="./scripts/tmux.sh"

alias goback='echo "cd $BRANCH_FROM"; cd "$BRANCH_FROM"'

alias autolatex='latexmk -pdf -pvc -interaction=nonstopmode -synctex=1'
alias skim='open -a Skim'
alias glog="git log --decorate --graph --abbrev-commit"
alias slog="git log '--format=format:%C(auto)%h -- %C(cyan)%cN%C(auto) %cr%d%n  ↳ %s'"

function checkout {
    which bs > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        git_cmd="bs"
    else
        git_cmd="git"
    fi

    $git_cmd checkout $(git branch --list --format '%(refname:lstrip=2)' | fzf --query $@)
}

# Vim
# Is MacVim installed?
ls "/Applications/MacVim.app/Contents/MacOS/Vim" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    alias  vim="/Applications/MacVim.app/Contents/MacOS/Vim"
    alias mvim="mvim -p" # multiple tabs in vim
    alias cvim="mvim -p -c 'call CFamily_OpenAll()'"
fi
# TODO: fix
alias vim="mvim -v"

# Out of the box vim and mvim
alias  vimootb='vim  -u NONE'
alias mvimootb='mvim -u NONE'

alias fork='open -a $TERM_PROGRAM .' # open this directory in another terminal window/tab
# customize the prompt
export PS1="\e[33m[\t] $>\e[0m "

# add a new directory to the list of directories that have the executable files
export PATH="$PATH:/Library/TeX/Distributions/Programs/texbin"

# for os 161
#export PATH="$PATH:$HOME/sys161/bin:$HOME/sys161/tools/bin"

# Specifically for OS X:
if [ "$(uname)" = "Darwin" ]; then
    alias save="open /System/Library/Frameworks/ScreenSaver.framework/Versions/Current/Resources/ScreenSaverEngine.app"
fi

# icloud locations
if [ "$USER" = 'johnrizkalla' -a "$(uname)" = 'Darwin' ]; then
    export ICLOUD='/Users/johnrizkalla/Library/Mobile Documents/com~apple~CloudDocs'
    export DOCUMENTS="$ICLOUD/Documents"
    export CURRENT_TERM="$DOCUMENTS/2015 - 2016 Academic Year/Winter 2015 (4A term)"

    # Shortcuts for common folders
    alias icloud='cd "$ICLOUD"'
    alias documents='cd "$ICLOUD"; cd Documents'
    alias term='cd "$ICLOUD"; cd Documents; cd "$CURRENT_TERM"'
    alias home="cd ~"
    alias downloads="cd ~/Downloads"
    alias desktop="cd ~/Desktop"
    #and a summary:
    alias folders='echo -e icloud; echo -e "\tdocuments"; echo -e "\t\tterm"; echo home; echo -e "\tdownloads"; echo -e "\tdesktop"'
fi

##
# Your previous /Users/johnrizkalla/.bash_profile file was backed up as /Users/johnrizkalla/.bash_profile.macports-saved_2015-05-05_at_17:43:35
##

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
setopt +o nomatch
for dir in $(ls -d ~/Library/Python/*/bin 2>/dev/null); do
    PATH="$dir:${PATH}"
done
export PATH
setopt -o nomatch

# Set the log file (for scripts running in the background)
export LOG_FILE="$HOME/.log_file"
# flog can be used to print to a log file

# Some functions
type qlmanage >/dev/null 2>&1 # Quick look (OS X)
if [ $? -eq 0 ]; then
    function preview {
        qlmanage -p $1 >/dev/null 2>&1 &
    }
fi

source "$HOME/.env_bash_profile"

if [ -x "$HOME/.local_bash_profile" ]; then
    source "$HOME/.local_bash_profile"
fi

function armdump {
    arm-none-eabi-objdump -D $@ | vim - -c 'source ~/.vim/scripts/ObjDumpToARM.vim'
}

# Encrypt and zip a directory
function enczip {
    zip -r "$1.zip" "$1"
    err="$?"
    if [ "$err" -ne 0 ]; then
        return $err
    fi
    openssl des3 -in "$1.zip" -out "$1.zipenc"
    err="$?"
    if [ "$err" -ne 0 ]; then
        \rm -rf "$1.zip"
        return $err
    fi
    \rm -rf "$1" "$1.zip"
}

function deczip {
    ext="${1##*.}"
    name="${1%.*}"
    
    openssl des3 -d -in "$1" -out "$name.zip"
    err="$?"
    if [ "$err" -ne 0 ]; then
        \rm -f "$name.zip"
        return $err
    fi
    unzip "$name.zip"
    err="$?"
    if [ "$err" -ne 0 ]; then
        \rm -rf "$name.zip"
        return $err
    fi
    \rm -f "$name.zip" "$name.$ext"
}

function automd {
    filename="$1"
    if [ ! -f "$filename.md" ]; then
        # Does the file end with md?
        filename="$(basename "$filename" ".md")"
        if [ ! -f "$filename.md" ]; then
            echo "Cannot open file $filename.md"
            return 1
        fi
    fi
    
    #echo "$filename.md" | entr sh -c pandoc --standalone "$filename.md" -o "$filename.tex" &&
    #        sed -i.bak '1s/$/\\usepackage{tikz}\\usetikzlibrary{calc,positioning}/' "$filename.tex" &&
    #        latexmk -pdf "$filename.tex" &&
    #        \rm *.^(md|pdf)
    trap "return;" SIGINT SIGTERM
    while [ 1 ]; do
        fswatch -L -0 -1 "$filename.md" > /dev/null
        echo "Recompiling $filename.md"
        pandoc --verbose "$filename.md" -o "$filename.pdf"
    done
}

function help {
    man $* 2>/dev/null
    if [ $? -ne 0 ]; then
        "$1" --help 2>&1 | less
    fi
}

function winmgr {
    cmd=$(echo $1 | tr "[:upper:]" "[:lower"])
    if [ "$cmd" = "on" ]; then
        launchctl load ~/Library/LaunchAgents/com.koekeishiya.khd.plist
        launchctl load ~/Library/LaunchAgents/com.koekeishiya.chunkwm.plist
    else
        launchctl unload ~/Library/LaunchAgents/com.koekeishiya.khd.plist
        launchctl unload ~/Library/LaunchAgents/com.koekeishiya.chunkwm.plist
    fi
}


function activate {
    script="env/bin/activate"
    if [ -n "$1" ]; then script="$1"; fi
    source "$script"
}

if [ -x /usr/local/bin/egrep ]; then
    GREP=/usr/local/bin/egrep
else
    GREP=egrep
fi

function psearch {
    case_sensitive=true
    for arg in "$@"; do
        if [ "${arg:0:1}" != "-" ]; then
            term="$arg"
        elif [ "$arg" = "-i" ]; then
            case_sensitive=false
        fi
    done
    if [ -z "$term" ]; then
        echo "Error: search for what?" >&2
        return 1
    fi
    
    if [ $case_sensitive = "true" ]; then
        case_sensitive_flag=""
    else
        case_sensitive_flag="\c"
    fi
    egrep -rnI --exclude-dir=build $@ . | vim -R - "+syntax match String \"\v$case_sensitive_flag$term\"" "+syntax match Keyword \"\v\<$case_sensitive_flag$term\>\""}


# Remove gaps in window numbers in the current tmux session
function tmux-gap-remove {
    while true; do
        # find the gap
        window_nums=($(tmux list-windows | awk '{print $1}' | cut -c -1))
        echo '"' "${window_nums[*]}" '"'
        for i in $(seq 1 $(( ${#window_nums[*]} - 1 ))); do
            difference=$(( ${window_nums[$i+1]} - ${window_nums[$i]} ))
            if [ $difference -gt 1 ]; then
                break;
            fi
        done
        
        if [ $difference = 1 ]; then break; fi
        for j in $(seq $(( $i + 1 )) $(( ${#window_nums[*]} ))); do
            echo tmux move-window -s $j -t $(( $j - $difference  + 1))
            tmux move-window -s $j -t $(( $j - $difference  + 1))
        done
    done
}

function vlog {
    log $@ | vim -
}

function curr-branch {
    git branch | grep \* | cut -d ' ' -f2
}

function default-branch {
    git remote show origin | grep 'HEAD branch' | sed 's/.*: //'
}

function dir-contains {
    haystack="$(cd $1 && pwd)"
    needle=$2

    while [ "$haystack" != "/" ] && [ "$haystack" != "" ]; do
        curr="$(basename "$haystack")"
        if [ "$curr" = "$needle" ]; then return true; fi
        haystack="$(dirname "$haystack")"
    done

    false
}

function scd {
    echo "TODO"
}

function dimages {
    docker images | fzf | awk '{print $3}'
}


function __dcont {
    docker container ls --format 'table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}' | fzf --preview='previewdockercontainer {}' --preview-window=down,15% $@ | awk '{print $1}'
}

function dcont {
    if [ $# -ge 1 ]; then
        args=(--query $@)
    else
        args=()
    fi
    __dcont $args
}

function dlogs {
    if [ $# -ge 1 ]; then
        filter_args=(--filter $@)
        args=(--query $@)
    else
        filter_args=()
        args=()
    fi

    lines="$(__dcont $filter_args)"
    if [ $(wc -l <<< "$lines") -eq 1 ]; then
        container=$lines
    else
        container="$(__dcont $args)"
    fi

    while [ True ]; do
        docker container logs -f $container
        sleep 1
    done

}

function dbash {
    if [ $# -ge 1 ]; then
        filter_args=(--filter $@)
        args=(--query $@)
    else
        filter_args=()
        args=()
    fi

    lines="$(__dcont $filter_args)"
    if [ $(wc -l <<< "$lines") -eq 1 ]; then
        container=$lines
    else
        container="$(__dcont $args)"
    fi
    docker exec -it "$container" bash
}


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


FZF_BASE_OPTS='--border --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229 --color info:150,prompt:110,spinner:150,pointer:167,marker:174'
export FZF_DEFAULT_OPTS="$_FZF_BASE_OPTS --preview '[[ \$(file --mime {}) =~ binary ]] && xxd {} || (highlight --out-format=xterm256 {} || cat {}) 2>/dev/null'"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_TMUX=1
export FZF_TMUX_HEIGHT=95%

export PATH="/opt/homebrew/bin:/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"
export EDITOR="vim"


if [ -r $HOME/.bashrc ]; then source ~/.bashrc; fi
if [ -r $HOME/.bash_profile_local ]; then source ~/.bash_profile_local; fi
