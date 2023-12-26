local lspconfig_util = require("lspconfig/util")

return {
	filetypes = { "haskell", "lhaskell" },
	cmd = { "haskell-language-server-wrapper", "--lsp" },
	root_dir = lspconfig_util.root_pattern("stack.yaml", "package.yaml", "hie.yaml", "cabal.project", "*.cabal"),
	settings = {
		haskell = {
			cabalFormattingProvider = "cabalfmt",
			formattingProvider = "ormolu",
			plugin = {
				hlint = {
					globalOn = true,
				},
				rename = {
					globalOn = true,
				},
			},
		},
	},
	single_file_support = true,
}
