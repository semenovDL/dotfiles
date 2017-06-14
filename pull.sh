#!/usr/bin/env bash

export DOTFILES=$HOME/.dotfiles

if [ ! -d "$DOTFILES" ]; then
  echo "Installing dotfiles for the first time"
  git clone --depth=1 https://github.com/semenovDL/dotfiles.git "$DOTFILES"
else
  echo "Dotfiles is already installed"
fi

echo "Update dotfiles"
(cd $DOTFILES && git pull --rebase)

echo "Run installer"
source $DOTFILES/install.sh
