local defaults = require("kanagawa.colors").setup()

require("kanagawa").setup({
	undercurls = true,
	colors = {
		sumiInk0 = "#272727",
		sumiInk1 = "#282828",
	},
	overrides = {
		Search = { bg = defaults.surimiOrange },
		IncSearch = { fg = defaults.sumiInk0, bg = defaults.surimiOrange },
		Visual = { fg = defaults.sumiInk0, bg = defaults.surimiOrange },
	},
})

-- must be called after setup
vim.cmd("colorscheme kanagawa")
