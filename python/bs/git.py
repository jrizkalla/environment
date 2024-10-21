from pathlib import Path
from subprocess import run
from typing import Protocol, TYPE_CHECKING

if TYPE_CHECKING:
    from db import Branch

from .util import unsafe_run


class GitClient(Protocol):
    def git_directory(self) -> Path:
        ...
        
    def curr_branch(self) -> str:
        ...
    
    def branches_in_repo(self) -> list[str]:
        ...
    
    def switch_branch(self, branch: "Branch"):
        ...
    
    
class CommandLineGitClient(GitClient):
    def git_directory(self) -> Path:
        return Path(unsafe_run(r"git rev-parse --show-toplevel")).resolve()

    def curr_branch(self) -> str:
        return unsafe_run(r"git branch --show-current")

    def branches_in_repo(self) -> list[str]:
        return [b.strip() for b in unsafe_run("git branch -l --format '%(refname:lstrip=2)'").split("\n")]

    def switch_branch(self, branch: "Branch"):
        run(["git", "checkout", branch.name])


class DockerCommandLineGitClient(GitClient):
    def __init__(self, base_client: GitClient):
        self.base_client = base_client

    def git_directory(self) -> Path:
        return self.base_client.git_directory()
        
    def curr_branch(self) -> str:
        return self.base_client.curr_branch()
    
    def branches_in_repo(self) -> list[str]:
        return self.base_client.branches_in_repo()

    def switch_branch(self, branch: "Branch"):
        ...
        

    @property
    def backup_directory(self) -> Path:
        return self.git_directory() / ".docker-backups"
    
    def backup_path_for_branch(self, branch: "Branch") -> Path:
        return self.backup_directory / branch.name.replace("/", "_")
