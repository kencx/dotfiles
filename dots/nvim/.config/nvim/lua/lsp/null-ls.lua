local ok, null_ls = pcall(require, "null-ls")
if not ok then
	return
end

local formatters = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local hover = null_ls.builtins.hover
local code_actions = null_ls.builtins.code_actions

local sources = {
	formatters.stylua,
	diagnostics.luacheck.with({
		extra_args = { "-g" },
	}),

	diagnostics.yamllint,
	diagnostics.shellcheck,
	-- diagnostics.ansiblelint,
	-- diagnostics.actionlint,
	-- diagnostics.flake8,
	-- diagnostics.hadolint,

	-- diagnostics on save
	diagnostics.terraform_validate.with({
		filetypes = { "hcl" },
	}),

	formatters.codespell.with({
		filetypes = { "markdown" },
	}),
	--[[ formatters.black, ]]
	-- formatting.isort,
	-- hover.dictionary,
	--[[ code_actions.gitsigns, ]]
}

null_ls.setup({
	debug = false,
	sources = sources,
})
