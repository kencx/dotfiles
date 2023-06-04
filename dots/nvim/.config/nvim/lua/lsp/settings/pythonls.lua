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
				black = { enabled = true },
			},
		},
	},
}
