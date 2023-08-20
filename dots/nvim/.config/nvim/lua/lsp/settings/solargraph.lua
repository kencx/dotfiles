local lspconfig_util = require("lspconfig/util")

return {
	cmd = { "solargraph", "stdio" },
	filetypes = { "ruby" },
	root_dir = lspconfig_util.root_pattern(".git", "Gemfile", "main.rb"),
	settings = {
		solargraph = {
			diagnostics = true,
		},
	},
}
