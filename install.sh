#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
DRY_RUN="${DRY_RUN:-0}"

run() {
  if [[ "$DRY_RUN" == "1" ]]; then
    echo "[dry-run] $*"
  else
    "$@"
  fi
}

# Backup to a repo-shaped path:
#   $BACKUP_DIR/home/<name>
#   $BACKUP_DIR/config/<name>
# rather than recreating /home/<user>/... inside the backup.
backup_repo_structured() {
  local target="$1"   # existing path on disk (dst)
  local section="$2"  # "home" or "config"
  local rel="$3"      # relative path under that section (e.g. ".bashrc", "starship.toml")

  if [[ -e "$target" || -L "$target" ]]; then
    local bkp="$BACKUP_DIR/$section/$rel"
    run mkdir -p "$(dirname "$bkp")"
    run mv "$target" "$bkp"
    echo "Backed up: $target -> $bkp"
  fi
}

install_dir_items() {
  local src_root="$1"   # dotfiles/home or dotfiles/config
  local dst_root="$2"   # ~ or ~/.config
  local section="$3"    # "home" or "config" (for backup folder)

  [[ -d "$src_root" ]] || return 0

  shopt -s dotglob nullglob
  for src in "$src_root"/*; do
    local name
    name="$(basename "$src")"
    local dst="$dst_root/$name"

    backup_repo_structured "$dst" "$section" "$name"
    run mkdir -p "$(dirname "$dst")"
    run cp -a "$src" "$dst"
    echo "Installed: $dst"
  done
  shopt -u dotglob nullglob
}

run mkdir -p "$BACKUP_DIR"
run mkdir -p "$HOME/.config"

echo "Dotfiles: $DOTFILES_DIR"
echo "Backup:   $BACKUP_DIR"
echo

echo "==> Installing home/"
install_dir_items "$DOTFILES_DIR/home" "$HOME" "home"

echo
echo "==> Installing config/"
install_dir_items "$DOTFILES_DIR/config" "$HOME/.config" "config"

echo
if [[ "$DRY_RUN" == "1" ]]; then
  echo "Dry run complete. No changes made."
else
  echo "Done. Backups stored in: $BACKUP_DIR"
fi
