" Vim settings

syntax on			" turn on syntax highlighting
set number			" show line numbers
set backspace=indent,eol,start  " allow backspace in insert mode
set history=1000
set undolevels=1000
set mouse=a

set showcmd     " show command 
set showmode	" show mode
set showmatch	" show matching bracket 
set visualbell

set wrap	" enable line wrapping
set linebreak 
set textwidth=100

set lazyredraw
set noswapfile

" search
set hlsearch	" enable search highlighting
set incsearch
set smartcase	" switch to case-sensitive when typing uppercase letter
set ignorecase	" ignore case

" indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2

" cursor
set ruler			" show cursor position
set cursorline			" set cursorline
set relativenumber

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

