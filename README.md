# dotfiles

Terminal: kitty
Editor: nvim
WM: bspwm
bar: polybar

## Install

Configured and tested on Xubuntu 20.04.

For a minimal installation, run `install-min.sh`

For a full customized installation, run `install.sh`

Add debian packages to `apps.list` for installation.

## Folder Structure
Dotfiles managed by [stow](https://www.gnu.org/software/stow/). Refer to
[this](https://www.gnu.org/software/stow/) guide for how it works.

Config file structure

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
- nvim config & plugins
- Clean `.Xresources`
