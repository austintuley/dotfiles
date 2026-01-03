# Dotfiles Deployment Model

## Decision
Use a deployment (copy-based) model for dotfiles.

## Context
This repository installs files by copying them into `$HOME` and `$HOME/.config`
instead of using symlinks.

## Rationale
- Predictable behavior on fresh installs
- No broken symlinks
- Works cleanly with backups
- Easy to reason about and undo
- No hidden coupling between the repo and the home directory

## Alternatives Considered
- **Symlink-based dotfiles**  
  Rejected due to implicit behavior, fragility, and harder recovery.

## Notes
If host-specific differences are ever needed, handle them explicitly rather than
introducing symlink tricks.
