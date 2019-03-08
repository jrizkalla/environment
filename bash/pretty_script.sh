# Library to pretty print commands
# Usage:
# source pretty_script file
# + error checked command
# - error ignored command
# Note: shell special chars must be escaped
# e.g. + echo test '&&' echo test2
#      - echo something \| sed 's/h//g'


# Functions:
# +                                 run a command. Fail the script if it fails
# -                                 run a command. Keep going if it fails
# checkpoint "id" "description"     register a checkpoint. Caller can skip to checkpoints
# noop                              Does nothing and doesn't get printed

# Variables: Change the variables after sourcing pretty_script to change settings
# int VERBOSITY: verbosity level (defaults to 0, changed by command line arguments)
# bool COLOR   : Color on or off (defaults to on, changed by command line arguments)
# bool DRY_RUN : Dry run or actually execute commands (changed by command line arguments)
# string INDENT: indent inserted at command stdout and stderr (default "  ")
# string CURR_CHECKPOINT: the current checkpoint
# string PPROMPT: Prompt printed before + commands
# string MPROMPT: Prompt printed before - commands

source ~/.bashrc


# read verbosity level from command line
VERBOSITY=0
COLOR=1
INDENT="  "
DRY_RUN=0

# Checkpoint stuff
CURR_CHECKPOINT="__start__"
PREV_CHECKPOINT="__start__"
_START_AT="__start__"
_STOP_AFTER="__stop__"
_STARTED=0
_STOPPED=0
_CHECKPOINT_FMT="normal"
ASK_FOR_CONFIRMATION=0

function _parse_arg {
    case $1 in
        v|verbose)
            VERBOSITY=$(($VERBOSITY + 1))
        ;;
        c|color)
            COLOR=$(( ! $COLOR ))
        ;;
        dry-run)
            DRY_RUN=1
        ;;
        start-at=*)
            _START_AT="${1#start-at=}"
        ;;
        stop-after=*)
            _STOP_AFTER="${1#stop-after=}"
        ;;
        l|list-checkpoints)
            _START_AT="__end__" # skip everything
            _CHECKPOINT_FMT="list"
            _VERBOSITY=3 # make sure checkpoints are printed
        ;;
        ask)
            ASK_FOR_CONFIRMATION=1
        ;;
    esac
}

for arg in $@; do
    if [ "${arg:0:2}" = "--" ]; then
        _parse_arg "${arg#--}"
    elif [ "${arg:0:1}" = "-" ]; then
        while read -n1 char; do
            _parse_arg $char
        done < <(echo "${arg}")
    fi
done

CLR_EMPH=""
CLR_RESET=""
CLR_GREEN=""
CLR_ERR=""
if [ $COLOR -eq 1 ]; then
    CLR_EMPH="$(tput bold)"
    CLR_GREEN="$(tput setaf 2)"
    CLR_ERR="$(tput setaf 1)"
    CLR_RESET="$(tput sgr0)"
fi

PPROMPT="$CLR_GREEN> $CLR_RESET" # prompt for +
MPROMPT="$CLR_GREEN- $CLR_RESET" # prompt for -


function _print_cmd {
    if [ "$1" = "noop" ]; then return 0; fi
    
    cmd=$1; shift
    args=$@
    
    ask="\n"
    if [ $ASK_FOR_CONFIRMATION -eq 1 ]; then
        ask=". Run? (y/n) "
    fi
    
    if [ $VERBOSITY -ge 1 ]; then
        printf "%s%s%s" "$PROMPT" $CLR_EMPH "$cmd"
        if [ $VERBOSITY -ge 2 ]; then
            printf " %s%s$ask" "$args" $CLR_RESET
        else
            printf "%s$ask" $CLR_RESET
        fi
    fi
}

# Verbosity levels:
# 0 - print errors only
# 1 - print cmd and errors
# 2 - print cmd, params, and errors
# 3 - print cmd, params, stdout, and errors

function run {
    
    if [ $_STARTED -eq 0 ]; then # not started
        if [ "$CURR_CHECKPOINT" != "$_START_AT" ]; then
            return 0
        fi
    fi
    _STARTED=1
    
    if [ $_STOPPED -eq 1 ] || [ "$PREV_CHECKPOINT" == "$_STOP_AFTER" ]; then 
        _STOPPED=1
        return 0
    fi
    
    _print_cmd $@
    
    if [ $DRY_RUN -eq 1 ]; then return 0; fi
    
    if [ $ASK_FOR_CONFIRMATION -eq 1 ] && [ "$1" != "noop" ]; then
        read answer
        answer="$(echo $answer | tr '[A-Z]' '[a-z]' | tr -d '[:space:]')"
        if [ "$answer" != "" ] && [ "$answer" != "y" ] && [ "$answer" != "yes" ]; then
            echo "Cancelled"
            return 0
        fi
    fi
    
    if [ $VERBOSITY -ge 3 ]; then
        # "$@" | sed "s/^/$INDENT/g" WONT WORK: bash executes all pipes in subshells
        # Optiona 2: Create a temp file, output everything to it, then cat it. 
        # the problem with that is that nothing is printed until the command finishes
        
        eval "$@" > >(sed "s/^/$INDENT/g") 2>&1
        
        ret=$?
        
        if [ $ret -ne 0 ]; then
            printf "${CLR_ERR}Error: process returned $ret$CLR_RESET\n"
        fi
        
        return $ret
    else
        stdout_file="$(mktemp -t stout_$(basename $0))"
        stderr_file="$(mktemp -t stout_$(basename $0))"
        
        eval $@ >$stdout_file 2>$stderr_file
        
        ret=$?
        if [ $ret -ne 0 ]; then
            printf "${CLR_ERR}Error: process returned $ret$CLR_RESET\n"
            printf "stdout:\n"
            cat $stdout_file | sed "s/^/$INDENT/g"
            printf "stderr:\n"
            cat $stderr_file | sed "s/^/$INDENT/g"
        fi
        
        rm -f "$stdout_file"
        rm -f "$stderr_file"
        
        return $ret
    fi
}

function + {
    PROMPT=$PPROMPT
    run $@
    ret=$?
    if [ $ret -ne 0 ]; then exit $ret; fi
}

function - {
    PROMPT=$MPROMPT
    run $@
}


# Usage: checkpoint id "description"
function checkpoint {
    id=$1
    desc=$2
    PREV_CHECKPOINT="$CURR_CHECKPOINT"
    CURR_CHECKPOINT=$1
    if [ $VERBOSITY -ge 3 ] || [ "$_CHECKPOINT_FMT" = "list" ]; then
        if [ "$_CHECKPOINT_FMT" = "list" ]; then
            printf "%30s -- %s\n" "$id" "$desc"
        else
            checkpoint="Checkpoint $id $desc"
            border=$(head -c ${#checkpoint} < /dev/zero | tr '\0' '-')
            printf "\n Checkpoint ${CLR_EMPH}%s${CLR_RESET} %s\n" "$id" "$desc"
            printf " %s \n" "$border"
        fi
    fi
}

function noop {
    true
}

if [ $VERBOSITY -ge 4 ]; then
    echo "Maximum verbosity enabled"
    if [ $COLOR -eq 1 ]; then echo "Color enabled";
    else echo "Color disabled"; fi
fi

+ noop # kick start the script (for checkpoints)
