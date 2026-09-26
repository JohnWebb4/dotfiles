# PowerShell equivalent of the non-Oh-My-Zsh parts of ../.zshrc and the
# Windows-relevant parts of ../Documents/bin/addExternals.
#
# Usage: dot-source this from your real profile ($PROFILE), e.g.:
#   . "C:\Users\johnw\Documents\coding\dotfiles\main\windows\Profile.ps1"
#
# See windows/README.md for full setup steps.

$RepoRoot = Split-Path -Parent $PSScriptRoot

# Local, untracked overrides/secrets (mirrors ~/env.zshrc on Unix). Sourced
# early so flags like ENABLE_REACT_NATIVE below are already set.
$envProfile = Join-Path $HOME 'env.profile.ps1'
if (Test-Path $envProfile) {
    . $envProfile
}

# Point Neovim at this repo's .config/nvim without symlinking anything.
# Neovim honors XDG_CONFIG_HOME on Windows the same as on Unix.
$env:XDG_CONFIG_HOME = Join-Path $RepoRoot '.config'

# FZF (same file-search pattern as .zshrc). Note: fzf on Windows runs this
# command via cmd.exe by default, so redirect to 'nul', not '/dev/null'.
$env:FZF_DEFAULT_COMMAND = 'rg --files --no-ignore --hidden --follow -g "!{.git,.npm,.nvm,.Trash,node_modules,*/__snapshots__}/*" 2> nul'
$env:FZF_CTRL_T_COMMAND = $env:FZF_DEFAULT_COMMAND
$env:FZF_ALT_C_COMMAND = $env:FZF_DEFAULT_COMMAND

# Neovimdiff (port of the `alias nvimdiff="nvim -d"` in .zshrc)
function nvimdiff {
    nvim -d @args
}

# PATH helper: port of checkAndAppendPath/ifLinux from addExternals, minus
# the bash-specific parameter expansion. Only appends if the folder exists
# and isn't already on PATH.
function Add-PathEntry {
    param(
        [Parameter(Mandatory)] [string] $Path,
        [switch] $Prepend
    )

    if (-not (Test-Path $Path)) {
        return
    }

    $current = $env:Path -split ';'
    if ($current -contains $Path) {
        return
    }

    if ($Prepend) {
        $env:Path = "$Path;$env:Path"
    } else {
        $env:Path = "$env:Path;$Path"
    }
}

Add-PathEntry -Path (Join-Path $HOME '.local\bin')

# Mise shims (if mise is installed and used for tool version management)
Add-PathEntry -Path (Join-Path $env:LOCALAPPDATA 'mise\shims')

if ($env:ENABLE_REACT_NATIVE -eq 'true') {
    Write-Host 'Adding Android SDK to path'
    $env:ANDROID_HOME = Join-Path $env:LOCALAPPDATA 'Android\Sdk'
    Add-PathEntry -Path (Join-Path $env:ANDROID_HOME 'platform-tools')
}

# Mise activation (if installed)
if (Get-Command mise -ErrorAction SilentlyContinue) {
    (mise activate pwsh) | Out-String | Invoke-Expression
}
