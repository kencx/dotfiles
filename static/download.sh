#! /bin/bash

# Run this setup script on a new env to install all packages

sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get autoremove

APPS="git bspwm sxhkd feh rofi neovim"

# Install packages
sudo apt-get install -y $APPS


# Install further apps
cd ~/Downloads
# gotop, bonsai

# picom
# sudo apt install cmake meson git pkg-config asciidoc libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev  libpcre2-dev  libevdev-dev uthash-dev libev-dev libx11-xcb-dev
# git clone https://github.com/jonaburg/picom
# cd picom
# git submodule update --init --recursive
# meson --buildtype=release . build
# ninja -C build
# sudo ninja -C build install
# cd ~/Downloads

# kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# pfetch
cd ~/Downloads
curl -s https://api.github.com/repos/dylanaraps/pfetch/releases/latest \
| grep "tarball_url" \
| cut -d '"' -f 4 \
| wget -qi -
tar xvf 0.6.0
cp dylanaraps-pfetch-675814f/pfetch /usr/local/bin/pfetch



# move to setup
# Remove xfce from session startup
# Add bspwm sxhkd to session startup
# Add ~/.fehbg
