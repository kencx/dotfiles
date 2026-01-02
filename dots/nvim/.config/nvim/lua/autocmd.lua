local util = require("util")

-- removes trailing whitespace on save
util.autocmd("clearWhitespace", "BufWrite", "*", [[mark ' | silent! %s/\s\+$// | norm '']])
util.autocmd("shTemplate", "BufNewFile", "*.sh", "0r ~/bin/templates/skeleton.sh")
util.autocmd("composeTemplate", "BufNewFile", "docker-compose.yml", "0r ~/bin/templates/compose-skeleton.yml")
util.autocmd("noNumberInTerminal", "TermOpen", "*", "setlocal nonumber norelativenumber")
util.autocmd_callback("highlightOnYank", "TextYankPost", "*", function()
	vim.highlight.on_yank({
		higroup = "IncSearch",
		timeout = 700,
	})
end)

-- Close on "q"
util.autocmd("closeOnQ", "FileType", {
	"help",
	"startuptime",
	"qf",
	"lspinfo",
	"man",
	"checkhealth",
	"lazy",
}, [[ nnoremap <buffer><silent> q :close<CR> nnoremap <buffer><silent> <ESC> :close<CR> set nobuflisted ]])

-- auto fstrings
util.autocmd_callback("python-fstring", "InsertCharPre", "*.py", function()
	if vim.v.char ~= "{" then
		return
	end

	local node = vim.treesitter.get_node()
	if not node then
		return
	end
	if node:type() ~= "string" then
		node = node:parent()
	end
	if not node or node:type() ~= "string" then
		return
	end

	local row, col, _, _ = vim.treesitter.get_node_range(node)
	local first_char = vim.api.nvim_buf_get_text(0, row, col, row, col + 1, {})[1]
	if first_char == "f" then
		return
	end

	vim.api.nvim_input("<Esc>m'" .. row + 1 .. "gg" .. col + 1 .. "|if<Esc>`'la")
end)

-- dynamic leadmultispace based on vim.bo.tabstop
local function update_lead()
	local lcs = vim.opt_local.listchars:get()
	local tab = vim.fn.str2list(lcs.tab)
	local space = vim.fn.str2list(lcs.multispace or lcs.space)
	local lead = { tab[1] }
	for i = 1, vim.bo.tabstop - 1 do
		lead[#lead + 1] = space[i % #space + 1]
	end
	vim.opt_local.listchars:append({ leadmultispace = vim.fn.list2str(lead) })
end

util.autocmd_callback("update-lead", "OptionSet", { "listchars", "tabstop", "filetype" }, update_lead)
vim.api.nvim_create_autocmd("VimEnter", { group = "update-lead", callback = update_lead, once = true })

util.autocmd_callback("format-json", "BufRead", "*.json", function()
	util.map("n", "<Leader>jq", ":%!jq<CR>", { noremap = true, silent = true })
end)

util.autocmd_callback("setLspFold", "LspAttach", "*", function(args)
	local client = vim.lsp.get_client_by_id(args.data.client_id)
	if client and client:supports_method("textDocument/foldingRange") then
		local win = vim.api.nvim_get_current_win()
		vim.wo[win][0].foldmethod = "expr"
		vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
	end
end)
