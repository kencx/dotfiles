local M = {}

local function attach_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local function keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

	-- keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	-- keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	-- keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	-- keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

	keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	-- keymap("n", "<space>q", "<cmd>lua vim.diagnostic.set_loclist()<CR>", opts)
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

local function lspDiagnosticsPopupHandler()
	local current_cursor = vim.api.nvim_win_get_cursor(0)
	local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or { nil, nil }

	-- show floating diagnostics only once for each cursor location
	-- unless moved later
	if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
		vim.w.lsp_diagnostics_last_cursor = current_cursor
		vim.diagnostic.open_float(0, { scope = "cursor" })
	end
end

M.on_attach = function(client, bufnr)
	attach_keymaps(bufnr)
	function_signature(bufnr)

	-- TODO
	-- telescope code action picker with diff preview

	-- autoformat
	require("lsp.format").format_on_save(client, bufnr)

	vim.o.updatetime = 250
	vim.api.nvim_create_autocmd("CursorHold", {
		pattern = "*",
		callback = function()
			lspDiagnosticsPopupHandler()
		end,
	})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_lsp_loaded, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_lsp_loaded then
	M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

return M
