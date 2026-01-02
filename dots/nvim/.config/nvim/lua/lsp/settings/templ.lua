local lspconfig_util = require("lspconfig/util")

return {
	cmd = { "templ", "lsp" },
	filetypes = { "templ" },
	root_dir = lspconfig_util.root_pattern("go.mod", ".git"),
	settings = {},
}
