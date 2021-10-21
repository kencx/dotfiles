#! /bin/bash

set -euo pipefail

# stow configs 
echo "Copying configurations..."
cd "$HOME/dotfiles" 

for f in */;
do
  stow --verbose=1 "$f"
done


# TODO: add .Xresources, .mozilla
