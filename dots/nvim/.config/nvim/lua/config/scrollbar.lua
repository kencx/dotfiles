local colors = require("kanagawa.colors").setup()

require("scrollbar").setup({
	show = true,
	handle = {
		text = " ",
		color = colors.bg_light1,
		hide_if_all_visible = true,
	},
	excluded_filetypes = {
		"NvimTree",
		"prompt",
		"TelescopePrompt",
	},
	handlers = {
		diagnostics = true,
	},
})
