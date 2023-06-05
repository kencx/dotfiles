local ok, _ = pcall(require, "null-ls")
if not ok then
	return
end

local M = {}
local augroup = vim.api.nvim_create_augroup("Autoformat", {})

-- Get all LSP clients that support formatting and have not disabled formatting in
-- client config
local function supports_formatting(client)
	if
		client.config
		and client.config.capabilities
		and client.config.capabilities.documentFormattingProvider == false
	then
		return false
	end

	return client.supports_method("textDocument/formatting") or client.supports_method("textDocument/rangeFormatting")
end

local function format(buf)
	local null_ls_sources = require("null-ls.sources")
	local ft = vim.bo[buf].filetype

	local has_null_ls = #null_ls_sources.get_available(ft, "NULL_LS_FORMATTING") > 0
	vim.lsp.buf.format({
		bufnr = buf,
		filter = function(c)
			if has_null_ls then
				return c.name == "null-ls"
			else
				return true
			end
		end,
	})
end

M.format_on_save = function(client, bufnr)
	if supports_formatting(client) then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				if vim.b.format_on_write ~= false then
					format(bufnr)
				end
			end,
		})
	end
end

return M
