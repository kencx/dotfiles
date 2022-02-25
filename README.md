# dotfiles

Theme: Gruvbox Dark & [kanagawa](https://github.com/rebelot/kanagawa.nvim)

Font: Fira Code Nerd Font

<p align="center">
	<img src="./assets/ss-plain.png"/>
	<img src="./assets/ss-fetch.png"/>
	<img src="./assets/ss-nvim.png"/>
	<img src="./assets/ss-firefox.png"/>
</p>

More information:
- WM: [bspwm](https://github.com/baskerville/bspwm), [sxhkd](https://github.com/baskerville/sxhkd)
- Terminal: [st](#st)
- Shell: [zsh](https://www.zsh.org) with [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
- Prompt: [starship](https://github.com/starship/starship)
- Editor: [nvim](https://github.com/neovim/neovim/) with [tmux](https://github.com/tmux/tmux)
- Compositor: [picom](https://github.com/yshui/picom)
- Bar: [eww](https://github.com/elkowar/eww)
- Others: [rofi](https://github.com/davatorium/rofi), [dunst](https://github.com/dunst-project/dunst), [zathura](https://github.com/pwmt/zathura)
- custom scripts in `dots/bin`

Other Dependencies:
- [fzf](https://github.com/junegunn/fzf),
- [jq](https://github.com/stedolan/jq)
- [xclip](https://github.com/astrand/xclip)
- [bw](https://github.com/bitwarden/cli)
- [gocryptfs](https://github.com/rfjakob/gocryptfs)

## Install

Dotfiles are managed by [stow](https://www.gnu.org/software/stow/). Refer to
[this](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html) guide for how it works.

To symlink all dotfiles
```
$ make dev-test     # dry-run, does not perform changes
$ make dev
```

To manually stow a dir,
```
$ cd dots
$ stow [dir] --target="$HOME"
```

### st
[Luke's](https://github.com/LukeSmithxyz/st) fork of st for an easy experience. Uses colors from `.Xresources` in `etc/.Xresources`.

Make edits to `config.h`. Compile and build with `sudo make install`.

### Custom browser startpage
See [startpage](https://github.com/kennethcheo/startpage)

### Remote
Minimal .vimrc config for remote servers

Requires installation of Gruvbox:

```bash
git clone https://github.com/morhetz/gruvbox.git ~/.vim/pack/default/start/gruvbox
```
