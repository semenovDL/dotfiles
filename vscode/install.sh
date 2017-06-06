#!/usr/bin/env bash

# Install extensions
cat $DOTFILES/vscode/extensions.yml |
  rq -y 'at "recommended"|spread' |
  xargs -L 1 code --install-extension

# Alias settings
VSCODE_USER=~/Library/Application\ Support/Code/User
ln -sf $DOTFILES/vscode/keybindings.json $VSCODE_USER/keybindings.json
ln -sf $DOTFILES/vscode/locale.json $VSCODE_USER/locale.json
ln -sf $DOTFILES/vscode/settings.json $VSCODE_USER/settings.json
