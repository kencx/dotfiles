local lualine = require("lualine")

-- if lsp attached, show LSP
local provider = function()
	if next(vim.lsp.buf_get_clients()) ~= nil then
		return " LSP"
	else
		return ""
	end
end

lualine.setup({

	options = {
		theme = "gruvbox",
		disabled_filetypes = { "NvimTree", "terminal", "help", "dashboard" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_lsp" } } },
		lualine_c = { "filename" },
		lualine_x = { "filetype", { provider } },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
