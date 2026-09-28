# Windows (PowerShell) setup

Ported parts of my bash setup. Config only.

Checklist to run through on a new machine. Install packages with winget or
scoop, whichever you prefer.

## Packages

- [ ] Git for Windows
- [ ] Neovim
- [ ] ripgrep (`rg`)
- [ ] fzf
- [ ] [`win32yank`](https://github.com/equalsraf/win32yank): Neovim's Windows
      clipboard provider. Without it, `clipboard+=unnamedplus` in `init.vim`
      won't reach the system clipboard

## Link configs

- [ ] From the repo root run `.\link.ps1`. It junctions `~\.config\nvim`,
      symlinks `.vimrc`/`.tmux.conf` (needs Developer Mode; skipped with a
      warning otherwise), adds a dot-source line for `powershell\Profile.ps1`
      to `$PROFILE`, and adds an `[include]` for `common\.gitconfig` to
      `~\.gitconfig`. Existing files are backed up as `*.bak`.
- [ ] Copy `../common/sample.env.gitconfig` to `~\env.gitconfig` and fill it in
      (signing key, etc.). The `includeIf "gitdir:~/"` in `.gitconfig` works
      unchanged on Windows Git.
- [ ] Optional: copy `sample.env.profile.ps1` to `~\env.profile.ps1` and set any
      flags (`ENABLE_REACT_NATIVE`, etc.). This file is gitignored, same as
      `~\env.zshrc` on Unix.

## Verify

- [ ] New `pwsh` window: no errors on startup, `$env:FZF_DEFAULT_COMMAND` is
      set, and `Get-Command nvimdiff` resolves
- [ ] `nvim`: `:echo $MYVIMRC` resolves, and vim-plug installs/loads plugins
      under `~/.local/share/nvim/plugged` without errors
- [ ] Yank a line in Neovim and paste it into another app (confirms `win32yank`)
- [ ] `git config --get core.editor` prints `nvim`, and `git mergetool` on a
      conflict opens `nvimdiff`
- [ ] `nvimdiff file1 file2` from PowerShell opens a diff view

## Notes

### What's ported

- **Env vars / PATH / the `nvimdiff` alias** → `powershell/Profile.ps1`
  (equivalent of the non-Oh-My-Zsh parts of `../bash/.zshrc` and the
  Windows-relevant parts of `../bash/Documents/bin/addExternals`).
- **Neovim config** (`../common/.config/nvim/`): needs no changes. It already
  defaults to a Windows-safe code path and runs natively.
- **Git config** (`../common/.gitconfig`): works as-is. `core.editor` points at
  `nvim` (works on all three OSes).

### What's NOT ported

- **tmux**: no native Windows build. Would require WSL, which is out of scope
  here. See [PSMux](https://github.com/psmux/psmux)
- **`../Documents/bin/*` scripts**: these are bash scripts (several with
  hardcoded Unix paths and dependencies like `awk`/`sed`/`ps`/`pbcopy`). They'd
  need individual rewrites as PowerShell equivalents; not part of this pass.
