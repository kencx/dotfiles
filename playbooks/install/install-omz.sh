#! /bin/bash

set -euo pipefail

# Install zsh and oh-my-zsh
echo "Installing zsh, oh-my-zsh"
sudo apt -q install -y zsh

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

else
  echo "oh-my-zsh already installed"
fi

