local ok, kanagawa = pcall(require, "kanagawa")
if not ok then
	return
end

local defaults = require("kanagawa.colors").setup()
local overrides = {
	Search = { bg = defaults.surimiOrange, fg = defaults.sumiInk0 },
	IncSearch = { fg = defaults.sumiInk0, bg = defaults.surimiOrange },
	Visual = { fg = defaults.sumiInk0, bg = defaults.surimiOrange },
}

kanagawa.setup({
	undercurl = true,
	colors = {
		sumiInk0 = "#272727",
		sumiInk1 = "#282828",
	},
	overrides = overrides,
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")
