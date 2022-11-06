# nvim

## Plugins
- Native lsp
- null-ls for formatting, linting
- nvim-cmp for completion
- vsnip for snippets
- telescope.nvim
- telescope-file-browser.nvim
- barbar-nvim
- lualine
- gitsigns
- Comment.nvim
- indent-blankline.nvim
- which-key.nvim
- auto-pairs
- vim-sandwich
- mini.map
- markdown-preview.nvim
- kanagawa.nvim

## Install
- Ensure neovim is installed
```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/bin/nvim
```
- Clone this repo
```
git clone https://github.com/kennethcheo/dotfiles && cd dotfiles
stow nvim
```
Plugins are managed by [packer.nvim](https://github.com/wbthomason/packer.nvim).
- Install packer.nvim
```
git clone https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

Run :PackerSync & :PackerCompile to install all plugins.

### Snapshotting

Run `:PackerSnapshot [name]` to make a snapshot. By default, it will be saved to
`$HOME/.cache/nvim/packer.nvim`

To rollback to the snapshot, run `:PackerRollback [name]`.

## Treesitter
By default, this config installs 20+/70+ of the support languages. Run
:TSPInstallInfo to see the full list. Run the following to install a supported
language

```
:TSInstall <language>
```

## LSP
Installation of specific LSP servers depends on the language server. Refer to
the nvim-lspconfig guide for more details on each server.

### Python
This
[config](https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#jedi_language_server)
uses [jedi-language-server](https://github.com/pappasam/jedi-language-server)
```
pipx install jedi-language-server
```

### lspcontainers
Runs heavyweight LSPs (`npm`) through docker containers. Dynamically attached when
required.
- bashls
- dockerls
- terraformls
- sumneko_lua
- tailwindcss
- tsserver
- svelte

### Formatters and Linters
Null-ls uses a headless instance of neovim to inject lsp capabilities, allowing
for use with general purpose lsps
- ansiblels
- shellcheck
- stylua
- yamllint
- luacheck

## impatient.nvim
impatient.nvim is used to cache `packer_compiled.lua` for faster startup times.

Run :checkhealth to ensure everything is good.
