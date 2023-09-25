local util = require("util")

util.autocmd(
	"highlightOnYank",
	"TextYankPost",
	"*",
	"silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=700}"
)
util.autocmd("noNumberInTerminal", "TermOpen", "*", "setlocal nonumber norelativenumber")
util.autocmd("clearWhitespace", "BufWrite", "*", [[mark ' | silent! %s/\s\+$// | norm '']])
util.autocmd("shTemplate", "BufNewFile", "*.sh", "0r ~/bin/templates/skeleton.sh")
util.autocmd("composeTemplate", "BufNewFile", "docker-compose.yml", "0r ~/bin/templates/compose-skeleton.yml")

local setFileGroup = vim.api.nvim_create_augroup("setFileType", { clear = true })
local fileTypes = {
	hcl = {
		pattern = { "*.nomad", "*.tf", "*.tfvars" },
		command = "set ft=hcl",
	},
	gomod = {
		pattern = { "go.mod" },
		command = "set ft=gomod",
	},
	-- set ansible filetype for additional files
	ansible = {
		pattern = { "*/playbooks/*.yml", "*/playbooks/*.yaml" },
		command = "set ft=yaml.ansible",
	},
}

for _, type in pairs(fileTypes) do
	vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
		pattern = type.pattern,
		group = setFileGroup,
		command = type.command,
	})
end

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
