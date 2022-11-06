# neovim

### Core Plugins
- [packer.nvim](https://github.com/wbthomason/packer.nvim) plugin manager
- [impatient.nvim](https://github.com/lewis6991/impatient.nvim) speed up startup time
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for treesitter
  highlighting
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) completion engine
- [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim) for formatters,
  linters
- [vim-vsnip](https://github.com/hrsh7th/vim-vsnip) snippets engine
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) fuzzy finder
- [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim)
  extension for telescope.nvim
- [barbar.nvim](https://github.com/romgrk/barbar.nvim) tabline
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) statusline
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) for git integration
- [diffview.nvim](https://github.com/sindrets/diffview.nvim) git diff manager
- [Comment.nvim](https://github.com/numToStr/Comment.nvim) comment engine
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) for
  indentation guides
- [which-key.nvim](https://github.com/folke/which-key.nvim) keybindings helper
- [auto-pairs](https://github.com/jiangmiao/auto-pairs) pairs helper
- [vim-sandwich](https://github.com/machakann/vim-sandwich) sandwich operator engine
- [mini.map](https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-map.md)
  scrollbar
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) navigation
  between tmux panes and vim splits
- [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) markdown
  previewer
- [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) colorscheme
- [nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua) color highlighter
- [document-color.nvim](https://github.com/mrshmllow/document-color.nvim) colorizer for
  tailwindcss

### Dependencies
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
- [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
- [cmp-path](https://github.com/hrsh7th/cmp-path)
- [lspcontainers.nvim](https://github.com/lspcontainers/lspcontainers.nvim)
- [telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)
- ripgrep
- fzf

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

Run `:PackerSync` & `:PackerCompile` to install all plugins.

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

Run `:checkhealth` to ensure everything is good.
