vim.g.indent_blankline_context_patterns = {
	"class",
	"return",
	"function",
	"method",
	"^if",
	"^while",
	"jsx_element",
	"^for",
	"^object",
	"^table",
	"block",
	"arguments",
	"if_statement",
	"else_clause",
	"jsx_element",
	"jsx_self_closing_element",
	"try_statement",
	"catch_clause",
	"import_statement",
	"operation_type",
}

vim.g.indent_blankline_use_treesitter = true

require("indent_blankline").setup({
	char = "⦙",
	show_current_context = false,
	show_first_indent_level = false,
	buftype_exclude = { "terminal", "nofile" },
	filetype_exclude = { "help", "packer", "dashboard", "NvimTree" },
})
