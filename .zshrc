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

# ZSH Config folder
ZSH="$HOME/.oh-my-zsh"
source "$ZSH/oh-my-zsh.sh"

# Google Cloud alias
# alias gcurl='curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" -H "Content-Type: application/json"'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# if [[ $isLinux ]]; then
# else
  # The next line updates PATH for the Google Cloud SDK.
  # if [ -f '/Users/john.webb/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/john.webb/google-cloud-sdk/path.zsh.inc'; fi

  # The next line enables shell command completion for gcloud.
  # if [ -f '/Users/john.webb/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/john.webb/google-cloud-sdk/completion.zsh.inc'; fi
# fi

# Setup NVM
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# GPG
export GPG_TTY=$(tty)

# JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

# export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
# Asdf post block.
# if ! [[ $isLinux ]]; then
# . /opt/homebrew/opt/asdf/libexec/asdf.sh
# fi

# Fix less pager only updating the top half of the terminal on macbook
export LESS=-R

# # FZF
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,.npm,.nvm,.Trash,node_modules,*/__snapshots__}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

# # Elixir
export 'KERL_CONFIGURE_OPTIONS'="$(ifLinux '' '--disable-silent-rules --enable-dynamic-ssl-lib --enable-shared-zlib --enable-smp-support --enable-threads --enable-wx --with-ssl=$(brew --prefix openssl@1.1) --without-javac --enable-kernel-poll --with-dynamic-trace=dtrace --enable-vm-probes --enable-darwin-64bit')"

# Cleanup
# Unset OS name
unset unameOut
