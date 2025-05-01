local lspcontainers_ok, lspcontainers = pcall(require, "lspcontainers")

local lspconfig_util = require("lspconfig/util")

if not lspcontainers_ok then
	return {
		filetypes = { "sh" },
		single_file_support = true,
		root_dir = lspconfig_util.root_pattern(".git", vim.fn.getcwd()),
		settings = {
			shellcheckArguments = "-o check-extra-masked-returns",
		},
	}
end

return {
	cmd = lspcontainers.command("bashls"),
	before_init = function(params)
		params.processId = vim.NIL
	end,
	filetypes = { "sh" },
	single_file_support = true,
	root_dir = lspconfig_util.root_pattern(".git", vim.fn.getcwd()),
	settings = {
		bashIde = {
			globPattern = "*@(.sh|.inc|.bash|.command)",
			shellcheckArguments = "-o check-extra-masked-returns",
		},
	},
}
