# Configuration Dot Files

- All configuration files and setup steps when setting up ZSH terminal

Personal dotfiles and shell scripts. Repo root is `$HOME`;

## OS

- **Linux** (Debian) (apt and optional xclip/gnome-tweaks on Linux)
- **macOS** (Homebrew)
- **Windows** (native PowerShell, no WSL) — config-only port, see
  [`powershell/README.md`](powershell/README.md).

## Structure

Split by tooling family, not OS: `common/` (shared config), `bash/`
(POSIX/Unix tooling — ie. Mac and Linux),
`powershell/` (Windows). Mac/Linux differences handled inline with
`uname` checks within the shared files (see `bash/.zshrc`,
`common/.vimrc`, etc.)

## Contents

| Area              | Location                                                          | Notes                                                                                                                                                                                 |
| ----------------- | ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Dotfiles**      | `~/.zshrc`, `~/.bashrc`, `~/.profile`, `~/.vimrc`, `~/.gitconfig` | Shell and editor config. Copy `sample.env.zshrc` / `sample.env.gitconfig` and fill in before use.                                                                                     |
| **Neovim**        | `~/.config/nvim/`                                                 | `init.vim`, bundles, lightline, fzf. Expects [vim-plug](https://github.com/junegunn/vim-plug).                                                                                        |
| **Scripts**       | `~/Documents/bin/`                                                | Small bash (and a few Node/Python) helpers: e.g. `trash`, `killmatch`, `setjava`, `open`, npm/yarn outdated checkers. Add to `PATH` if you want them global.                          |
| **Windows**       | `powershell/`                                                     | PowerShell profile + setup notes (git config, env vars/PATH, Neovim). tmux and `Documents/bin/*` are not ported.                                                                      |

## Includes

- Terminal Config
- Some Scripts

## General Setup

1. Mac/Linux: work through the checklist in [`bash/README.md`](bash/README.md).
1. Windows: work through the checklist in [`powershell/README.md`](powershell/README.md).
1. Link configs into `$HOME`: `./link.sh` (Mac/Linux) or `.\link.ps1` (Windows).
   Layout: `common/` (shared), `bash/` (Mac/Linux), `powershell/` (Windows).
1. Address issues
