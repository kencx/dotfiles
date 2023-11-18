local set = vim.opt

vim.cmd("set nocompatible") -- turn off vi compatability
set.backspace = "indent,eol,start" -- enable backspace in insert mode
set.mouse = "a" -- enable mouse support
vim.cmd("set clipboard^=unnamed,unnamedplus")

vim.cmd([[filetype plugin indent on]])
set.syntax = "on"
set.hidden = true

set.modelines = 0 -- turn off modelines
set.history = 1000
set.undolevels = 1000

set.showcmd = true -- show command
set.showmode = false -- show mode
set.showmatch = true -- show matching bracket

set.visualbell = true -- turn off sound
set.errorbells = false

set.wrap = true -- enable line wrapping
set.linebreak = true
set.textwidth = 88

set.list = true
set.listchars = {
	trail = ".",
	leadmultispace = "⦙ ",
	tab = "⦙ ",
}

set.foldmethod = "indent"
vim.cmd("set nofoldenable")
set.foldlevel = 99

set.ttyfast = true
set.lazyredraw = true
set.swapfile = false
set.backup = false
set.writebackup = false

set.laststatus = 3 -- global statusline
set.splitbelow = true
set.splitright = true

-- search
set.hlsearch = true -- enable search highlighting
set.incsearch = true
set.smartcase = true -- switch to case-sensitive when typing uppercase letter
set.ignorecase = true -- ignore case on search
set.wrapscan = true -- wrap searches around end-of-file

set.inccommand = "split"

-- indentation
set.expandtab = true
set.tabstop = 4 -- print tabs as 4 space
set.softtabstop = 4
set.shiftwidth = 4
set.autoindent = true
set.smartindent = false
set.shiftround = true -- use shiftwidth when using >, <
set.smarttab = true -- insert tabs based on shiftwidth

-- cursor
set.ruler = true -- show cursor position
set.cursorline = true -- set cursorline
set.number = true -- show line numbers
set.relativenumber = true
set.scrolloff = 4 -- number of lines above and below cursor when scrolling

set.wildignore:append("**/.git/*")
set.wildignore:append("**/node_modules/*")

vim.wo.colorcolumn = "99999" -- fixes highlighting bug with indent_blankline

-- vim-tmux-navigator
vim.g.tmux_navigator_disable_when_zoomed = 1
