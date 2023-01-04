vim.cmd([[
    autocmd FileType markdown setlocal textwidth=80 spell
    autocmd FileType markdown setlocal wrap

    highlight htmlH1 guifg=#C34043 gui=bold
    highlight htmlH2 guifg=#DCA561 gui=bold
    highlight htmlH3 guifg=#76946A gui=bold
]])

-- markdown insert link
vim.api.nvim_set_keymap("v", "<Leader>ml", [[c[<c-r>"]()<esc>]], { noremap = true, silent = true })
