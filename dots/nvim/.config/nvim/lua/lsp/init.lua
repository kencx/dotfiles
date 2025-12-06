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

local defaults = {
	on_attach = require("lsp.handlers").on_attach,
	capabilities = require("lsp.handlers").capabilities,
}

local servers = {
	lua_ls = require("lsp.settings.lua_ls"),
	gopls = require("lsp.settings.gopls"),
	bashls = require("lsp.settings.bashls"),
	dockerls = require("lsp.settings.dockerls"),
	pylsp = require("lsp.settings.pythonls"),
	terraformls = require("lsp.settings.terraformls"),
	tflint = require("lsp.settings.tflint"),
	yamlls = require("lsp.settings.yamlls"),
	-- solargraph = require("lsp.settings.solargraph"),
	svelte = require("lsp.settings.svelte"),
	templ = require("lsp.settings.templ"),
	-- tsserver = require("lsp.settings.tsserver"),
	hls = require("lsp.settings.hls"),
}

for server, settings in pairs(servers) do
	vim.lsp.config(server, vim.tbl_deep_extend("force", settings, defaults))
	vim.lsp.enable(server)
end
