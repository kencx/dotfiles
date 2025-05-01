local ok, null_ls = pcall(require, "null-ls")
if not ok then
	return
end

local util = require("lsp/util")
local custom_util = require("../util")

-- toggle black
custom_util.map("n", "<Leader>b", function()
	null_ls.toggle({ name == "black" })
end)

local formatters = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local hover = null_ls.builtins.hover
local code_actions = null_ls.builtins.code_actions

local sources = {
	-- lua
	formatters.stylua,
	diagnostics.selene,

	-- go
	formatters.gofmt,
	formatters.goimports,

	-- bash
	require("none-ls-shellcheck.diagnostics").with({
		extra_args = { "-o", "check-extra-masked-returns" },
	}),
	formatters.shfmt.with({
		extra_args = { "-i", "4" },
	}),

	-- python
	-- diagnostics.ruff.with({
	-- 	prefer_local = util.get_python_relative_bin(require("null-ls.utils").get_root()),
	-- }),
	formatters.black.with({
		prefer_local = util.get_python_relative_bin(require("null-ls.utils").get_root()),
	}),
	formatters.isort.with({
		prefer_local = util.get_python_relative_bin(require("null-ls.utils").get_root()),
		extra_args = { "--profile", "black" },
	}),

	-- hcl
	diagnostics.terraform_validate.with({
		filetypes = { "hcl" },
	}),
	formatters.packer,
	formatters.terraform_fmt.with({
		filetypes = { "hcl" },
	}),

	diagnostics.yamllint.with({
		extra_args = { "-d", "{extends: default, rules: {document-start: disable}}" },
	}),
	-- diagnostics.ansiblelint,
	-- diagnostics.actionlint,
	-- diagnostics.hadolint,

	-- ruby
	diagnostics.rubocop,

	formatters.codespell.with({
		filetypes = { "markdown" },
	}),
	diagnostics.codespell.with({
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
