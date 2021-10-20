# dotfiles

- Terminal: kitty
- Editor: neovim
- WM: bspwm
- bar: polybar
- browser: firefox
- launcher: rofi
- file manager: ranger

## Install

Configured and tested on Xubuntu 20.04.
- Font: Fira Code
- Theme: gruvbox dark


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
     |-- ranger
```

## neovim
Refer to nvim README.md for more details

## TODO
- Lock screen
- Clean `.Xresources`
- Add bspwm, sxhkd to autostart
