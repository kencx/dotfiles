return {
	cmd = { "gopls", "--remote=auto" },
	filetypes = { "go", "gomod" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			buildFlags = { "-tags=integration" },
		},
	},
}
