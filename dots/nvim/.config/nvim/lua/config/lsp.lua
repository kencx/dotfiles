local lspconfig = require("lspconfig")
local M = {}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- disable virtual_text (inline) diagnostics and use floating window
-- formatted message shows source, message and error code
vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	float = {
		border = "single",
		format = function(diagnostic)
			return string.format("%s (%s)", diagnostic.message, diagnostic.source)
		end,
	},
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local on_attach = function(client, bufnr)
	-- format on save
	-- if client.server_capabilities.documentFormattingProvider then
	-- 	vim.cmd([[ autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync() ]])
	-- end
	-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end

	-- set by default >=v0.8.1
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- mappings
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local opts = { noremap = true, silent = true }

	-- buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	-- buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	-- buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	-- buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	-- buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.set_loclist()<CR>", opts)

	-- show line diagnostics in hover window
	vim.o.updatetime = 250
	vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

	-- signatures
	-- require("lsp_signature").on_attach({
	-- 	bind = true,
	-- 	handler_opts = {
	-- 		border = "rounded",
	-- 	},
	-- }, bufnr)

	-- document-color.nvim
	-- if client.server_capabilities.colorProvider then
	-- 	require("document-color").buf_attach(bufnr, { mode = "background" })
	-- end
end

-- setup jedi language
--lspconfig.jedi_language_server.setup({
--	cmd = { "jedi-language-server" },
--	on_attach = on_attach,
--	capabilities = capabilities,
--	filetypes = { "python" },
--	settings = {
--		jedi = {
--			enable = true,
--			startupMessage = true,
--			markupKindPreferred = "markdown",
--			jediSettings = {
--				autoImportModules = {},
--				diagnostics = { enable = true, didSave = true, didChange = true, didOpen = true },
--			},
--			workspace = { extraPaths = {} },
--		},
--	},
--})

lspconfig.gopls.setup({
	cmd = { "gopls", "--remote=auto" },
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "go", "gomod" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
			buildFlags = { "-tags=integration" },
		},
	},
})

-- sort imports on save
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
	end,
})

-- lspcontainers
local lspcontainers = require("lspcontainers")
local lspconfig_util = require("lspconfig/util")

-- bash
lspconfig.bashls.setup({
	before_init = function(params)
		params.processId = vim.NIL
	end,
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = lspcontainers.command("bashls"),
	filetypes = { "sh" },
	single_file_support = true,
	root_dir = lspconfig_util.root_pattern(".git", vim.fn.getcwd()),
})

---- lua
----lspconfig.sumneko_lua.setup({
----	cmd = lspcontainers.command("sumneko_lua"),
----	on_attach = on_attach,
----	capabilities = capabilities,
----})

-- docker
lspconfig.dockerls.setup({
	before_init = function(params)
		params.processId = vim.NIL
	end,
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = lspcontainers.command("dockerls"),
	root_dir = lspconfig_util.root_pattern(".git", vim.fn.getcwd()),
})

-- terraform
lspconfig.terraformls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = lspcontainers.command("terraformls"),
	filetypes = { "hcl", "tf", "terraform", "tfvars" },
})

---- typescript
--lspconfig.tsserver.setup({
--	before_init = function(params)
--		params.processId = vim.NIL
--	end,
--	on_attach = on_attach,
--	capabilities = capabilities,
--	cmd = lspcontainers.command("tsserver"),
--	root_dir = lspconfig_util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git", vim.fn.getcwd()),
--})
--
--lspconfig.svelte.setup({
--	before_init = function(params)
--		params.processId = vim.NIL
--	end,
--	cmd = lspcontainers.command("svelte"),
--	root_dir = lspconfig_util.root_pattern("svelte.config.js", ".git", vim.fn.getcwd()),
--})
--
---- yamlls
--lspconfig.yamlls.setup({
--	before_init = function(params)
--		params.processId = vim.NIL
--	end,
--	capabilities = capabilities,
--	cmd = lspcontainers.command("yamlls", {
--		-- requires network access to access yaml schemas
--		network = "bridge",
--	}),
--	root_dir = lspconfig_util.root_pattern(".git", vim.fn.getcwd()),
--	settings = {
--		yaml = {
--			schemas = {
--				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
--				["https://raw.githubusercontent.com/canonical/cloud-init/main/cloudinit/config/schemas/versions.schema.cloud-config.json"] = {
--					"user-data.yml",
--					"user-data.yaml",
--					"cloud.cfg",
--				},
--			},
--		},
--	},
--})

-- lspconfig.tailwindcss.setup({
-- 	before_init = function(params)
-- 		params.processId = vim.NIL
-- 	end,
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	cmd = lspcontainers.command("tailwindcss"),
-- 	filetypes = { "html", "css", "scss", "sass", "postcss", "javascript", "typescript", "svelte" },
-- 	root_dir = lspconfig_util.root_pattern(
-- 		"tailwind.config.cjs",
-- 		"tailwind.config.js",
-- 		"tailwind.config.ts",
-- 		"package.json",
-- 		".git",
-- 		vim.fn.getcwd()
-- 	),
-- })

-- null-ls
local null_ls = require("null-ls")
local formatters = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
-- local hover = null_ls.builtins.hover

local sources = {
	formatters.stylua,
	diagnostics.luacheck.with({
		extra_args = { "-g" },
	}),

	diagnostics.yamllint,
	diagnostics.shellcheck,
	-- diagnostics.ansiblelint,

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

-- M.mappings = mappings
-- M.on_attach = on_attach
return M
