local lspcontainers_ok, lspcontainers = pcall(require, "lspcontainers")
if not lspcontainers_ok then
	return
end

return {
	cmd = lspcontainers.command("lua_ls"),
	filetypes = { "lua" },
	root_markers = {
		".emmyrc.json",
		".luarc.json",
		".luarc.jsonc",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml",
		"selene.yml",
		".git",
	},
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = "runtime_path",
			},
			hint = {
				enable = true,
				semicolon = "Disable",
			},
			diagnostics = {
				globals = { "vim" },
				disable = { "missing-fields" },
			},
			workspace = {
				-- make server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = { enable = false },
		},
	},
}
