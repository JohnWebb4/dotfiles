# PowerShell equivalent of the non-Oh-My-Zsh parts of ../bash/.zshrc and the
# Windows-relevant parts of ../bash/Documents/bin/addExternals.
#
# Dot-sourced from $PROFILE; run ..\link.ps1 to add that line for you.
# See powershell/README.md for full setup steps.

# Local, untracked overrides/secrets (mirrors ~/env.zshrc on Unix). Sourced
# early so flags like ENABLE_REACT_NATIVE below are already set.
$envProfile = Join-Path $HOME 'env.profile.ps1'
if (Test-Path $envProfile) {
    . $envProfile
}

# Neovim on Windows defaults to ~\AppData\Local\nvim; honor ~\.config (where
# link.ps1 junctions common\.config\nvim) like on Unix.
$env:XDG_CONFIG_HOME = Join-Path $HOME '.config'

# FZF (same file-search pattern as .zshrc). Note: fzf on Windows runs this
# command via cmd.exe by default, so redirect to 'nul', not '/dev/null'.
$env:FZF_DEFAULT_COMMAND = 'rg --files --no-ignore --hidden --follow -g "!{.git,.npm,.nvm,.Trash,node_modules,*/__snapshots__}/*" 2> nul'
$env:FZF_CTRL_T_COMMAND = $env:FZF_DEFAULT_COMMAND
$env:FZF_ALT_C_COMMAND = $env:FZF_DEFAULT_COMMAND

# Mise activation (if installed)
if (Get-Command mise -ErrorAction SilentlyContinue) {
    (mise activate pwsh) | Out-String | Invoke-Expression
}
