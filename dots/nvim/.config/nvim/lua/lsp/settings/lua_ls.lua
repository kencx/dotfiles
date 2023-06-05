local lspcontainers_ok, lspcontainers = pcall(require, "lspcontainers")
if not lspcontainers_ok then
	return
end

return {
	cmd = lspcontainers.command("lua_ls"),
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = "runtime_path",
			},
			diagnostics = {
				-- recognize `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- make server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = { enable = false },
		},
	},
}
