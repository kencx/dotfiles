local ok, configs = pcall(require, "conform")
if not ok then
	return
end

configs.setup({
	formatters_by_ft = {
		bash = { "shfmt" },
		go = { "gofmt", "goimports" },
		lua = { "stylua" },
		python = { "isort", "black" },
		hcl = { "packer_fmt", "terraform_fmt" },
		markdown = { "codespell" },
	},
	formatters = {
		isort = {
			args = { "--profile", "black" },
		},
	},
	format_on_save = {
		lsp_format = "fallback",
		async = false,
		timeout_ms = 500,
	},
})
