# Windows (PowerShell) setup

Native PowerShell port of the parts of this repo that are worth porting — no
WSL required. This is config only; there's no `install.ps1` that installs
tools for you.

## What's ported

- **Env vars / PATH / the `nvimdiff` alias** → `windows/Profile.ps1`
  (equivalent of the non-Oh-My-Zsh parts of `../.zshrc` and the
  Windows-relevant parts of `../Documents/bin/addExternals`).
- **Neovim config** (`../.config/nvim/`) — needs no changes. It already
  defaults to a Windows-safe code path and runs natively.
- **Git config** (`../.gitconfig`) — copy it as-is; `core.editor` now points
  at `nvim` (works on all three OSes).

## What's NOT ported

- **tmux** — no native Windows build. Would require WSL, which is out of
  scope here.
- **`../Documents/bin/*` scripts** — these are bash scripts (several with
  hardcoded Unix paths and dependencies like `awk`/`sed`/`ps`/`pbcopy`). They'd
  need individual rewrites as PowerShell equivalents; not part of this pass.
- **Prompt/theme** — Oh My Zsh's `robbyrussell` theme has no equivalent here.
  PowerShell keeps its default prompt. (Starship is a reasonable cross-shell
  option later if you want parity with zsh.)

## Prerequisites

Install these yourself first (winget or scoop, whichever you prefer):

- Git for Windows
- Neovim
- ripgrep (`rg`)
- fzf
- [`win32yank`](https://github.com/equalsraf/win32yank) — Neovim's Windows
  clipboard provider; without it, `clipboard+=unnamedplus` in `init.vim` won't
  actually reach the system clipboard
- Optional: [`mise`](https://mise.jdx.dev/) for tool version management
- Optional: `PSFzf` PowerShell module (`Install-Module PSFzf`) — fzf doesn't
  wire up `Ctrl+T`/`Ctrl+R` in PowerShell on its own the way it does in zsh;
  PSFzf is the standard way to get that

## Setup

1. **Wire up the profile.** Add this line to your real profile (find its path
   with `$PROFILE`, typically
   `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`):

   ```powershell
   . "C:\path\to\this\repo\windows\Profile.ps1"
   ```

2. **Git config.** Copy `../.gitconfig` to `~\.gitconfig`.

3. **Git secrets/overrides.** Copy `../sample.env.gitconfig` to
   `~\env.gitconfig` and fill in (signing key, etc.) — the
   `includeIf "gitdir:~/"` in `.gitconfig` works unchanged on Windows Git.

4. **Optional local overrides.** Copy `sample.env.profile.ps1` to
   `~\env.profile.ps1` and set any flags (`ENABLE_REACT_NATIVE`, etc.). This
   file is gitignored, same as `~\env.zshrc` on Unix.

5. Open a new PowerShell window and confirm it loads cleanly (see
   Verification below).

## Verification

- New `pwsh` window: `$env:FZF_DEFAULT_COMMAND` is set, `Get-Command
  nvimdiff` resolves, no errors on startup.
- `nvim`: `:echo $MYVIMRC` resolves, vim-plug installs/loads plugins under
  `~/.local/share/nvim/plugged` without errors.
- Yank a line in Neovim, paste into another app (confirms `win32yank`).
- `git config --get core.editor` prints `nvim`; `git mergetool` on a conflict
  opens `nvimdiff`.
- `nvimdiff file1 file2` from PowerShell opens a diff view.
