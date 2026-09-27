#!/usr/bin/env bash
# Link repo configs into $HOME (Mac/Linux).

set -eu

REPO="$(cd "$(dirname "$0")" && pwd)"

# "source-relative-to-repo|target-relative-to-HOME"
LINKS=(
  "common/.vimrc|.vimrc"
  "common/.tmux.conf|.tmux.conf"
  "common/.config/nvim|.config/nvim"
  "bash/.zshrc|.zshrc"
  "bash/.bashrc|.bashrc"
  "bash/.profile|.profile"
  "bash/Documents/bin|Documents/bin"
)

link() {
  src="$REPO/$1"
  dest="$HOME/$2"

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "ok       $dest"
    return
  fi

  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mv "$dest" "$dest.bak"
    echo "backup   $dest -> $dest.bak"
  fi
  ln -s "$src" "$dest"
  echo "linked   $dest -> $src"
}

include_git_config() {
  include_line="	path = $REPO/common/.gitconfig"
  gitconfig="$HOME/.gitconfig"

  if [ -f "$gitconfig" ] && grep -qF "$include_line" "$gitconfig"; then
    echo "ok       $gitconfig (include present)"
    return
  fi
  printf '[include]\n%s\n' "$include_line" >> "$gitconfig"
  echo "updated  $gitconfig (added include)"
}


for entry in "${LINKS[@]}"; do link "${entry%%|*}" "${entry##*|}"; done
include_git_config
