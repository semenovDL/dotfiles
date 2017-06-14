#!/usr/bin/env bash

# Set zsh as default shell
if [ "echo $SHELL" == "echo $(which zsh)" ]; then
  grep -qF $(which zsh) /etc/shells || echo $(which zsh) | sudo tee -a /etc/shells
  chsh -s $(which zsh)
fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Link to local zshrc
ln -sf ~/.dotfiles/install/zsh/zshrc.sh ~/.zshrc
