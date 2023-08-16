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
