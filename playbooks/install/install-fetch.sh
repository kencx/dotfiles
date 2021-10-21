#! /bin/bash

set -euo pipefail

echo "Installing pfetch..."
git clone https://github.com/dylanaraps/pfetch.git && cd pfetch
cp pfetch "$HOME/bin/"
cd ~/temp

echo "pfetch installed."

