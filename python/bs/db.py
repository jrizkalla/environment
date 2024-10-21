from dataclasses import dataclass, field
from functools import cached_property, singledispatchmethod
from pathlib import Path
from datetime import datetime
import json
from typing import Optional, Self
from contextlib import contextmanager

from .git import CommandLineGitClient, DockerCommandLineGitClient, GitClient

from .util import *

__all__ = ["Branch", "Repo", "BranchDb"]

@dataclass
class Branch:
    repo_path: Path
    name: str
    last_visited: datetime
    postgres_backup_path: Optional[Path]=None
    
    @classmethod
    def parse(cls, data) -> "Branch":
        return cls(
            repo_path=Path(data["repo_path"]).resolve(),
            name=data["name"],
            last_visited=datetime.fromisoformat(data["last_visited"]),
            postgres_backup_path=data.get("postgres_backup_path")
        )
    
    def encode(self):
        data = dict(
            repo_path=str(self.repo_path),
            name=self.name,
            last_visited=self.last_visited.isoformat()
        )
        if self.postgres_backup_path is not None:
            data["postgres_backup_path"] = str(self.postgres_backup_path)
        return data
    
    def __str__(self):
        return self.name
        

@dataclass
class Repo:
    
    @dataclass
    class RepoSettings:
        @dataclass
        class DockerSettings:
            volumes_to_backup: list[str]

        docker: Optional[DockerSettings] = None
        
        @classmethod
        def parse(cls, data) -> Self:
            return cls(
                docker=DockerSettings(**data["docker"]) if "docker" in data else None
            )
        
        def encode(self):
            return {
                "docker": vars(self.docker) if self.docker else None
            }
            
    
    git_client: GitClient
    path: Path
    branches: list[Branch]
    settings: RepoSettings = field(default_factory=RepoSettings)
    
    @classmethod
    def parse(cls, data) -> "Repo":
        settings = cls.RepoSettings.parse(data.get("settings", {}))
        return cls(
            #git_client=DockerCommandLineGitClient(base_client=CommandLineGitClient()) if settings.backup_docker_volumes else CommandLineGitClient(),
            git_client=CommandLineGitClient(),
            path=Path(data["path"]).resolve(),
            branches=[Branch.parse(b) for b in data["branches"]],
            settings=settings
        )
    
    def encode(self):
        return {
            "path": str(self.path),
            "branches": [b.encode() for b in self.branches],
            "settings": self.settings.encode()
        }
    
    def branch(self, branch_name: str) -> Branch:
        return Branch(
            name=branch_name.strip(),
            repo_path=self.path,
            last_visited=datetime.now()
        )
    
    @singledispatchmethod
    def switch_to_branch(self, branch: Branch):
        self.git_client.switch_branch(branch)
    
    @switch_to_branch.register
    def _(self, branch: str):
        self.switch_to_branch(self.branch(branch))
        
        


class BranchDb:
    BRANCH_DB_FILE = (Path("~") / ".bs.json").expanduser()
    
    _repos: dict[Path, Repo]

    _discard_changes = False
    
    @classmethod
    def default_git_client(cls, git_client: Optional[GitClient]=None) -> GitClient:
        return git_client if git_client else CommandLineGitClient()
    
    @classmethod
    def _parse_db_json(cls, db_json) -> list[Repo]:
        return [Repo.parse(r) for r in db_json]
        

    def __init__(self):
        self._discard_changes = False
        try:
            with self.BRANCH_DB_FILE.open("r") as fl:
                self._repos = {r.path: r for r in self._parse_db_json(json.load(fl))}
        except FileNotFoundError:
            self._repos = {}
            
    @cached_property
    def curr_path(self) -> Path:
        return self.git_client.git_directory()
    
    @property
    def curr_repo(self) -> Repo:
        return self._repos.get(self.curr_path, Repo(git_client=self.git_client, path=self.curr_path, branches=[]))

    @property
    def curr_branch(self) -> Branch:
        curr_branch_name = self.git_client.curr_branch()
        return self.curr_repo.branch(curr_branch_name)
        
    def push(self, branch: Branch):
        repo = self._repos.get(branch.repo_path, Repo(git_client=self.git_client, path=branch.repo_path, branches=[]))

        if len(repo.branches) > 0 and repo.branches[-1].name == branch.name:
            return

        repo.branches.append(branch)
        self._repos[repo.path] = repo
        
    def pop(self, repo: Optional[Repo]=None, number: Optional[int]=None) -> Optional[Branch]:
        repo = repo if repo else self.curr_repo
        number = number if number is not None else 1
        try:
            return repo.branches.pop(self._number_to_index(repo, number))
        except IndexError:
            return None
    
    def purge(self, repo: Optional[Repo]=None):
        repo = repo if repo else self.curr_repo
        repo_branches = set(self.git_client.branches_in_repo())

        repo.branches = [
            b for b in repo.branches if b.name in repo_branches
        ]
    
    def _number_to_index(self, repo: Repo, number: int) -> int:
        result = len(repo.branches) - number
        assert result >= 0 and result < len(repo.branches)
        return result

    def last(self, repo: Optional[Repo]=None) -> Optional[Branch]:
        return self.nth_branch(1)

    def nth_branch(self, number: int, repo: Optional[Repo]=None) -> Optional[Branch]:
        repo = repo if repo else self.curr_repo
        return repo.branches[self._number_to_index(repo, number)] if len(repo.branches) > 0 else None

    def swap(self, number: int, repo: Optional[Repo]=None) -> Branch:
        repo = repo if repo else self.curr_repo
        target_branch_index = self._number_to_index(repo, number)

        curr_branch = self.curr_branch
        target_branch = repo.branches[target_branch_index]

        repo.branches[target_branch_index] = curr_branch
        return target_branch

    
    def close(self):
        if self._discard_changes: return

        data = [r.encode() for r in self._repos.values()]
        with open(self.BRANCH_DB_FILE, "w") as db_file:
            json.dump(data, db_file, indent=2)

    @contextmanager
    def discard_changes_on_error(self):
        try:
            yield self
        except:
            self._discard_changes = True
            raise
