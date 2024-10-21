from argparse import ArgumentParser
import functools
import sys
from pathlib import Path
from contextlib import closing
from subprocess import CalledProcessError
from typing import Optional

from .db import *
from .util import *

def checkout(db: BranchDb, branch_name: str):
    branch_name = branch_name.strip()
    curr_branch = db.curr_branch
    
    if curr_branch.name.lower() == branch_name.lower():
        print(f"Already on '{curr_branch}'")
        return 1

    db.curr_repo.switch_to_branch(branch_name)
    db.push(curr_branch)


def pop(db: BranchDb, number: Optional[int]):
    branch = db.nth_branch(number) if number is not None else db.last()
    if not branch:
        print("Empty stack!", file=sys.stderr)
        return 1

    db.curr_repo.switch_to_branch(branch)
    db.pop(number=number)

def ls(db: BranchDb, clean: bool=False, no_line_numbers: bool=False):
    line_number_format = "" if no_line_numbers else "{line:3}"
    repo = db.curr_repo
    curr_branch = db.curr_branch
    space = "" if clean else "   "
    star = "" if clean else " * "
    for i, branch in enumerate(repo.branches):
        line = len(repo.branches) - i
        print(f"{line_number_format}{space}{branch.name}".format(line=line))
    print(f"{line_number_format}{star}{curr_branch.name}".format(line=0))

def swap(db: BranchDb, number: Optional[int]):
    number = number if number is not None else 1
    if number <= 0:
        print(f"Cannot swap with {number}!")

    with db.discard_changes_on_error():
        branch = db.swap(number)
        db.curr_repo.switch_to_branch(branch)


def list_branches(db: BranchDb):
    print("  " + unsafe_run("git branch --color=always"))

def status(db: BranchDb, clean: bool):
    ls(db, clean)
    print("\n-------\n\n" + unsafe_run("git -c color.status=always status"))

def head(db: BranchDb):
    try:
        print(db.curr_repo.branches[0].name)
    except IndexError:
        print("No branches in stack", file=sys.stderr)

def error(db: BranchDb, message=""):
    if message:
        print(message, file=sys.stderr)
    return 1


def _branch_from_name(branch: Optional[str]) -> Branch:
    ...

def db_backup(db: BranchDb, branch: Optional[str]):
    print(f"backing up {branch}")

def db_restore(db: BranchDb, branch: Optional[str]):
    print(f"restoring {branch}")

def db_delete(db: BranchDb, branch: Optional[str]):
    print(f"deleting backup {branch}")
    
parser = ArgumentParser(description="Switch branches and remember previously visited branches")
subparsers = parser.add_subparsers()
parser.set_defaults(handler=ls)
main_args = ["handler"]

checkout_subparser = subparsers.add_parser("checkout", help="Checkout a new branch, pushing the current branch to the stack.")
checkout_subparser.set_defaults(handler=checkout)
checkout_subparser.add_argument("branch_name", type=str, help="The branch to checkout.")
pop_subparser = subparsers.add_parser("pop", help="Pop the latest branch from the stack and switch to it.")
pop_subparser.set_defaults(handler=pop)
pop_subparser.add_argument("number", nargs="?", type=int, default=None, help="Pop a specific branch up the list.")
ls_subparser = subparsers.add_parser("ls", help="List items in the stack")
ls_subparser.add_argument("-c", "--clean", action="store_true", default=False, help="Only print the branches without any other marking")
ls_subparser.add_argument("-n", "--no-line-numbers", action="store_true", default=False, help="Don't show numbers next to branch names")
ls_subparser.set_defaults(handler=ls)
swap_subparser = subparsers.add_parser("swap", help="Swap the current branch with the branch on top of the stack.")
swap_subparser.add_argument("number", nargs="?", type=int, default=None, help="Swap with a specific branch up the list.")
swap_subparser.set_defaults(handler=swap)
branch_subparser = subparsers.add_parser("branch", help="Same as git branch.")
branch_subparser.set_defaults(handler=list_branches)
status_subparser = subparsers.add_parser("status", help="Run bs list and then git status.")
status_subparser.set_defaults(handler=status)
status_subparser.add_argument("-c", "--clean", action="store_true", default=False, help="Only print the branches without any other marking")
head_subparser = subparsers.add_parser("head", help="Print the head branch on the stack.")
head_subparser.set_defaults(handler=head)

db_parser = subparsers.add_parser("db", help="Backup and restore the docker postgres database.")
db_parser.add_argument("-b", "--branch", default=None, required=False, type=str, help="Branch to use for backup reference. Defaults to the current branch.")
db_parser.set_defaults(handler=functools.partial(error, message="Missing subcommand for db"))
db_subparser = db_parser.add_subparsers()

db_backup_subparser = db_subparser.add_parser("backup", help="Backup the current postgres database for the current branch.")
db_backup_subparser.set_defaults(handler=db_backup)
db_restore_subparser = db_subparser.add_parser("restore", help="Restore the current postgres database for the current branch.")
db_restore_subparser.set_defaults(handler=db_restore)
db_delete_subparser = db_subparser.add_parser("delete", help="Delete any backups for the current branch.")
db_delete_subparser.set_defaults(handler=db_delete)

def main(args):
    passed_args = {k:v for k,v in vars(args).items()}
    for main_arg in main_args:
        del passed_args[main_arg]

    with closing(BranchDb()) as db:
        try:
            retcode = args.handler(db, **passed_args)
        except CalledProcessError as err:
            print(f"Process failed with exit code {err.returncode}")
            return err.returncode
    
    with closing(BranchDb()) as db:
        db.purge()
        
    return retcode