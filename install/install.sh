#! /bin/bash

# Personal workstation installation

# Install apt packages
echo "Installing "
sudo apt -q install -y $(grep -vE "^s*#" apps.list | tr "\n" " ")

# SHELL: zsh
echo "Installing zsh, oh-my-zsh..."
sudo apt -q install -y zsh
sh -c "$(wget -q https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# TERMINAL: kitty
echo "Installing kitty..."
curl -Ls https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# pfetch
echo "Installing pfetch..."
cd ~/Downloads
git clone https://github.com/dylanaraps/pfetch.git
cd pfetch
cp pfetch ~/bin/
cd ..
rm -r pfetch

# TODO: install picom

echo "Downloading binaries from Github"
cd ~/Downloads
source download.sh

download_linux_amd64 xxxserxxx/gotop
download polybar/polybar

# Install binaries
for f in "$(ls | grep -E ".*\.(tgz|tar.gz)$")";
do
	tar xf "$f"
done

# gotop
cp gotop ~/bin/
rm -r gotop

# polybar
sudo apt install build-essential cmake cmake-data pkg-config python3-sphinx python3-packaging libuv1-dev libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev \ # hard dependencies 
libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev # optional dependencies

# compiling
cd polybar
mkdir build && cd build
cmake . .
make -j$(nproc)
sudo make install


# Configuration 
echo "Copying Configurations..."

if [ -d $HOME/dotfiles ]; then
  mkdir $HOME/dotfiles && cd $HOME/dotfiles # TODO: ignore install & bin

for d in */ ;
do
  stow $d
done

# TODO: add .Xresources
# TODO: add .mozilla css

# font
echo "Installing Fonts..."
cd ~/Downloads
git clone https://github.com/ryanoasis/nerd-fonts.git
cd nerd-fonts
./install.sh Fira Code

# wallpaper
echo "Adding wallpaper..."
# TODO: add .fehbg
cd ~/dotfiles
cp wallpaper.jpg ~/Pictures/wallpaper.jpg

# bspc wm -r
