vim.opt.completeopt = "menu,menuone,noselect"

local cmp = require("cmp")
cmp.setup({

	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		-- scrolling in documentation?
	},

	-- add snippets (LuaSnip or UltiSnips)
	-- and mappings (https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings)

	documentation = {
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	},

	sources = {
		{ name = "nvim_lsp" },
	},
})
