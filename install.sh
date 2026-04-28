#!/bin/bash

print_usage() {
  printf "Usage: install.sh [-d] [-h]\n"
  printf "  -d  skip dependency installation (linking only)\n"
  exit 0
}

skip_deps=

while getopts dh flag; do
  case $flag in
    d) skip_deps=1 ;;
    h) print_usage ;;
    ?) print_usage; exit 2 ;;
  esac
done

if [[ -z "$skip_deps" ]]; then
  source "$PWD/deps.sh"
else
  echo "Skipping dependency install"
fi

source "$PWD/linking.sh"
