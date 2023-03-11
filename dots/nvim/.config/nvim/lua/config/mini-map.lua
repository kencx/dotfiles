local ok, minimap = pcall(require, "mini.map")
if not ok then
	return
end

minimap.setup({
	integrations = {
		minimap.gen_integration.builtin_search(),
		-- minimap.gen_integration.gitsigns(),
		minimap.gen_integration.diagnostic(),
	},
	symbols = {
		scroll_line = "▶",
		scroll_view = "╎",
	},
	window = {
		show_integration_count = false,
		winblend = 50,
	},
})

-- set minimap colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "MiniMapNormal", { fg = "#363646", bg = "#272727" })
	end,
})
