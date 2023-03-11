local ok, lsp_signature = pcall(require, "lsp_signature")
if not ok then
	return
end

lsp_signature.setup({
	debug = false,

	-- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
	-- set to 0 if you DO NOT want any API comments be shown
	-- This setting only take effect in insert mode, it does not affect signature help in normal
	-- mode, 10 by default
	doc_lines = 10,

	floating_window = true,
	floating_window_above_cur_line = true,

	-- set to true, the floating window will not auto-close until finish all parameters
	fix_pos = false,
	hint_enable = false,
	handler_opts = {
		border = "rounded",
	},
	-- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
	always_trigger = false,

	-- by default it will be on top of all floating windows, set to <= 50 send it to bottom
	zindex = 200,

	-- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
	toggle_key = nil,
})
