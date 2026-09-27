# Link repo configs into $HOME (Windows).
#
# Directories use junctions (no admin needed). Files use symlinks.

$Repo = $PSScriptRoot

# Source (relative to repo) -> target (relative to $HOME)
$Dirs = @(
    @{ Src = 'common\.config\nvim'; Dest = '.config\nvim' }
)
$Files = @(
    @{ Src = 'common\.vimrc'; Dest = '.vimrc' }
    @{ Src = 'common\.tmux.conf'; Dest = '.tmux.conf' }
)

function Get-LinkTarget($path) {
    $item = Get-Item $path -Force -ErrorAction SilentlyContinue
    if ($item -and $item.LinkType) { return [string]$item.Target }
    return $null
}

function Set-Link($srcRel, $destRel, $type) {
    $src = Join-Path $Repo $srcRel
    $dest = Join-Path $HOME $destRel

    if ((Get-LinkTarget $dest) -eq $src) {
        Write-Host "ok       $dest"
        return
    }

    New-Item -ItemType Directory -Force -Path (Split-Path $dest) | Out-Null
    if (Test-Path $dest) {
        Move-Item $dest "$dest.bak" -Force
        Write-Host "backup   $dest -> $dest.bak"
    }
    try {
        New-Item -ItemType $type -Path $dest -Value $src -ErrorAction Stop | Out-Null
        Write-Host "linked   $dest -> $src"
    } catch {
        Write-Warning "could not link $dest ($($_.Exception.Message)). Enable Developer Mode or run elevated."
    }
}

# Profile: dot-source stub, works in both Windows PowerShell and pwsh.
function Set-ProfileStub {
    $line = ". `"$Repo\powershell\Profile.ps1`""
    New-Item -ItemType Directory -Force -Path (Split-Path $PROFILE) | Out-Null
    if ((Test-Path $PROFILE) -and (Select-String -Path $PROFILE -SimpleMatch $line -Quiet)) {
        Write-Host "ok       $PROFILE (stub present)"
        return
    }
    Add-Content -Path $PROFILE -Value $line
    Write-Host "updated  $PROFILE (added dot-source)"
}

# Git supports includes natively, so keep ~/.gitconfig a real, local file.
function Set-GitInclude {
    $gitconfig = Join-Path $HOME '.gitconfig'
    $path = "$Repo\common\.gitconfig" -replace '\\', '/'
    $line = "`tpath = $path"
    if ((Test-Path $gitconfig) -and (Select-String -Path $gitconfig -SimpleMatch $path -Quiet)) {
        Write-Host "ok       $gitconfig (include present)"
        return
    }
    Add-Content -Path $gitconfig -Value "[include]`n$line"
    Write-Host "updated  $gitconfig (added include)"
}

foreach ($l in $Dirs) { Set-Link $l.Src $l.Dest 'Junction' }
foreach ($l in $Files) { Set-Link $l.Src $l.Dest 'SymbolicLink' }
Set-ProfileStub
Set-GitInclude
