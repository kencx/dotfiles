# dotfiles

## Install
For a minimal installation, run `install-min.sh`

For a full workplace installation, run `install.sh`

Add debian packages to `apps.list` for installation.

## Folder Structure
The folder structure is set up for [stow](https://www.gnu.org/software/stow/) as the dotfiles manager. Refer to
[this](https://www.gnu.org/software/stow/) guide for how it works.

Config file structure in `/home/username/`

```
~
|-- .zshenv
|-- .Xresources
|-- bin
|-- .mozilla
|-- .config
     |-- zsh
     |-- bspwm
     |-- sxhkd
     |-- picom
     |-- nvim
     |-- kitty
     |-- rofi
     |-- polybar
```


## TODO
- Lock screen
- nvim config
- Firefox CSS
