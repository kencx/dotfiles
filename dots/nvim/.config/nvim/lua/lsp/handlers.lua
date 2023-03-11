local M = {}

M.setup = function()
	-- disable virtual_text (inline) diagnostics and use floating window
	vim.diagnostic.config({
		virtual_text = false,
		signs = true,
		underline = true,
		severity_sort = true,
		float = {
			border = "single",
			format = function(diagnostic)
				return string.format("%s (%s)", diagnostic.message, diagnostic.source)
			end,
		},
	})
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local function keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

	-- keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	-- keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	-- keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	-- keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

	keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	-- keymap("n", "<space>q", "<cmd>lua vim.diagnostic.set_loclist()<CR>", opts)
end

local function format_on_save(client, bufnr)
	-- if client.server_capabilities.documentFormattingProvider then
	-- 	vim.cmd([[ autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync() ]])
	-- end

	-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
	local lsp_formatting = function(b)
		vim.lsp.buf.format({
			filter = function(c)
				return c.name == "null-ls"
			end,
			bufnr = b,
		})
	end

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
end

local function document_color(client, bufnr)
	if client.server_capabilities.colorProvider then
		local ok, color = pcall(require, "document-color")
		if not ok then
			return
		end
		color.buf_attach(bufnr, { mode = "background" })
	end
end

local function function_signature(bufnr)
	local ok, lsp_signature = pcall(require, "lsp_signature")
	if not ok then
		return
	end
	lsp_signature.on_attach({
		bind = true,
		handler_opts = {
			border = "rounded",
		},
	}, bufnr)
end

M.on_attach = function(client, bufnr)
	-- set by default >=v0.8.1
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	lsp_keymaps(bufnr)
	format_on_save(client, bufnr)
	-- document_color(client, bufnr)
	function_signature(bufnr)

	-- show line diagnostics in hover window
	vim.o.updatetime = 250
	vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_lsp_loaded, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_lsp_loaded then
	M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

return M
