local util = require("lsp/util")
local configs = require("lspconfig/configs")

-- set and print current python path
vim.api.nvim_create_user_command("PythonPath", function()
	print(M.get_python_path(configs.root_dir))
end, {})

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
				ruff = { enabled = false },
				jedi = {
					environment = util.get_python_path(configs.root_dir),
				},
			},
		},
	},
}
