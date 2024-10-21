from subprocess import check_output, CalledProcessError

__all__ = ["unsafe_run", "run"]

def unsafe_run(cmd: str) -> str:
    return check_output(cmd, shell=True).decode().strip()

def run(cmd: list[str]) -> str:
    return check_output(cmd).decode().strip()