local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
	return
end

gitsigns.setup({
	on_attach = function(bufnr)
		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		map("v", "<Leader>sh", ":Gitsigns stage_hunk<CR>")
		map("v", "<Leader>rh", ":Gitsigns reset_hunk<CR>")
		map("n", "<Leader>uh", ":Gitsigns undo_stage_hunk<CR>")
		map("n", "<Leader>sb", ":Gitsigns stage_buffer<CR>")
		map("n", "<Leader>rb", ":Gitsigns reset_buffer<CR>")
		map("n", "<Leader>hp", ":Gitsigns preview_hunk<CR>")
		map("n", "<Leader>gb", function()
			gitsigns.blame_line({ full = true })
		end)
		map("n", "<Leader>td", ":Gitsigns toggle_deleted<CR>")
		map("n", "<leader>hd", ":Gitsigns diffthis<CR>")
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")

		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gitsigns.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gitsigns.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })
	end,
})
