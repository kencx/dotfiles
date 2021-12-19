autocmd FileType markdown setlocal textwidth=80 spell
autocmd FileType markdown setlocal wrap

" visual mode map to insert markdown links
:vnoremap ,wl c[<C-r>"]()<Esc>
