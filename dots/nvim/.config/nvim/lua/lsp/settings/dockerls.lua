local lspcontainers_ok, lspcontainers = pcall(require, "lspcontainers")

local lspconfig_util = require("lspconfig/util")

if not lspcontainers_ok then
	return {
        root_dir = lspconfig_util.root_pattern(".git", vim.fn.getcwd()),
    }
end

return {
	cmd = lspcontainers.command("dockerls"),
	before_init = function(params)
		params.processId = vim.NIL
	end,
	root_dir = lspconfig_util.root_pattern(".git", vim.fn.getcwd()),
}
