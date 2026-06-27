#!/bin/bash
config_dir="$HOME/.config"

echo "creating missing directories"
mkdir -p "$config_dir"

echo "symlinking from: $PWD"

link_dir() {
  echo "linking $1 config"
  rm -rf "$config_dir/$1"
  mkdir -p "$config_dir/$1"
  ln -s "$PWD/.config/$1/"* "$config_dir/$1/"
}

# Link a directory but merge conf.d files individually (preserving machine-local files)
link_dir_with_confd() {
  echo "linking $1 config"
  rm -rf "$config_dir/$1"
  mkdir -p "$config_dir/$1"
  for f in "$PWD/.config/$1/"*; do
    [ "$(basename "$f")" = "conf.d" ] && continue
    ln -s "$f" "$config_dir/$1/$(basename "$f")"
  done
  if [ -d "$PWD/.config/$1/conf.d" ]; then
    mkdir -p "$config_dir/$1/conf.d"
    for f in "$PWD/.config/$1/conf.d/"*; do
      ln -sf "$f" "$config_dir/$1/conf.d/$(basename "$f")"
    done
  fi
}

link_dir wezterm
link_dir nvim
link_dir tmux
link_dir sesh
link_dir_with_confd fish
