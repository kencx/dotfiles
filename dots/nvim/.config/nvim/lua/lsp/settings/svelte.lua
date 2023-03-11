local lspcontainers_ok, lspcontainers = pcall(require, "lspcontainers")
if not lspcontainers_ok then
	return
end

local lspconfig_util = require("lspconfig/util")

return {
	cmd = lspcontainers.command("svelte"),
	before_init = function(params)
		params.processId = vim.NIL
	end,
	root_dir = lspconfig_util.root_pattern("svelte.config.js", ".git", vim.fn.getcwd()),
}
