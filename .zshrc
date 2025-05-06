# Get OS name
unameOut="$(uname -s)"

if [[ $unameOut == 'Linux' ]]; then
  isLinux='yes'
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
  z
)

source "$ZSH/oh-my-zsh.sh"

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

# Setup NVM
# export NVM_DIR="$HOME/.nvm"
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# GPG
export GPG_TTY=$(tty)

JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

# export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
# Asdf post block.
if ! [[ $isLinux ]]; then
. /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

# Cleanup
# Unset OS name
unset unameOut
