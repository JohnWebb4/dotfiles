#! /usr/bin/env sh

# Get OS name
unameOut="$(uname -s)"

if [ "$unameOut" = 'Linux' ]; then
  isLinux='yes'
fi

main() {
  arg="$1"

  case "$arg" in
    '')
      help
      ;;
    '--help')
      help
      exit 0
      ;;
    '--install')
      install || exit 1
      ;;
    '--uninstall')
      uninstall || exit 1
      ;;
  esac
}

help() {
  echo "Setup script: $(ifLinux 'Linux' 'Mac')"
  echo 'pass --install to install'
  echo 'pass --uninstall to uninstall'
}

install() {
  echo 'Installing packages'

  # Powerline
  printf 'Install Powerline Fonts [y/n]? '
  read -r
  if [ "$REPLY" = 'y' ]; then
    echo 'Installing Powerline'
    git clone https://github.com/powerline/fonts.git --depth=1
    cd fonts || return
    ./install.sh
    cd ..
    rm -rf fonts
  else
    echo 'Skipping Powerline install'
  fi

  # Zsh
  installPackage 'native' 'zsh' 'zsh'
  if [ "$SHELL" != '/bin/zsh' ]; then
    chsh -s /usr/local/bin/zsh
  fi

  # Oh My Zsh
  if [ "$(ifAlreadyInstalled 'upgrade_oh_my_zsh')" ]; then
    echo 'Oh My Zsh already installed'
  else
    echo 'Manually install Oh My Zsh at (https://ohmyz.sh/)'
    echo 'Rerun to continue'
    exit 1
  fi

  # NVM
  if [ "$(ifAlreadyInstalled 'nvm')" ]; then
    echo 'NVM already installed'

  else
    echo 'Manually install NVM (https://github.com/nvm-sh/nvm)'
    echo 'Rerun to continue'
    exit 1
  fi

  if [ "$(ifAlreadyInstalled 'node')" ]; then
    echo 'Node already installed'
  else
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    echo 'Installing node'
    nvm install lts
  fi

  # Neovim
  if [ "$(ifAlreadyInstalled 'nvim')" ]; then
    echo 'neovim already installed'
  else
    installPackage 'native' 'neovim' 'nvim'

    # Vim Plug
    echo 'Manually install NeoVim Plug (https://github.com/junegunn/vim-plug)'
    echo 'Rerun to continue'
    exit 1
  fi

  # Yarn
  installPackage 'node' 'yarn' 'yarn'

  # FZF
  installPackage 'native' 'fzf' 'fzf'

  # Silver Searcher
  installPackage 'native' "$(ifLinux 'silversearcher-ag' 'the_silver_searcher')" 'ag'

  # Ripgrep
  installPackage 'native' 'ripgrep' 'rg'

  # XClip
  if [ "$isLinux" ]; then
    installPackage 'native' 'xclip' 'xclip'
  else
    echo 'Skipping XClip installation'
  fi
}

uninstall() {
  echo 'Uninstalling packages'
}

installPackage() {
  package_manager="$1"
  package="$2"
  package_command="$3"

  if [ "$(ifAlreadyInstalled "$package_command")" ]; then
    echo "$package already installed"
    return
  else
    echo "Installing $package"

    case "$package_manager" in
      'native')
        if [ "$isLinux" ]; then
          echo "Installing for Linux $package"

          apt install "$package"
        else
          echo "Installing for Mac $package"

          brew install "$package"
        fi
        ;;
      'node')
        echo "Installing node package $package"

        npm install "$package"
        ;;
    esac
  fi
}

uninstallPackage() {
  package_manager="$1"
  package="$2"
  package_command="$3"

  if [ "$(ifAlreadyInstalled "$package_command")" ]; then
    echo "Uninstalling $package"

    case "$package_manager" in
      'native')
        if [ "$isLinux" ]; then
          echo "Uninstalling for Linux $package"
        else
          echo "Uninstalling for Mac $package"
        fi
        ;;
    esac

  else
    echo "$package is already uninstalled"
    return
  fi
}

ifAlreadyInstalled() {
  package_command="$1"

  if [ -n "$package_command" ]; then
    if [ -n "$(command -v "$package_command")" ]; then
      echo true
      return
    else
      echo false
    fi
  fi
}


# If Linux return value, otherwise default
ifLinux() {
  linuxValue=$1
  defaultValue=$2

  if [ "$unameOut" = 'Linux' ]; then
    echo "$linuxValue"
  else
    echo "$defaultValue"
  fi
}

main "$@"
