local null_ls = require("null-ls")

local formatters = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {
	formatters.stylua,
	diagnostics.yamllint,
	diagnostics.shellcheck,
	-- formatters.gofmt,
	-- formatters.prettier.with({
	--	filetypes = { "html", "css", "scss", "json", "yaml", "markdown" },
}

null_ls.config({
	sources = sources,
})
