#! /usr/bin/env bash

# Get OS name
unameOut="$(uname -s)"

if [ "$unameOut" = 'Linux' ]; then
  isLinux='yes'
fi



main() {
  arg="$1"

  case "$arg" in
    '')
      install
      ;;
    '--help')
      help
      ;;
    '--uninstall')
      uninstall
      ;;
  esac
}

help() {
  echo "Setup script: $(ifLinux 'Linux' 'Mac')"
  echo 'pass no arguments to install'
  echo 'pass --help to see this message'
  echo 'pass --uninstall to uninstall'
}

install() {
  setup

  printf "Installing packages\n\n"

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

  if ! [ "$(ifLinux)" ]; then
    checkCommandInstalled 'brew' 'https://brew.sh/'
  fi

  # Zsh
  installPackage 'native' 'zsh' 'zsh'
  if [ "$SHELL" != '/bin/zsh' ]; then
    chsh -s /usr/local/bin/zsh
  fi

  # Oh My Zsh
  if [ -d "$HOME/.oh-my-zsh" ]; then
    echo 'Oh My Zsh already installed'
  else
    echo 'Manually install Oh My Zsh at (https://ohmyz.sh/)'
    echo 'Rerun to continue'
    exit 1
  fi

  # NVM
  checkCommandInstalled 'nvm' 'https://github.com/nvm-sh/nvm#installing-and-updating'

  if [ "$(ifAlreadyInstalled 'node')" ]; then
    echo 'Node already installed'
  else
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    echo 'Installing node'
    nvm install node
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

  # React Native 
  installPackage 'native' 'watchman' 'watchman'

  # Java
  if [ "$(ifAlreadyInstalled 'java')" ]; then
    echo 'Java already installed'
  else
    if [ "$isLinux" ]; then
      echo 'TODO: Install Java Linux'
      exit 1
    else
      echo 'Installing Java'
      brew tap homebrew/cask-versions
      brew install --cask zulu11
    fi
  fi

  # Go
  checkCommandInstalled 'go' 'https://go.dev/'

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

  ifAppInstalled 'Visual Studio Code' 'https://code.visualstudio.com/'

  # VS Code
  checkAppInstalled 'Visual Studio Code' 'https://code.visualstudio.com/'
  checkCommandInstalled 'code' 'https://code.visualstudio.com/docs/editor/command-line'

  # Spotify
  checkAppInstalled 'Spotify' 'https://www.spotify.com/us/'

  # Flipper
  checkAppInstalled 'Flipper' 'https://fbflipper.com/'

  # Android Studio
  checkAppInstalled 'Android Studio' 'https://developer.android.com/studio'

  # Spectacle
  if ! [ "$isLinux" ]; then
    checkAppInstalled 'Spectacle' 'https://www.spectacleapp.com/'
  fi

  # XCode/Cocoapods
  if ! [ "$isLinux" ]; then
    checkAppInstalled 'Xcode' 'https://apps.apple.com/us/app/xcode/id497799835?mt=12'
    installPackage 'ruby' 'cocoapods' 'pod'
  fi

  printf '\n\nInstalling Done!!!!'
}

setup() {
  # Setup NVM
  if ! [ "$(ifAlreadyInstalled 'nvm')" ]; then
    echo 'Setting up nvm'
    export NVM_DIR="$HOME/.nvm"
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
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

        npm install --global "$package"
        ;;
      'ruby')
        echo "Installing ruby package $package"

        gem install "$package"
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

checkCommandInstalled() {
  cli_command="$1"
  url="$2"

  if [ "$(ifAlreadyInstalled "$cli_command")" ]; then
    echo "$cli_command already installed"
  else
    echo "Manually install $cli_command ($url)"
    echo 'Rerun to continue'
    exit 1
  fi
}

checkAppInstalled() {
  app_name="$1"
  url="$2"

  if [ "$(ifAppInstalled "$app_name")" ]; then
      echo "$app_name already installed"
  else
    echo "Manually install $app_name ($url)"
    echo 'Rerun to continue'
    exit 1
  fi
}

ifAppInstalled() {
  app_name="$1"

  [ -d "/Applications/$app_name.app" ] && echo "$app_name exists."
}

ifAlreadyInstalled() {
  package_command="$1"

  if [ -n "$package_command" ]; then
    if [ "$(command -v "$package_command")"  ]; then
      echo true
      return 0
    fi
  fi

  return 1
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
