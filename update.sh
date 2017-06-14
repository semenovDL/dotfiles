#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install all available updates
echo "› sudo softwareupdate -i -a"
sudo softwareupdate -ia

# Upgrade homebrew
echo "› brew update"
brew update
echo "› brew upgrade"
brew upgrade

# Cleanup
echo "> brew bundle cleanup"
brew bundle cleanup --force --file=~/.dotfiles/install/homebrew/brewfile.rb
echo "> brew cleanup"
brew cleanup
