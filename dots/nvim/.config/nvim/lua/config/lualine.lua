local lualine = require("lualine")

-- if lsp attached, show LSP
local provider = function()
	if next(vim.lsp.buf_get_clients()) ~= nil then
		return " LSP"
	else
		return ""
	end
end

-- local relative_to_root = function()
-- 	local home = vim.fs.find(".git", { path = vim.fn.expand("%:p"), upward = true, type = "directory" })[1]
-- 	if home == nil then
-- 		return vim.fn.expand("%:~:.")
-- 	end
--
-- 	local trunk = table.concat({
-- 		vim.fs.basename(vim.fs.dirname(home)),
-- 		"/",
-- 		vim.fn.expand("%r"),
-- 	})
-- 	return trunk
-- end

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
			-- { relative_to_root },
		},
		lualine_x = { "filetype", { provider } },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
