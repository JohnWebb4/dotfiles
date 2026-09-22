# Get OS name
unameOut="$(uname -s)"

if [[ $unameOut == 'Linux' ]]; then
  isLinux='yes'
fi

source $HOME/env.zshrc
source "$HOME/Documents/bin/addExternals"

# Git integration: Disable tracking file changes. For large repos
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Google Cloud alias
# alias gcurl='curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" -H "Content-Type: application/json"'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# GPG
export GPG_TTY=$(tty)

if [[ "$ENABLE_REACT_NATIVE" = true ]]; then
  echo 'Enabling React Native'
  JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
fi

# Fix less pager only updating the top half of the terminal on macbook
export LESS=-R

# # FZF
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,.npm,.nvm,.Trash,node_modules,*/__snapshots__}/*" 2> /dev/null'

# # Elixir
if [[ $isLinux ]]; then
else
  export 'KERL_CONFIGURE_OPTIONS'='--disable-silent-rules --enable-dynamic-ssl-lib --enable-shared-zlib --enable-smp-support --enable-threads --enable-wx --with-ssl=$(brew --prefix openssl@1.1) --without-javac --enable-kernel-poll --with-dynamic-trace=dtrace --enable-vm-probes --enable-darwin-64bit'
fi

# Cleanup
# Unset OS name
unset unameOut

# Mise
if [[ $ENABLE_MISE ]]; then
  echo 'Enabling Mise'
  eval "$(mise activate zsh)"
fi
