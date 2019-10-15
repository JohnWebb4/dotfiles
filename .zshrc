# Get OS name
unameOut="$(uname -s)"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# All PATH Variables
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
# Flutter
export PATH="$PATH:/usr/local/share/flutter/bin"
# GO
export PATH="$PATH:/usr/local/go/bin"

# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Bash
export PATH="$PATH:$HOME//Documents/bin"

# Google Depot Tools (V8)
export PATH="$PATH:/usr/local/share/depot_tools"

if [[ $unameOut == 'Linux' ]]; then
  # Ruby
  export PATH="$PATH://home/john/.gem/ruby/2.6.0/bin"

  # Web assembly
  export PATH="//home/john/.local/share/emsdk:/home/john/.local/share/emsdk/clang/e1.38.25_64bit:/home/john/.local/share/emsdk/node/8.9.1_64bit/bin:/home/john/.local/share/emsdk/emscripten/1.38.25:$PATH"
else
  export PATH="$PATH:/Users/john.webb/kotlinc/bin"
  export PATH="$PATH:/Library/Ruby/Gems/2.3.0"
  export PATH="$PATH:/Users/john.webb/.gem/ruby/2.3.0"
fi

# ZSH Config folder
if [[ $unameOut == 'Linux' ]]; then
  export ZSH="/home/john/.oh-my-zsh"
else
  export ZSH="/Users/john.webb/.oh-my-zsh"
fi

# Android Platform tools
# Android Home
if [[ $unameOut == 'Linux' ]]; then
  export ANDROID_HOME="/home/john/Android/Sdk"
else
  export PATH=$PATH:/Users/john.webb/Library/Android/sdk/platform-tools

  export ANDROID_HOME=/Users/john.webb/Library/Android/sdk
fi


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME="spaceship"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# My addons
if [[ $unameOut == 'Linux' ]]; then
    # Configure vim to use App image
    alias nvim=/usr/local/share/nvim/nvim.appimage
    alias sudo="sudo "
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

# Use brew python, if available
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# FZF Shit
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,.npm,.nvm,.Trash,node_modules,*/__snapshots__}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

if [[ $unameOut == 'Linux' ]]; then
else
  # The next line updates PATH for the Google Cloud SDK.
  if [ -f '/Users/john.webb/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/john.webb/google-cloud-sdk/path.zsh.inc'; fi

  # The next line enables shell command completion for gcloud.
  if [ -f '/Users/john.webb/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/john.webb/google-cloud-sdk/completion.zsh.inc'; fi
fi

# Cleanup
# Unset OS name
unset unameOut

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="/Users/john.webb/.sdkman"
# [[ -s "/Users/john.webb/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/john.webb/.sdkman/bin/sdkman-init.sh"
