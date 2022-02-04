local null_ls = require("null-ls")
local on_attach = require("config.lsp").on_attach

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
	-- diagnostics.ansiblelint,
	diagnostics.shellcheck,

	formatters.codespell.with({
		filetypes = { "markdown" },
	}),
	-- hover.dictionary,
}

null_ls.setup({
	sources = sources,
	on_attach = on_attach,
	-- debug = true,
})

local h = require("null-ls.helpers")
local custom_ansible_source = {
	name = "ansiblelint",
	methods = { null_ls.methods.DIAGNOSTICS },
	filetypes = { "yaml" },
	generator = {
		command = "ansible-lint",
		to_stdin = true,
		ignore_stderr = true,
		args = { "--parseable-severity", "-q", "--nocolor", "$FILENAME" },
		format = "line",
		check_exit_code = function(code)
			return code <= 2
		end,
		on_output = h.diagnostics.from_pattern(
			[[^[^:]+:(%d+): %[[%w-]+%] %[([%w]+)%] (.*)$]],
			{ "row", "severity", "message" },
			{
				severities = {
					["VERY_HIGH"] = h.diagnostics.severities.error,
					["HIGH"] = h.diagnostics.severities.error,
					["MEDIUM"] = h.diagnostics.severities.warning,
					["LOW"] = h.diagnostics.severities.warning,
					["VERY_LOW"] = h.diagnostics.severities.information,
					["INFO"] = h.diagnostics.severities.hint,
				},
			}
		),
	},
}

-- null_ls.disable("ansiblelint")
-- null_ls.register(custom_ansible_source)
