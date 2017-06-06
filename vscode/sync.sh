#!/usr/bin/env bash

# Save installed vscode extensions list
EXTENSIONS_FILE=~/.dotfiles/vscode/extensions.yml
echo "recommended:" > $EXTENSIONS_FILE
code --list-extensions | sed -e 's/^/  - /' >> $EXTENSIONS_FILE
