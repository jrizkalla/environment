# Environment
My Unix (Mac OS and Linux) environment setup. Includes bash scripts, python scripts, and vim configuration

## Usage
To install the environment simply run `./config.sh`.
To undo the changes run `./cleanup.sh`.

## Contents
This environment is my personal setup and was not written with the intend of distribution.
However, there are some nice scripts that may be useful to other people (plus I ran out of private repositories in GitHub)

### Bash Scripts
* `bash_profile.sh` -- my bash profile
* `pid.sh` -- print the process id of the first process that contains the argument
* `trash.sh` -- move the argument to ~/.Trash
* `waitforprocess.sh` -- use `caffeinate` and `pid.sh` to make the computer wait for a process before sleeping
* `csconfig.sh` -- configuration of the `cs` command which does a `cd` and a `ls`
* `settitle.sh` -- set the title of the terminal (using xterm escape codes)
* `tree.sh` -- print the current directory in a tree format

### Python Scripts
TODO python scripts
