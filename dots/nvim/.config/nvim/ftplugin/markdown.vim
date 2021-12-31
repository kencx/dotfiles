autocmd FileType markdown setlocal textwidth=80 spell
autocmd FileType markdown setlocal wrap

" visual mode map to insert markdown links
:vnoremap ,wl c[<C-r>"]()<Esc>

highlight htmlH1 guifg=#C34043 gui=bold
highlight htmlH2 guifg=#DCA561 gui=bold
highlight htmlH3 guifg=#76946A gui=bold
