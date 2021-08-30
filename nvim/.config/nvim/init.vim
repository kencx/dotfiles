syntax on 
set number 	" show line numbers
set linebreak 
set textwidth=100
set wrap 	" enable line wrapping
set showmatch
set spell
set noswapfile

set hlsearch
set smartcase
set ignorecase
set incsearch

set autoindent
set shiftwidth=2
set smartindent
set smarttab
set softtabstop=2

set relativenumber
set ruler	" show cursor position
set undolevels=1000
set backspace=indent,eol,start  " make backspace behave normally

set cursorline	" set cursorline

" theme
set background=dark
colorscheme gruvbox8
let g:gruvbox_italics = 0
let g:gruvbox_italicize_strings = 0

" keybindings
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <jk> <ESC>

" plugins
":lua require('plugins')

