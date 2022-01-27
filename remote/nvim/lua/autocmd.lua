vim.cmd([[

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

	augroup _terminal
	autocmd!
	autocmd TermOpen * setlocal nonumber norelativenumber
	augroup END
]])
