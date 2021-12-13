vim.api.nvim_command([[autocmd BufWritePost plugins.lua PackerCompile]])

vim.cmd([[
    augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=700}
    augroup END
]])

-- remove trailing whitespace on save
vim.cmd([[
    augroup remove_whitespace
    autocmd!
    autocmd BufWrite * mark ' | silent! %s/\s\+$// | norm ''
    augroup END
]])

vim.cmd([[augroup vimrc]])
vim.cmd([[autocmd!]])
vim.cmd([[autocmd FileType help wincmd L]])
vim.cmd([[augroup END]])

-- local options
vim.cmd([[augroup vimrc]])
vim.cmd([[autocmd!]])
vim.cmd([[autocmd FileType text,markdown,tex setlocal textwidth=80]])
vim.cmd([[autocmd TermOpen * setlocal nonumber norelativenumber]])
vim.cmd([[augroup END]])

