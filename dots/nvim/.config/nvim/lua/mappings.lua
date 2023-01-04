-- eg: bind('mode', 'key', 'cmd', *opts)
local bind = vim.api.nvim_set_keymap
local lua_bind = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
-- bind("n", ";", ":", opts)

-- unbind arrow keys
bind("n", "<up>", "<NOP>", opts)
bind("n", "<down>", "<NOP>", opts)
bind("n", "<left>", "<NOP>", opts)
bind("n", "<right>", "<NOP>", opts)

-- unbind esc
bind("i", "jj", "<Esc>", opts)
bind("i", "jk", "<Esc>", opts)
bind("i", "kk", "<Esc>", opts)

-- vim-tmux-navigator (pane navigation)
-- https://github.com/christoomey/vim-tmux-navigator
vim.cmd([[let g:tmux_navigator_no_mappings = 1]])

bind("n", "<C-h>", ":TmuxNavigateLeft<cr>", opts)
bind("n", "<C-j>", ":TmuxNavigateDown<cr>", opts)
bind("n", "<C-k>", ":TmuxNavigateUp<cr>", opts)
bind("n", "<C-l>", ":TmuxNavigateRight<cr>", opts)

-- autosave when moving from vim to tmux
vim.cmd([[let g:tmux_navigator_save_on_switch = 1]])

-- better indent
bind("v", "<", "<gv", opts)
bind("v", ">", ">gv", opts)

-- shift lines up and down with alt-{j,k}
bind("n", "<a-j>", ":m .+1<CR>==", opts)
bind("n", "<a-k>", ":m .-2<CR>==", opts)
bind("v", "<a-j>", ":m '>+1<CR>gv=gv", opts)
bind("v", "<a-k>", ":m '<-2<CR>gv=gv", opts)

-- turn off search highlighting
bind("n", "<Leader>h", ":set hlsearch!<CR>", opts)

-- new tab
bind("n", "<Leader>n", ":tabnew<CR>", opts)

-- markdown insert link
bind("v", "<Leader>ml", [[c[<c-r>"]()<esc>]], opts)

-- change pwd to current buffer
bind("n", "<Leader>cd", ":cd %:p:h<CR>", opts)
bind("n", "<Leader>cy", ':let @+ = expand("%:p:h")<CR>', opts)

-- extract vselection to new buffer
bind("v", "<Leader>ex", [[:'<,'> d | new +put! " | b#<CR><CR>]], opts)

-------------
-- plugins --
-------------

-- barbar.nvim
-- move to prev/next
bind("n", "<A-,>", ":BufferPrevious<CR>", opts)
bind("n", "<A-.>", ":BufferNext<CR>", opts)
-- reorder to prev/next
bind("n", "<A-<>", ":BufferMovePrevious<CR>", opts)
bind("n", "<A->>", ":BufferMoveNext<CR>", opts)
-- pin/unpin
bind("n", "<A-p>", ":BufferPin<CR>", opts)
-- close buffer
bind("n", "<A-w>", ":BufferClose<CR>", opts)

-- telescope
bind("n", "<Leader>ft", ":Telescope file_browser<CR>", opts)
bind("n", "<Leader>ff", ":Telescope find_files hidden=true <CR>", opts)
bind("n", "<Leader>fg", ":Telescope live_grep<CR>", opts)
bind("n", "<Leader>fb", ":Telescope buffers<CR>", opts)
bind("n", "<Leader>fc", ":Telescope commands<CR>", opts)
bind("n", "<Leader>fr", ":Telescope registers<CR>", opts)

bind("n", "<Leader>fd", ":Telescope diagnostics bufnr=0<CR>", opts)
bind("n", "<Leader>fs", ":Telescope lsp_document_symbols<CR>", opts)

bind("n", "<Leader>gc", ":Telescope git_commits<CR>", opts)
bind("n", "<Leader>gst", ":Telescope git_status<CR>", opts)

-- colorizer
bind("n", "<Leader>cc", ":ColorizerToggle<CR>", opts)

-- treesitter
bind("n", "<Leader>ts", ":write | edit | TSBufEnable highlight<CR>", opts)

-- gitsigns
bind("v", "<Leader>sh", ":Gitsigns stage_hunk<CR>", opts)
bind("v", "<Leader>rh", ":Gitsigns reset_hunk<CR>", opts)
bind("n", "<Leader>uh", ":Gitsigns undo_stage_hunk<CR>", opts)
bind("n", "<Leader>sb", ":Gitsigns stage_buffer<CR>", opts)
bind("n", "<Leader>rb", ":Gitsigns reset_buffer<CR>", opts)
bind("n", "<Leader>hp", ":Gitsigns preview_hunk<CR>", opts)

lua_bind("n", "]c", function()
	local gs = require("gitsigns")
	if vim.wo.diff then
		return "]c"
	end
	vim.schedule(function()
		gs.next_hunk()
	end)
	return "<Ignore>"
end, opts)

lua_bind("n", "[c", function()
	local gs = require("gitsigns")
	if vim.wo.diff then
		return "[c"
	end
	vim.schedule(function()
		gs.prev_hunk()
	end)
	return "<Ignore>"
end, opts)

-- diffview
bind("n", "<Leader>dh", ":DiffviewFileHistory<CR>", opts)
function DiffviewToggle()
	local view = require("diffview.lib").get_current_view()
	if view then
		vim.cmd("DiffviewClose")
	else
		vim.cmd("DiffviewOpen")
	end
end

lua_bind("n", "<Leader>dv", DiffviewToggle, opts)

-- markdown-preview
bind("n", "<Leader>md", ":MarkdownPreview<CR>", opts)

-- mini.map
bind("n", "<Leader>mm", ":lua MiniMap.toggle()<CR>", opts)
bind("n", "<Leader>mf", ":lua MiniMap.toggle_focus()<CR>", opts)

-- obsidian.nvim
lua_bind("n", "gf", function()
	if require("obsidian").util.cursor_on_markdown_link() then
		return "<cmd>ObsidianFollowLink<CR>"
	else
		return "gf"
	end
end, { noremap = false, expr = true })

bind("n", "<Leader>og", ":ObsidianSearch<CR>", opts)
