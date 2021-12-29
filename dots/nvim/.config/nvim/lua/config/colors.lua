local defaults = require("kanagawa.colors").setup()

local colors = {
	sumiInk0 = "#272727",
	sumiInk1 = "#282828",
}

local overrides = {
	Search = { bg = defaults.surimiOrange },
	IncSearch = { fg = defaults.sumiInk0, bg = defaults.surimiOrange, style = "NONE" },
	Visual = { fg = defaults.sumiInk0, bg = defaults.surimiOrange }
}

require("kanagawa").setup({
	keywordStyle = "NONE",
	variablebuiltinStyle = "NONE",
	colors = colors,
	overrides = overrides,
})

-- must be called after setup
vim.cmd("colorscheme kanagawa")
