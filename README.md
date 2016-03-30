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
* `log.sh` -- log to a file (`$HOME/.log_file`)

### Python Scripts
* `tree.py` -- provides an interface for accessing the filesystem as a tree structure. Also provides a command line interface similar to that of `tree.sh` (Bash scripts)
* `latex.py` -- provides a function to sanitize strings for LaTeX
* `ctree.py` -- uses `tree.py`, `latex.py`, and `ctags` to generate a tree in LaTeX of C files and the functions in them.
* `passwordgen.py` -- generates passwords by getting random workds [online](http://watchout4snakes.com/wo4snakes/Random/RandomWord)
* `music.py` -- provides an interface for controlling iTunes from the command line

### bin/
The following symbolic links are automatically placed in bin/ by `config.sh`:

| tool | Linked too |
| ----:|:---------- |
| `csconfig`  |  [`bash/csconfig.sh`](bash/csconfig.sh) |
| `flog`  |  [`bash/log.sh`](bash/log.sh) |
| `passwordgen`  |  [`python/passwordgen.py`](python/passwordgen.py) |
| `pid`  |  [`bash/pid.sh`](bash/pid.sh) |
| `play`  |  [`python/music.py`](python/music.py) |
| `trash`  |  [`bash/trash.sh`](bash/trash.sh) |
| `tree`  |  [`python/tree.py`](python/tree.py) |
| `waitforprocess`  |  [`bash/waitforprocess.sh`](bash/waitforprocess.sh) |
