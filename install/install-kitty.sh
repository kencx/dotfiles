#! /bin/bash

set -euo pipefail

# Install kitty https://sw.kovidgoyal.net/kitty/binary/

if [ ! -d "$HOME/.local/kitty.app" ]; then
  echo "Installing kitty..."

  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
    launch=n

  echo "Successfully installed. Performing Desktop integration..."

  ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
  cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/

  # Update the path to the kitty icon in the kitty.desktop file
  sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop

else
  echo "Kitty already installed."
fi
