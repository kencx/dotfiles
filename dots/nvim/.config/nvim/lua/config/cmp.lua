vim.opt.completeopt = "menu,menuone,noselect"

local ok, cmp = pcall(require, "cmp")
if not ok then
	return
end

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			-- behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				-- fallback function sends an already mapped key. In this case, it's probably `<Tab>`.
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
	}),

	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},

	formatting = {
		format = function(entry, vim_item)
			-- concatenate icons with name of item
			vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
			vim_item.menu = ({
				buffer = "[buf]",
				path = "[path]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[Lua]",
				vsnip = "[snip]",
				latex_symbols = "[laTeX]",
			})[entry.source.name]
			return vim_item
		end,
	},

	window = {
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
	},

	completion = {
		get_trigger_characters = function(trigger_chars)
			local new_trigger_chars = {}
			for _, char in ipairs(trigger_chars) do
				if char ~= ">" then
					table.insert(new_trigger_chars, char)
				end
			end
			return new_trigger_chars
		end,
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "path" },
		{
			name = "vsnip",
			entry_filter = function()
				local context = require("cmp.config.context")
				local string_ctx = context.in_treesitter_capture("string") and not context.in_syntax_group("String")
				local comment_ctx = context.in_treesitter_capture("comment") or context.in_syntax_group("Comment")
				return not string_ctx and not comment_ctx
			end,
		},
		{ name = "buffer", keyword_length = 3 },
		{ name = "nvim_lua" },
	}),

	experimental = {
		ghost_text = false,
	},
})

cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})
