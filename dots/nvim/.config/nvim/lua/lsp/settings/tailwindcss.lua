local lspcontainers_ok, lspcontainers = pcall(require, "lspcontainers")
if not lspcontainers_ok then
	return
end

local lspconfig_util = require("lspconfig/util")

return {
	cmd = lspcontainers.command("tailwindcss"),
	before_init = function(params)
		params.processId = vim.NIL
	end,
	filetypes = { "html", "css", "scss", "sass", "postcss", "javascript", "typescript", "svelte" },
	root_dir = lspconfig_util.root_pattern(
		"tailwind.config.cjs",
		"tailwind.config.js",
		"tailwind.config.ts",
		"package.json",
		".git",
		vim.fn.getcwd()
	),
}
