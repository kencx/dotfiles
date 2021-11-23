# dotfiles

## Applications
- bspwm, sxhkd - heavily opinionated hotkeys
- ohmyzsh, neovim, tmux - plugins galore
- polybar, dunst, rofi, fzf
- kitty, starship, feh, picom
- spotifyd, zathura
- custom browser [startpage](https://github.com/kennethcheo/startpage)
- repository of custom scripts
- Theme: gruvbox dark
- Font: Fira Code Nerd Font

## Install
- Xubuntu 21.04
Ensure all packages are installed.

Dotfiles are managed by [stow](https://www.gnu.org/software/stow/). Refer to
[this](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html) guide for how it works.

This symlinks all dotfiles
```
$ make dev-test     # dry-run, does not perform changes
$ make dev          #
```

Or manually,
```
$ cd dots
$ stow [dir] --target="$HOME"
```

## Future
- alacritty
