local lspcontainers_ok, lspcontainers = pcall(require, "lspcontainers")
if not lspcontainers_ok then
	return
end

return {
	cmd = lspcontainers.command("sumneko_lua"),
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
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
			},
			telemetry = { enable = false },
		},
	},
}
