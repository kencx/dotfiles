# dotfiles

Theme: Gruvbox Dark
Font: Fira Code Nerd Font

## Applications
- bspwm, sxhkd
- zsh, ohmyzsh with starship
- [st](#st)
- nvim with tmux
- picom, polybar, dunst
- rofi, fzf
- zathura
- custom browser [startpage](https://github.com/kennethcheo/startpage)
- repository of custom scripts

## Install
- Xubuntu 21.04

Ensure all required packages are installed.

Dotfiles are managed by [stow](https://www.gnu.org/software/stow/). Refer to
[this](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html) guide for how it works.

To symlink all dotfiles
```
$ make dev-test     # dry-run, does not perform changes
$ make dev
```

To manually select a dir,
```
$ cd dots
$ stow [dir] --target="$HOME"
```

## st
[Luke's](https://github.com/LukeSmithxyz/st) fork of st for an easy experience. Uses colors from `.Xresources` in `others/.Xresources`.

[Fork](https://github.com/kencx/st) and edit `config.h`. Compile and build with `sudo make install`.


