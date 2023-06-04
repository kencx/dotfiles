local ok, null_ls = pcall(require, "null-ls")
if not ok then
	return
end

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
	formatters.black,
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
	on_attach = function(client, bufnr)
		-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
		if client.supports_method("textDocument/formatting") then
			local augroup = vim.api.nvim_create_augroup("NullLSFormatting", {})

			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
