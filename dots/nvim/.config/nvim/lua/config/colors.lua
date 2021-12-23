
local colors = {
	sumiInk0 = "#272727",
	sumiInk1 = "#282828",
}

require("kanagawa").setup({
	keywordStyle = "NONE",
	variablebuiltinStyle = "NONE",
	colors = colors,
	overrides = {
		-- Search = { bg = require("kanagawa.colors").surimiOrange },
		-- IncSearch = { bg = require("kanagawa.colors").surimiOrange, style = "NONE" },
		-- Visual = { bg = require("kanagawa.colors").surimiOrange },
	},
})

-- must be called after setup
vim.cmd("colorscheme kanagawa")
