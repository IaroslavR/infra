"""Link files to Dropbox for backup"""
import sys

from loguru import logger
from pathlib import Path

DROPOBOX_DIR = "~/Dropbox/backup/local"

FILES = ["~/.bashrc", "~/.ssh/config"]

logger.remove()
logger.add(
    sys.stderr,
    colorize=True,
    format="{time:YY-MM-DD HH:mm:ssZ} <level>{message}</level>",
    level="TRACE",
)

backup_dir = Path(DROPOBOX_DIR).expanduser()
backup_dir.mkdir(parents=True, exist_ok=True)

for f in FILES:
    src = Path(f).expanduser()
    dst = backup_dir / src.name
    dst.unlink()
    dst.symlink_to(src)
    logger.success("Symlink in {} for {} created", backup_dir, src)
