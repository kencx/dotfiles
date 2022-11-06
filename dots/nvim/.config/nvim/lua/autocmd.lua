local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePost", {
	pattern = "plugins.lua",
	command = "PackerCompile",
})

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

autocmd("FileType", {
	pattern = "gitcommit",
	command = "setlocal wrap spell",
})

autocmd("FileType", {
	pattern = "help",
	command = "wincmd L",
})

autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.nomad",
	command = "set ft=hcl",
})

vim.cmd([[
    augroup remove_whitespace
    autocmd!
    autocmd BufWrite * mark ' | silent! %s/\s\+$// | norm ''
    augroup END
]])
