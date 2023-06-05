local function autocmd(group_name, event, pattern, command)
	local augroup = vim.api.nvim_create_augroup(group_name, {})

	vim.api.nvim_create_autocmd(event, {
		group = augroup,
		pattern = pattern,
		command = command,
	})
end

autocmd("highlightOnYank", "TextYankPost", "*", "silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=700}")

autocmd("noNumberInTerminal", "TermOpen", "*", "setlocal nonumber norelativenumber")

autocmd("setTfFileType", { "BufNewFile", "BufRead" }, { "*.nomad", "*.tf" }, "set ft=hcl")

autocmd("clearWhitespace", "BufWrite", "*", [[mark ' | silent! %s/\s\+$// | norm '']])

autocmd("shTemplate", "BufNewFile", "*.sh", "0r ~/bin/templates/skeleton.sh")
