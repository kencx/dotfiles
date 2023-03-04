local autocmd = vim.api.nvim_create_autocmd

-- highlight on yank
autocmd("TextYankPost", {
	command = "silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=700}",
})

-- set minimap colorscheme
autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "MiniMapNormal", { fg = "#363646", bg = "#272727" })
	end,
})

autocmd("TermOpen", {
	pattern = "*",
	command = "setlocal nonumber norelativenumber",
})

autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.nomad", "*.tf" },
	command = "set ft=hcl",
})

vim.cmd([[
    augroup remove_whitespace
    autocmd!
    autocmd BufWrite * mark ' | silent! %s/\s\+$// | norm ''
    augroup END
]])

vim.cmd([[
    augroup skeleton
    autocmd!
    autocmd BufNewFile *.sh 0r ~/bin/templates/skeleton.sh
    augroup END
]])
