#!/usr/bin/env bash

ln -sf $DOTFILES/installers/git/gitconfig ~/.gitconfig
ln -sf $DOTFILES/installers/git/gitconfig.user ~/.gitconfig.user

ruby $DOTFILES/installers/git/clone.rb
