# dotfiles

Personal dotfiles for my Debian-based daily driver and lab systems.

This repository uses a deployment model: files in this repo are the source of truth and are copied into $HOME and $HOME/.config via a controlled install script.

Nothing is symlinked. Nothing is implicitly managed.

---

## Philosophy

This repo intentionally tracks human-authored configuration, not application state.

Before adding a file, I ask:

If I reinstalled Debian tomorrow, would I want this file back exactly as-is?

If the answer is yes, it belongs here.  
If it is auto-generated, noisy, or machine-specific, it does not.

---

## Repository Structure

```text
dotfiles/
├── home/
│   ├── .bashrc
│   ├── .profile
│   └── .gitconfig
│
├── config/
│   └── starship.toml
│
├── install.sh
└── README.md
```

---

## home/

Contains dotfiles that are copied directly into $HOME.

Examples:
- .bashrc
- .profile
- .gitconfig

---

## config/

Contains configuration files copied into $HOME/.config.

Examples:
- starship.toml
- terminal or tool configs that I explicitly manage

---

## What Is Not Tracked (By Design)

The following are intentionally excluded unless manually curated later:

- Desktop or session state (gnome-session, dconf, ibus)
- Application caches
- Electron application configs
- Browser profiles
- Messaging applications
- Proton application state
- Any auto-generated or opaque files

This keeps the repo:
- Small
- Auditable
- Portable
- Stable over time

---

## Installation

From the repo root:

./install.sh

Dry run (recommended first):

DRY_RUN=1 ./install.sh

This prints every action without making changes.

---

## Backups

Before installing any file, the script backs up existing files to:

```text
~/.dotfiles-backup/<timestamp>/
├── home/
└── config/
```

The backup structure mirrors this repo.

To restore a file manually:

cp ~/.dotfiles-backup/<timestamp>/home/.bashrc ~/.bashrc

---

## Safety Guarantees

- Existing files are never overwritten without a backup
- Permissions are preserved
- Script exits on error (set -euo pipefail)
- Dry-run mode is supported

---

## Scope

This repo manages:
- Shell behavior
- Prompt configuration
- Developer ergonomics

This repo does not manage:
- Package installation
- Desktop theming
- System-wide configuration
- Secrets

Those concerns are handled separately.

---

## Notes to Future Me

- Favor clarity over cleverness
- Add files slowly and intentionally
- If something feels noisy, do not commit it yet
