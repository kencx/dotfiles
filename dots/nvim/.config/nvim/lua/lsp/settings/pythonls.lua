local util = require("lsp/util")
local configs = require("lspconfig/configs")

return {
	cmd = { "pylsp" },
	filetypes = { "python" },
	settings = {
		pylsp = {
			configurationSources = { "flake8" },
			plugins = {
				flake8 = {
					enabled = true,
					ignore = {
						"E501",
					},
				},
				pycodestyle = { enabled = false },
				pyflakes = { enabled = false },
				yapf = { enabled = false },
				jedi = {
					environment = util.get_python_path(configs.root_dir),
				},
			},
		},
	},
}
