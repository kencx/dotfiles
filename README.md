# dotfiles

See [screenshots](#screenshots).

- Theme: Gruvbox Dark & [kanagawa](https://github.com/rebelot/kanagawa.nvim)
- Font: Fira Code Nerd Font
- WM: [bspwm](https://github.com/baskerville/bspwm)
- Terminal: [st](#st) fork
- Shell: [zsh](https://www.zsh.org)
- Prompt: [pure](https://github.com/sindresorhus/pure)
- Editor: [nvim](https://github.com/neovim/neovim/) with [tmux](https://github.com/tmux/tmux)
- Compositor: [picom](https://github.com/yshui/picom) fork
- Bar: [eww](https://github.com/elkowar/eww)
- Firefox Theme: [SimpleFox](https://github.com/migueravila/SimpleFox)
- Custom browser [startpage](https://github.com/kennethcheo/startpage)
- Lock: [slock](https://github.com/khuedoan/slock)
- Others: [rofi](https://github.com/davatorium/rofi), [dunst](https://github.com/dunst-project/dunst), [zathura](https://github.com/pwmt/zathura), feh, nsxiv, redshift

## Install

The `setup` script requires [stow](https://www.gnu.org/software/stow/).

```bash
# dry-run
$ ./setup install --simulate

$ ./setup install
```

The script will:

- Stow all dotfiles
- Copy `.Xresources` in `./etc/.Xresources`
- Apply Firefox customizations in `./etc/firefox`
- Copy all `.desktop` files in `./etc/desktop` to `~/.local/share/applications`
- Install all neovim plugins

>TODO: Install [custom st fork](#st).

To run separate stow and unstows:

```bash
# dry-run: stow only bspwm
$ ./setup stow --simulate bspwm

# unstow only bspwm
$ ./setup unstow bspwm
```

All dotfiles must be placed in `./dots/` directory or specify custom directory
with `--dots` flag:

```bash
$ ./setup stow --dots ./foo bspwm
```

## Uninstall

Uninstall will:

- Unstow all dotfiles
- Delete any existing `.Xresources`, Firefox customizations and `.desktop` files
- Uninstall all neovim plugins

```bash
# dry-run
$ ./setup uninstall --simulate

# uninstall all
$ ./setup uninstall
```


## Applications

### st
[Luke's](https://github.com/LukeSmithxyz/st) fork of st for an easy experience. Uses colors from `.Xresources` in `etc/.Xresources`.

Make edits to `config.h`. Compile and build with `sudo make install`.

### Remote
Minimal .vimrc config for remote servers

Requires installation of Gruvbox:

```bash
git clone https://github.com/morhetz/gruvbox.git ~/.vim/pack/default/start/gruvbox
```

### Colorscheme
Two colorschemes are available in the form of `.Xresources` files.

To use, copy the `.Xresources` file to `~/.Xresources` and replace the
defined path within it. Take care of the username.

### desktop
Desktop files for rofi access are found in `etc/desktop`. Place them at `~/.local/share/applications/`

## Screenshots

<p align="center">
	<img src="./assets/ss-plain.png"/>
</p>
