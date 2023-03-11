local ok, _ = pcall(require, "lspconfig")
if not ok then
	return
end

require("lsp.config")
require("lsp.handlers").setup()
require("lsp.null-ls")
