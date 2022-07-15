local nvim_lsp = require("lspconfig")
local M = {}

local mappings = function(bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	-- buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	-- buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	-- buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	-- buf_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.set_loclist()<CR>", opts)
end

-- disable inline diagnostics
local function configure_diagnostics()
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		signs = true,
		underline = true,
	})
end

local on_attach = function(client, bufnr)
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- key mappings
	mappings(bufnr)

	-- float diagnostics
	configure_diagnostics()

	-- signatures
	-- require("lsp_signature").on_attach({
	-- 	bind = true,
	-- 	handler_opts = {
	-- 		border = "rounded",
	-- 	},
	-- }, bufnr)

	vim.o.updatetime = 250
	vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

	-- format on save
	if client.resolved_capabilities.document_formatting then
		vim.cmd([[ autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync() ]])
	end
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- setup jedi language
nvim_lsp.jedi_language_server.setup({
	cmd = { "jedi-language-server" },
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "python" },
	settings = {
		jedi = {
			enable = true,
			startupMessage = true,
			markupKindPreferred = "markdown",
			jediSettings = {
				autoImportModules = {},
				diagnostics = { enable = true, didSave = true, didChange = true, didOpen = true },
			},
			workspace = { extraPaths = {} },
		},
	},
})

-- setup gopls
nvim_lsp.gopls.setup({
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
		},
	},
})

-- sort imports on save
function goimports(timeout_ms)
	local context = { only = { "source.organizeImports" } }
	vim.validate({ context = { context, "t", true } })

	local params = vim.lsp.util.make_range_params()
	params.context = context

	-- See the implementation of the textDocument/codeAction callback
	-- (lua/vim/lsp/handler.lua) for how to do this properly.
	local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
	if not result or next(result) == nil then
		return
	end
	local actions = result[1].result
	if not actions then
		return
	end
	local action = actions[1]

	-- textDocument/codeAction can return either Command[] or CodeAction[]. If it
	-- is a CodeAction, it can have either an edit, a command or both. Edits
	-- should be executed first.
	if action.edit then
		vim.lsp.util.apply_workspace_edit(action.edit)
	end
	if type(action.command) == "table" then
		vim.lsp.buf.execute_command(action.command)
	end
end

vim.cmd([[ autocmd BufWritePre *.go :silent! lua goimports(1000) ]])

-- lspcontainers
local lspcontainers = require("lspcontainers")

-- bash
nvim_lsp.bashls.setup({
	before_init = function(params)
		params.processId = vim.NIL
	end,
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = lspcontainers.command("bashls"),
	root_dir = nvim_lsp.util.root_pattern(".git", vim.fn.getcwd()),
})

-- lua
nvim_lsp.sumneko_lua.setup({
	cmd = lspcontainers.command("sumneko_lua"),
	on_attach = on_attach,
	capabilities = capabilities,
})

-- docker
nvim_lsp.dockerls.setup({
	before_init = function(params)
		params.processId = vim.NIL
	end,
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = lspcontainers.command("dockerls"),
	root_dir = nvim_lsp.util.root_pattern(".git", vim.fn.getcwd()),
})

-- terraform
nvim_lsp.terraformls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = lspcontainers.command("terraformls"),
	filetypes = { "hcl", "tf", "terraform", "tfvars" },
})

-- typescript
nvim_lsp.tsserver.setup({
	before_init = function(params)
		params.processId = vim.NIL
	end,
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = lspcontainers.command("tsserver"),
	root_dir = nvim_lsp.util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git", vim.fn.getcwd()),
})

nvim_lsp.tailwindcss.setup({
	before_init = function(params)
		params.processId = vim.NIL
	end,
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = lspcontainers.command("tailwindcss"),
	filetypes = { "html", "css", "scss", "sass", "postcss", "javascript", "typescript" },
	root_dir = nvim_lsp.util.root_pattern(
		"tailwind.config.js",
		"tailwind.config.ts",
		"package.json",
		".git",
		vim.fn.getcwd()
	),
})

M.mappings = mappings
M.on_attach = on_attach
return M
