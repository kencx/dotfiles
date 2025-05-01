local ok, lualine = pcall(require, "lualine")
if not ok then
	return
end

-- if lsp attached, show LSP
local provider = function()
	if next(vim.lsp.et_clients()) ~= nil then
		return " LSP"
	else
		return ""
	end
end

lualine.setup({
	options = {
		theme = "kanagawa",
		disabled_filetypes = { "NvimTree", "terminal", "help", "dashboard" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			"diff",
			{ "diagnostics", sources = { "nvim_diagnostic" } },
		},
		lualine_c = {
			{ "filename", path = 1 },
		},
		lualine_x = { "filetype", { provider } },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
