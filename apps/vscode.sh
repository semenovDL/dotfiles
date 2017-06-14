#!/usr/bin/env bash

VSCODE_DF=~/.dotfiles/apps/vscode
# Install extensions
cat $VSCODE_DF/extensions.yml |
  rq -y 'at "recommended"|spread' |
  xargs -L 1 code --install-extension

# Alias settings
VSCODE_USER=~/Library/Application\ Support/Code/User
ln -sf $VSCODE_DF/keybindings.json "${VSCODE_USER}/keybindings.json"
ln -sf $VSCODE_DF/locale.json "${VSCODE_USER}/locale.json"
ln -sf $VSCODE_DF/settings.json "${VSCODE_USER}/settings.json"
