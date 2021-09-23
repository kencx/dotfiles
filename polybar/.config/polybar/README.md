# Fonts

1. Download appropriate [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) from release archives
2. Unzip and move fonts to `~/.local/share/fonts`

    Note: Follow this [guide](https://medium.com/source-words/how-to-manually-install-update-and-uninstall-fonts-on-linux-a8d09a3853b0) for more details

3. Check that fonts are properly installed with `fc-list | grep -i "font-name"`
4. Add full font names into polybar `config` with correct format

    eg. `font-0 = FiraCode Nerd Font:size=10;1`

5. Use [cheatsheet](https://www.nerdfonts.com/cheat-sheet) to search for icons 

    Note: Use `gucharmap` if necessary
