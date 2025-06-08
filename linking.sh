#!/bin/bash
#dirs
config_dir="$HOME/.config"

echo "creating missing directories"

mkdir -p $config_dir

echo "symlinking from: $PWD"
rm -rf $config_dir/wezterm
mkdir -p $config_dir/wezterm
ln -s $PWD/.config/wezterm/* $config_dir/wezterm/

