#! /bin/bash

set -euo pipefail

# Personal workstation installation

# Install apt packages
echo "Installing packages from apps.list"
sudo apt -q install -y $(grep -vE "^s*#" apps.list | tr "\n" " ")

# SHELL: zsh
./install-omz.sh

# TERMINAL: kitty
./install-kitty.sh

# FETCH: pfetch
./install-fetch.sh


# TODO: install picom, polybar, gotop

# Copy configurations
./stow-configs.sh

# Fonts
./install-fonts.sh


#echo "Downloading binaries from Github"
#cd ~/Downloads
#source download.sh
#
#download_linux_amd64 xxxserxxx/gotop
#download polybar/polybar
#
## Install binaries
#for f in "$(ls | grep -E ".*\.(tgz|tar.gz)$")";
#do
#	tar xf "$f"
#done
#
## gotop
#cp gotop ~/bin/
#rm -r gotop
#
## polybar
#sudo apt install build-essential cmake cmake-data pkg-config python3-sphinx python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev \ # hard dependencies 
#libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev # optional dependencies
#
## compiling
#cd polybar
#mkdir build && cd build
#cmake . .
#make -j$(nproc)
#sudo make install

## bspc wm -r

