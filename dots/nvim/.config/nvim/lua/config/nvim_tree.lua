require("nvim-tree").setup({
	disable_netrw = true,
	ignore_ft_on_setup = { "dashboard" },
	-- auto_close = false,
	open_on_setup = false,
	open_on_tab = false,
	hijack_cursor = true,
	update_cwd = true,
	renderer = {
		highlight_git = false,
		group_empty = true, -- compact folders that contain only a single folder
		highlight_opened_files = "none",
		icons = {
			glyphs = {},
		},
	},
	-- update the focused file on `BufEnter`,
	-- un-collapses the folders recursively until it finds the file
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},

	actions = {
		open_file = {
			resize_window = true,
		},
	},

	view = {
		width = 30,
		side = "left",
		mappings = {
			custom_only = false,
		},
	},

	filters = {
		dotfiles = false,
		custom = { ".git" },
	},

	git = {
		enable = false,
		timeout = 400,
		ignore = false,
	},
})
