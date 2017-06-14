#!/usr/bin/env bash

ln -sf ~/.dotfiles/install/git/gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/install/git/gitconfig.user ~/.gitconfig.user

ruby ~/.dotfiles/install/git/clone.rb
