local ok, null_ls = pcall(require, "null-ls")
if not ok then
	return
end

local util = require("lsp/util")

local formatters = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local hover = null_ls.builtins.hover
local code_actions = null_ls.builtins.code_actions

local sources = {
	-- lua
	formatters.stylua,
	diagnostics.luacheck.with({
		extra_args = { "-g" },
	}),

	-- go
	formatters.gofmt,
	formatters.goimports,

	-- bash
	diagnostics.shellcheck,
	formatters.shfmt.with({
		extra_args = { "-i", "4" },
	}),

	-- python
	formatters.black.with({
		prefer_local = util.get_python_relative_bin(require("null-ls.utils").get_root()),
	}),
	-- formatting.isort,

	-- hcl
	diagnostics.terraform_validate.with({
		filetypes = { "hcl" },
	}),
	formatters.packer,
	formatters.terraform_fmt.with({
		filetypes = { "hcl" },
	}),

	diagnostics.yamllint,
	-- diagnostics.ansiblelint,
	-- diagnostics.actionlint,
	-- diagnostics.hadolint,

	formatters.codespell.with({
		filetypes = { "markdown" },
	}),
	-- hover.dictionary,
	--[[ code_actions.gitsigns, ]]
}

null_ls.setup({
	debug = false,
	sources = sources,
	on_attach = require("lsp.format").format_on_save,
})
