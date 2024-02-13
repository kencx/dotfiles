local defaults = {
	on_attach = require("lsp.handlers").on_attach,
	capabilities = require("lsp.handlers").capabilities,
}

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup(vim.tbl_deep_extend("force", require("lsp.settings.lua_ls"), defaults))
lspconfig.gopls.setup(vim.tbl_deep_extend("force", require("lsp.settings.gopls"), defaults))
lspconfig.bashls.setup(vim.tbl_deep_extend("force", require("lsp.settings.bashls"), defaults))
lspconfig.dockerls.setup(vim.tbl_deep_extend("force", require("lsp.settings.dockerls"), defaults))
lspconfig.pylsp.setup(vim.tbl_deep_extend("force", require("lsp.settings.pythonls"), defaults))
lspconfig.terraformls.setup(vim.tbl_deep_extend("force", require("lsp.settings.terraformls"), defaults))
lspconfig.yamlls.setup(vim.tbl_deep_extend("force", require("lsp.settings.yamlls"), defaults))
lspconfig.solargraph.setup(vim.tbl_deep_extend("force", require("lsp.settings.solargraph"), defaults))
lspconfig.svelte.setup(vim.tbl_deep_extend("force", require("lsp.settings.svelte"), defaults))
lspconfig.templ.setup(vim.tbl_deep_extend("force", require("lsp.settings.templ"), defaults))
lspconfig.tsserver.setup(vim.tbl_deep_extend("force", require("lsp.settings.tsserver"), defaults))
lspconfig.hls.setup(vim.tbl_deep_extend("force", require("lsp.settings.hls"), defaults))
