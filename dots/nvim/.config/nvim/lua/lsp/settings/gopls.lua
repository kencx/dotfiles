return {
	cmd = { "gopls", "--remote=auto" },
	filetypes = { "go", "gomod" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			templateExtensions = { "templ", "tmpl" },
			-- buildFlags = { "-tags=integration" },
		},
	},
}
