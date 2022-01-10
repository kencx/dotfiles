local null_ls = require("null-ls")
local lsp = require("config.lsp")

local formatters = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
-- local hover = null_ls.builtins.hover

local sources = {
	-- lua
	formatters.stylua,
	diagnostics.luacheck.with({
		extra_args = { "-g" },
	}),

	diagnostics.yamllint,
	diagnostics.ansiblelint,
	diagnostics.shellcheck,

	formatters.codespell.with({
		filetypes = { "markdown" },
	}),
	-- hover.dictionary,
}

require("lspconfig")["null-ls"].setup({ on_attach = lsp.on_attach })

null_ls.setup({
	sources = sources,
	-- debug = true,
})
