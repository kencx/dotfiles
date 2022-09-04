set nocompatible
set backspace=indent,eol,start
set mouse=a
set clipboard=unnamed,unnamedplus

syntax on
set hidden

set noml
set history=1000
set undolevels=1000

set showcmd
set showmode
set showmatch

set visualbell
set noeb

set wrap
set linebreak
set textwidth=88

set listchars=trail:.

set lazyredraw
set noswapfile
set nobackup
set nowb

set laststatus=2
set sb
set spr

set hlsearch
set incsearch
set smartcase
set ignorecase
set wrapscan

" indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set shiftround
set smarttab

" cursor
set ruler
set cursorline
set number
set relativenumber
set so=4              " scrolloff

set bg=dark
" install gruvbox - git clone https://github.com/morhetz/gruvbox.git ~/.vim/pack/default/start/gruvbox
autocmd vimenter * ++nested colorscheme gruvbox

" mappings
let mapleader=" "

" unmap arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

vnoremap < <gv
vnoremap > >gv

nnoremap <a-j> :m .+1<CR>==
nnoremap <a-k> :m .-2<CR>==
vnoremap <a-j> :m >+1<CR>gv=gv
vnoremap <a-k> :m <-2<CR>gv=gv

nnoremap <Leader>h :sethlsearch!<CR>
nnoremap <Leader>n :tabnew<CR>
nnoremap <Leader>cd :cd %:p:h<CR>

" autocmd
augroup highlight_yank
	autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=700}
augroup END

augroup remove_whitespace
    autocmd!
    autocmd BufWrite * mark ' | silent! %s/\s\+$// | norm ''
augroup END

augroup _help
	autocmd!
	autocmd FileType help wincmd L
augroup END

augroup _markdown
	autocmd!
	autocmd FileType text,markdown,tex setlocal textwidth=80
	autocmd FileType markdown setlocal wrap
augroup END

augroup _git
	autocmd!
	autocmd FileType gitcommit setlocal wrap
	autocmd FileType gitcommit setlocal spell
augroup END
