#!/bin/bash

print_usage() {
  printf "[-d]\tdo not install dependencies\n";
  exit 111;
}
# need these for deps
echo "linking .bashrc"
rm ~/.bashrc
ln -s $PWD/home/.bashrc ~/.bashrc

echo "linking .zshrc"
rm ~/.zshrc
ln -s $PWD/home/.zshrc ~/.zshrc

skip_deps=

while getopts dh flag; 
do
  case $flag in
    d) skip_deps=1 ;;
    h) print_usage ;;
    ?) print_usage
       exit 2 ;;
  esac
done

if [ ! -z "$skip_deps" ]; then
  echo "Skipping dependency install"
else
  source $PWD/deps.sh
fi

source $PWD/linking.sh

