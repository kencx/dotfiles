local ok, oil = pcall(require, "oil")
if not ok then
	return
end

local util = require("util")

-- toggle Oil
util.map("n", "<Leader>ol", function()
	local open = false

	-- check for oil filetype in current buffer
	local buf = vim.api.nvim_get_current_buf()
	if vim.api.nvim_buf_get_option(buf, "filetype") == "oil" then
		open = true
		vim.api.nvim_win_close(vim.api.nvim_get_current_win(), false)
	end

	if open == false then
		vim.api.nvim_command("vsplit | wincmd r")
		vim.api.nvim_win_set_width(0, math.floor(vim.o.columns / 3))
		oil.open()
	end
end)

oil.setup({
	columns = {
		"icon",
		"permissions",
		"size",
	},

	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<C-s>"] = "actions.select_vsplit",
		-- ["<C-h>"] = "actions.select_split",
		["<C-t>"] = "actions.select_tab",
		["<C-p>"] = "actions.preview",
		["<C-c>"] = "actions.close",
		-- ["<C-l>"] = "actions.refresh",

		-- these clash with vim-tmux-navigator keymaps
		["<C-h>"] = false,
		["<C-l>"] = false,

		["-"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
		["~"] = "actions.tcd",
		["g."] = "actions.toggle_hidden",
	},
})
