M = {}
local path = {}

M.map = function(mode, l, r, opts)
	opts = opts or {}
	vim.keymap.set(mode, l, r, opts)
end

M.autocmd = function(group_name, event, pattern, command)
	local augroup = vim.api.nvim_create_augroup(group_name, {})

	vim.api.nvim_create_autocmd(event, {
		group = augroup,
		pattern = pattern,
		command = command,
	})
end

M.autocmd_callback = function(group_name, event, pattern, callback)
	local augroup = vim.api.nvim_create_augroup(group_name, {})

	vim.api.nvim_create_autocmd(event, {
		group = augroup,
		pattern = pattern,
		callback = callback,
	})
end

path.join = function(...)
	return vim.fs.normalize(table.concat(vim.tbl_flatten({ ... }), "/"))
end

path.cwd = function()
	return vim.fs.dirname(vim.api.nvim_buf_get_name(0))
end

M.path = path
return M
