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

function makebkdir {
  if [ ! -d "$PWD/bk" ]; then
    mkdir "$PWD/bk"
  fi
}

for name in *; do
  target="$HOME/.$name"
  if [[ $name != 'install.sh' && $name != 'README.md' && $name != 'gitconfig' && $name != 'bk' ]]; then
    if [ -e "$target" ]; then
      menu () {
        read -p "$target exists, overwrite? (Y=yes, N=no, B=backup, D=diff) " yn
        case $yn in
          [Yy]* ) rm -r "$target"
                  copyfiles "$name" "$target";;
          [Nn]* ) echo "skipping $target";;
          [Bb]* ) makebkdir
                  mv "$target" "$PWD/bk/"
                  copyfiles "$name" "$target";;
          [Dd]* ) diff "$name" "$target"
                  menu;;
              * ) echo "Valid response are Y/N/B/D"
                  menu;;
        esac
      }
      menu
    else
      copyfiles "$name" "$target"
    fi
  fi
done

# Make $HOME/.tmp used by vim for backups/tmp files
if [ ! -d "$HOME/.tmp" ]
  mkdir "$HOME/.tmp"
fi
