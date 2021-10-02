#! /bin/bash

set -euo pipefail

echo "Installing pfetch..."
cd ~/Downloads
git clone https://github.com/dylanaraps/pfetch.git && cd pfetch
cp pfetch "$HOME/bin/"
cd ~/Downloads && rm -r pfetch

echo "pfetch installed."

