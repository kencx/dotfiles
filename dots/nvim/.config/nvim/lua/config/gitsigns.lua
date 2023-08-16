local ok, gitsigns = pcall(require, "gitsigns", opts)
if not ok then
	return
end

local util = require("util")

gitsigns.setup({
	on_attach = function(bufnr)
		local opts = { buffer = bufnr }

		util.map("v", "<Leader>sh", ":Gitsigns stage_hunk<CR>", opts)
		util.map("v", "<Leader>rh", ":Gitsigns reset_hunk<CR>", opts)
		util.map("n", "<Leader>uh", ":Gitsigns undo_stage_hunk<CR>", opts)
		util.map("n", "<Leader>sb", ":Gitsigns stage_buffer<CR>", opts)
		util.map("n", "<Leader>rb", ":Gitsigns reset_buffer<CR>", opts)
		util.map("n", "<Leader>hp", ":Gitsigns preview_hunk<CR>", opts)
		util.map("n", "<Leader>gb", function()
			gitsigns.blame_line({ full = true })
		end)
		util.map("n", "<Leader>td", ":Gitsigns toggle_deleted<CR>", opts)
		util.map("n", "<leader>hd", ":Gitsigns diffthis<CR>", opts)
		util.map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", opts)

		util.map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gitsigns.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, buffer = bufnr })

		util.map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gitsigns.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, buffer = bufnr })
	end,
})
