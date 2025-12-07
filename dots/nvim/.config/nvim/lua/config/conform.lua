local ok, configs = pcall(require, "conform")
if not ok then
	return
end

configs.setup({
	formatters_by_ft = {
		sh = { "shfmt" },
		bash = { "shfmt" },
		go = { "gofmt", "goimports" },
		lua = { "stylua" },
		python = { "ruff_format", "ruff_organize_imports" },
		hcl = { "packer_fmt", "terraform_fmt" },
		markdown = { "codespell" },
	},
	format_on_save = {
		lsp_format = "fallback",
		async = false,
		timeout_ms = 500,
	},
})
