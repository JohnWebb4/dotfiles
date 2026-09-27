# Mac / Linux setup

Checklist to run through on a new machine. Some commands differ. 

Mac uses Homebrew (`brew install …`) and Linux uses apt (`sudo apt install …`).

## Packages

- [ ] **Mac only:** [Homebrew](https://brew.sh/)
- [ ] zsh: `brew install zsh` / `sudo apt install zsh`, then make it the
      default shell: `chsh -s /bin/zsh` (Mac) / `chsh -s /usr/bin/zsh` (Linux)
- [ ] [nvm](https://github.com/nvm-sh/nvm#installing-and-updating), then
      `nvm install node`
- [ ] Neovim: `brew install neovim` / `sudo apt install neovim`
- [ ] [vim-plug](https://github.com/junegunn/vim-plug) for Neovim
- [ ] yarn: `npm install --global yarn`
- [ ] [Go](https://go.dev/)
- [ ] [Rust / rustup](https://www.rust-lang.org/)
- [ ] fzf: `brew install fzf` / `sudo apt install fzf`
- [ ] The Silver Searcher (`ag`): `brew install the_silver_searcher` /
      `sudo apt install silversearcher-ag`
- [ ] ripgrep (`rg`): `brew install ripgrep` / `sudo apt install ripgrep`
- [ ] **Linux only:** `sudo apt install xclip gnome-tweaks`
- [ ] **Mac only:** Rectangle: `brew install rectangle`

## Apps

- [ ] [VS Code](https://code.visualstudio.com/), plus the
      [`code` CLI](https://code.visualstudio.com/docs/editor/command-line)

## Link configs

- [ ] From the repo root run `./link.sh`
- [ ] Copy `sample.env.zshrc` to `~/env.zshrc` and fill it in
- [ ] Copy `../common/sample.env.gitconfig` to `~/env.gitconfig` and fill it in
- [ ] Open a new terminal and confirm zsh loads cleanly

## Optional: React Native / mobile

- [ ] watchman: `brew install watchman` / `sudo apt install watchman`
- [ ] Java Version: Mac `brew tap homebrew/cask-versions && brew install --cask zulu11`
      / Linux `sudo apt install openjdk-11-jdk`
- [ ] [Android Studio](https://developer.android.com/studio)
- [ ] **Mac only:** [Xcode](https://apps.apple.com/us/app/xcode/id497799835?mt=12),
      then `gem install cocoapods`
