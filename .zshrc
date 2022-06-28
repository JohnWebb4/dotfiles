# Get OS name
unameOut="$(uname -s)"

if [[ $unameOut == 'Linux' ]]; then
  isLinux='yes'
fi

if [[ $isLinux ]]; then
  test "$(</proc/sys/kernel/osrelease)" != 'Microsoft' && isWSL='yes'
fi

source "$HOME/Documents/bin/addExternals"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
  git
)

source "$ZSH/oh-my-zsh.sh"

# My addons
if [ $isLinux ]; then
    # Configure vim to use App image
    if test -d '/usr/local/share/nvim'; then
	if test -d '/usr/local/share/nvim/squashfs-root'; then
            alias nvim=/usr/local/share/nvim/squashfs-root/AppRun
        else
            alias nvim=/usr/local/share/nvim/nvim.appimage
        fi
    fi

    alias sudo="sudo "
    alias open=$HOME/Documents/bin/open
fi

# Google Cloud alias
alias gcurl='curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" -H "Content-Type: application/json"'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/john/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/john/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/john/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/john/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

if [[ $isLinux ]]; then
else
  # The next line updates PATH for the Google Cloud SDK.
  if [ -f '/Users/john.webb/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/john.webb/google-cloud-sdk/path.zsh.inc'; fi

  # The next line enables shell command completion for gcloud.
  if [ -f '/Users/john.webb/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/john.webb/google-cloud-sdk/completion.zsh.inc'; fi
fi

# Package managers
if [[ $isLinux ]]; then
else
  eval "$(/usr/local/homebrew/bin/brew shellenv)"
  . "/usr/local/opt/asdf/asdf.sh"
fi

# Elixir
export KERL_CONFIGURE_OPTIONS="--disable-silent-rules --enable-dynamic-ssl-lib --enable-shared-zlib --enable-smp-support --enable-threads --enable-wx --with-ssl=$(brew --prefix openssl@1.1) --without-javac --enable-kernel-poll --with-dynamic-trace=dtrace --enable-vm-probes --enable-darwin-64bit"

# Setup NVM
export NVM_DIR="$HOME/.nvm"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# GPG
export GPG_TTY=$(tty)

# Cleanup
# Unset OS name
unset unameOut
