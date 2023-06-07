local ok, autopairs = pcall(require, "nvim-autopairs")
if not ok then
	return
end

autopairs.setup({
	disable_filetype = { "TelescopePrompt" },
	map_cr = true,
	enable_check_bracket_line = true,
	fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = [=[[%'%"%>%]%)%}%,]]=],
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "Search",
		highlight_grey = "Comment",
	},
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
	return
end
cmp.event:on(
	"confirm_done",
	cmp_autopairs.on_confirm_done({
		filetypes = { tex = false },
	})
)
