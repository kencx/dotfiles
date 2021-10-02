#! /bin/bash

set -euo pipefail

echo "Installing fonts..."

mkdir -p ~/.local/share/fonts

cd ~/.local/share/fonts && curl -fLo "Fira Code Regular Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf
