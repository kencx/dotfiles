# dotfiles

- bspwm, polybar, kitty
- neovim with LSP, completion and IDE-like features
  - Refer to nvim README.md for more info
- Font: Fira Code
- Theme: gruvbox dark

## Install
- Configured and tested on Xubuntu 20.04.
- Automated and idempotent installation with Ansible

## Folder Structure
Dotfiles managed by [stow](https://www.gnu.org/software/stow/). Refer to
[this](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html) guide for how it works.
```
$ stow $file --target="/home/$USER"
```

---
## TODO
- Lock screen
- Clean `.Xresources`
- Add bspwm, sxhkd to autostart
