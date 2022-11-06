local minimap = require("mini.map")
minimap.setup({
	integrations = {
		minimap.gen_integration.builtin_search(),
		-- minimap.gen_integration.gitsigns(),
		minimap.gen_integration.diagnostic(),
	},
	symbols = {
		scroll_line = "▶",
		scroll_view = "╎",
	},
	window = {
		show_integration_count = false,
		winblend = 50,
	},
})
