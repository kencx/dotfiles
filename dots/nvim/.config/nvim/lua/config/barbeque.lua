local ok, barbeque = pcall(require, "barbecue")
if not ok then
	return
end

barbeque.setup({
	exclude_filetypes = { "toggleterm", "gitcommit", "hcl", "yaml", "yml" },
	show_dirname = false,
	show_basename = false,

	kinds = {
		File = "",
		Module = "",
		Namespace = "",
		Package = "",
		Class = "",
		Method = "",
		Property = "",
		Field = "",
		Constructor = "",
		Enum = "",
		Interface = "",
		Function = "",
		Variable = "",
		Constant = "",
		String = "",
		Number = "",
		Boolean = "",
		Array = "",
		Object = "",
		Key = "",
		Null = "",
		EnumMember = "",
		Struct = "",
		Event = "",
		Operator = "",
		TypeParameter = "",
	},
})
