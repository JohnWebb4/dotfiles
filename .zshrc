# Get OS name
unameOut="$(uname -s)"

source "$HOME/Documents/bin/addExternals"

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME="spaceship"

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
if [[ $unameOut == 'Linux' ]]; then
    # Configure vim to use App image
    alias nvim=/usr/local/share/nvim/nvim.appimage
    alias sudo="sudo "
    alias open=$HOME/Documents/bin/open
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export NVM_DIR="$HOME/.nvm"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# added by Anaconda3 2018.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/home/john/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/home/john/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/john/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/home/john/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

if [[ $unameOut == 'Linux' ]]; then
else
  # The next line updates PATH for the Google Cloud SDK.
  if [ -f '/Users/john.webb/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/john.webb/google-cloud-sdk/path.zsh.inc'; fi

  # The next line enables shell command completion for gcloud.
  if [ -f '/Users/john.webb/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/john.webb/google-cloud-sdk/completion.zsh.inc'; fi
fi

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="/Users/john.webb/.sdkman"
# [[ -s "/Users/john.webb/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/john.webb/.sdkman/bin/sdkman-init.sh"

# Cleanup
# Unset OS name
unset unameOut
