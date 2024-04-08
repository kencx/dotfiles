local ok, kanagawa = pcall(require, "kanagawa")
if not ok then
	return
end

kanagawa.setup({
	undercurl = true,
	colors = {
		palette = {
			sumiInk0 = "#272727",
			sumiInk1 = "#282828",
		},
		theme = {
			all = {
				ui = {
					bg = "#272727",
					bg_dim = "#282828",
					bg_gutter = "none",
				},
			},
		},
	},
	overrides = function(colors)
		local palette = colors.palette
		return {
			Search = { bg = palette.surimiOrange, fg = palette.sumiInk0 },
			IncSearch = { fg = palette.sumiInk0, bg = palette.surimiOrange },
			Visual = { fg = palette.sumiInk0, bg = palette.surimiOrange },
		}
	end,
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa")
