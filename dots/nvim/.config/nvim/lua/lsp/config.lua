local defaults = {
	on_attach = require("lsp.handlers").on_attach,
	capabilities = require("lsp.handlers").capabilities,
}

local lspconfig = require("lspconfig")

lspconfig.sumneko_lua.setup(vim.tbl_deep_extend("force", require("lsp.settings.lua_ls"), defaults))
lspconfig.gopls.setup(vim.tbl_deep_extend("force", require("lsp.settings.gopls"), defaults))
lspconfig.bashls.setup(vim.tbl_deep_extend("force", require("lsp.settings.bashls"), defaults))
lspconfig.dockerls.setup(vim.tbl_deep_extend("force", require("lsp.settings.dockerls"), defaults))
lspconfig.terraformls.setup(vim.tbl_deep_extend("force", require("lsp.settings.terraformls"), defaults))
lspconfig.yamlls.setup(vim.tbl_deep_extend("force", require("lsp.settings.yamlls"), defaults))
lspconfig.svelte.setup(vim.tbl_deep_extend("force", require("lsp.settings.svelte"), defaults))
lspconfig.tsserver.setup(vim.tbl_deep_extend("force", require("lsp.settings.tsserver"), defaults))
-- lspconfig.tailwindcss.setup(vim.tbl_deep_extend("force", require("lsp.settings.tailwindcss"), defaults))
