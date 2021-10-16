" >> Vim settings

set nocompatible		            " turn off vi compatability
set backspace=indent,eol,start      " enable backspace in insert mode
set mouse=a			                " enable mouse support

syntax on			                " syntax highlighting
filetype on			                " enable filetype detection

set modelines=0			            " turn off modelines
set history=1000
set undolevels=1000

set showcmd			                " show command
set showmode			            " show mode
set showmatch			            " show matching bracket

set visualbell			            " turn off sound
set noerrorbells

set wrap		                  	" enable line wrapping
set linebreak
set textwidth=88

set listchars=trail:.               " show trailing whitespace chars

set lazyredraw
set noswapfile
set laststatus=2                    " always show statusline

" search
set hlsearch			            " enable search highlighting
set incsearch
set smartcase			            " switch to case-sensitive when typing uppercase letter
set ignorecase			            " ignore case on search
set wrapscan			            " wrap searches around end-of-file

" indentation
set autoindent
set smartindent
set expandtab			            " tabs -> spaces
set tabstop=4			            " print tabs as 2 space
set softtabstop=4
set shiftwidth=4
set shiftround			            " use shiftwidth when using >, <
set smarttab			            " insert tabs based on shiftwidth

" cursor
set ruler			                " show cursor position
set cursorline			            " set cursorline
set number			                " show line numbers
set relativenumber
set scrolloff=4			            " number of lines above and below cursor when scrolling

" >> theme
set background=dark
colorscheme gruvbox8
let g:gruvbox_italics = 0
let g:gruvbox_italicize_strings = 0

" >> keybindings
let mapleader = ","
nnoremap ; :

" unbind arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" shift lines up and down with alt-{j,k}
nnoremap <a-j> :<c-u>execute 'move +'. v:count1<cr>
nnoremap <a-k> :<c-u>execute 'move -1-'. v:count1<cr>

" >> auto commands

" remove trailing whitespace on save
autocmd! BufWrite * mark ' | silent! %s/\s\+$// | norm ''

" plugins
":lua require('plugins')

