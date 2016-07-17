
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
alias linux2="ssh jrizkall@ubuntu1204-002.student.cs.uwaterloo.ca"
alias linux4="ssh jrizkall@ubuntu1204-004.student.cs.uwaterloo.ca"
alias linux6="ssh jrizkall@ubuntu1204-006.student.cs.uwaterloo.ca"
alias glinux="ssh -X jrizkall@linux.student.cs.uwaterloo.ca"
alias xcode="open -a Xcode "
alias less="less -r"
alias stop="kill SIGTSTP"

alias branch='BRANCH_FROM=$(pwd); cd'
alias goback='echo "cd $BRANCH_FROM"; cd "$BRANCH_FROM"'

alias tmuxnew='tmux -2 new -d -s'

# Vim
# Is MacVim installed?
ls "/Applications/MacVim.app/Contents/MacOS/Vim" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    alias  vim="/Applications/MacVim.app/Contents/MacOS/Vim -p"
    alias mvim="mvim -p" # multiple tabs in vim
    alias cvim="mvim -p -c 'call CFamily_OpenAll()'"
fi

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
    
    export CDPATH="::$CURRENT_TERM"
fi

##
# Your previous /Users/johnrizkalla/.bash_profile file was backed up as /Users/johnrizkalla/.bash_profile.macports-saved_2015-05-05_at_17:43:35
##

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH

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
