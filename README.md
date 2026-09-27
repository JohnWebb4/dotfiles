# Configuration Dot Files

- All configuration files and setup steps when setting up ZSH terminal

Personal dotfiles and shell scripts. Repo root is `$HOME`;

## OS

- **Linux** (Debian) (apt and optional xclip/gnome-tweaks on Linux)
- **macOS** — install.sh branches on `main` (Homebrew).
- **Windows** (native PowerShell, no WSL) — config-only port, see
  [`powershell/README.md`](powershell/README.md).

## Contents

| Area              | Location                                                          | Notes                                                                                                                                                                                 |
| ----------------- | ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Dotfiles**      | `~/.zshrc`, `~/.bashrc`, `~/.profile`, `~/.vimrc`, `~/.gitconfig` | Shell and editor config. Copy `sample.env.zshrc` / `sample.env.gitconfig` and fill in before use.                                                                                     |
| **Neovim**        | `~/.config/nvim/`                                                 | `init.vim`, bundles, lightline, fzf. Expects [vim-plug](https://github.com/junegunn/vim-plug).                                                                                        |
| **Scripts**       | `~/Documents/bin/`                                                | Small bash (and a few Node/Python) helpers: e.g. `trash`, `killmatch`, `setjava`, `open`, npm/yarn outdated checkers. Add to `PATH` if you want them global.                          |
| **Windows**       | `powershell/`                                                     | PowerShell profile + setup notes (git config, env vars/PATH, Neovim). tmux and `Documents/bin/*` are not ported.                                                                      |

## Includes

- My Bash Scripts
- Terminal Config

## General Setup

1. Mac/Linux: run `bash/install.sh` to install packages. Prompts for Powerline
   fonts; installs zsh, Oh My Zsh, nvm, Neovim, fzf, ag, rg, and on Mac:
   Homebrew, Rectangle.
1. Link configs into `$HOME`: `./link.sh` (Mac/Linux) or `.\link.ps1` (Windows).
   Layout: `common/` (shared), `bash/` (Mac/Linux), `powershell/` (Windows).
1. Address issues
