# Configuration Dot Files and AI Skills

- All configuration files and setup steps when setting up ZSH terminal

Personal dotfiles, shell scripts, and Cursor AI skills. Repo root is `$HOME`;

## OS

- **Linux** (Debian) (apt and optional xclip/gnome-tweaks on Linux)
- **macOS** — install.sh branches on `main` (Homebrew).

## Contents

| Area | Location | Notes |
|------|----------|--------|
| **Dotfiles** | `~/.zshrc`, `~/.bashrc`, `~/.profile`, `~/.vimrc`, `~/.gitconfig` | Shell and editor config. Copy `sample.env.zshrc` / `sample.env.gitconfig` and fill in before use. |
| **Neovim** | `~/.config/nvim/` | `init.vim`, bundles, lightline, fzf. Expects [vim-plug](https://github.com/junegunn/vim-plug). |
| **Scripts** | `~/Documents/bin/` | Small bash (and a few Node/Python) helpers: e.g. `trash`, `killmatch`, `setjava`, `open`, npm/yarn outdated checkers. Add to `PATH` if you want them global. |
| **Cursor skills** | `~/.cursor/skills/`, `~/.cursor/skills-cursor/` | Agent skills (write-tickets, technical-writer, dev-workflow-write-pr, investigate-create-doc, worktree-manager, create-rule, update-cursor-settings, etc.). One `SKILL.md` per skill. |

## Includes

- My Bash Scripts
- Terminal Config
- AI skills

## General Setup

1. Run `./install.sh` to install
1. Address issues

## Setup

1. **Install**  
   From repo root: `./install.sh` (no args). Prompts for Powerline fonts; installs zsh, Oh My Zsh, nvm, Neovim, fzf, ag, rg, and on Mac: Homebrew, Rectangle.