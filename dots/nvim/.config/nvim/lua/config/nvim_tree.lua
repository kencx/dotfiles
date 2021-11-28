--vim.g.nvim_tree_git_h1 = 0
vim.g.nvim_tree_group_empty = 1 -- compact folders that contain only a single folder
vim.g.nvim_tree_highlight_opened_files = 0

--[[vim.g.nvim_tree_icons = {
     'default': '',
     'symlink': '',
     'git': {
       'unstaged': "✗",
       'staged': "✓",
       'unmerged': "",
       'renamed': "➜",
       'untracked': "★",
       'deleted': "",
       'ignored': "◌",
    },
     'folder': {
       'arrow_open': "",
       'arrow_closed': "",
       'default': "",
       'open': "",
       'empty': "",
       'empty_open': "",
       'symlink': "",
       'symlink_open': "",
    }
}]]

require("nvim-tree").setup({

	disable_netrw = true,
	auto_close = true,
	open_on_setup = false,
	open_on_tab = false,

	-- update the focused file on `BufEnter`,
	-- un-collapses the folders recursively until it finds the file
	update_focus_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},

	view = {
		width = 20,
		side = "left",
		auto_resize = true,
		mappings = {
			custom_only = false,
		},
	},
})
