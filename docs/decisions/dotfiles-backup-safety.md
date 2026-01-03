# Dotfiles Backup Safety

## Decision
Always back up existing files before installing dotfiles.

## Context
The install script moves existing files into a timestamped backup directory
before installing new versions.

## Rationale
- Prevents accidental data loss
- Makes installs reversible
- Encourages experimentation without fear
- Supports clean rollback

## Backup Location
```text
~/.dotfiles-backup/<timestamp>/
├── home/
└── config/
```
## Notes
Backups mirror the repository structure to make restores obvious and manual if
needed.
