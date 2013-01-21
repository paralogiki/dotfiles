#!/bin/bash

# A bit heavy handed, should probably do links instead

function copyfiles() {
  if [[ "$1" != "" && "$2" != "" ]]; then
    if [ -d "$1" ]; then
      cp -r "$1" "$2/"
    else
      cp "$1" "$2"
    fi
  fi
}

for name in *; do
  target="$HOME/.$name"
  if [[ $name != 'install.sh' && $name != 'README.md' && $name != 'gitconfig' && $name != 'bk' ]]; then
    if [ -e "$target" ]; then
      if [ ! -d "$PWD/bk" ]; then
        mkdir "$PWD/bk"
      fi
      read -p "$target exists, overwrite? (Y=yes, N=no, B=backup) " yn
      case $yn in
        [Yy]* ) rm -r "$target"; copyfiles "$name" "$target";;
        [Nn]* ) echo "skipping $target";;
        [Bb]* ) mv "$target" "$PWD/bk/"; copyfiles "$name" "$target";;
      esac
    else
      copyfiles "$name" "$target"
    fi
  fi
done
