#! /bin/bash

# configs
echo "Copying Configurations..."

if [ -d $HOME/dotfiles ]; then
  mkdir $HOME/dotfiles && cd $HOME/dotfiles

for d in */ ;
do
  stow $d
done

# font
echo "Installing Fonts..."
cd ~/Downloads
git clone https://github.com/ryanoasis/nerd-fonts.git
./install.sh Fira Code

echo "Adding wallpaper..."
# set up feh?
cd ~/dotfiles
cp wallpaper.jpg ~/Pictures/wallpaper.jpg

bspc wm -r
