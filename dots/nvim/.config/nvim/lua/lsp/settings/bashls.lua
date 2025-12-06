local lspconfig_util = require("lspconfig/util")

return {
	cmd = { "bash-language-server", "start" },
	root_markers = { ".git" },
	filetypes = { "sh", "bash" },
	single_file_support = true,
	settings = {
		bashIde = {
			shellcheckArguments = "-o check-extra-masked-returns",
		},
	},
}
