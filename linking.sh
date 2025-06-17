#!/bin/bash
#dirs
config_dir="$HOME/.config"

echo "creating missing directories"

mkdir -p $config_dir

echo "symlinking from: $PWD"

link_dir() {
  echo "linking $1 config"
  rm -rf $config_dir/$1
  mkdir -p $config_dir/$1
  ln -s $PWD/.config/$1/* $config_dir/$1/
}

link_dir wezterm
link_dir oh-my-posh
link_dir nvim
link_dir tmux
link_dir sesh


