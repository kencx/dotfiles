local util = require("util")
local bind = util.map
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

-- unbind arrow keys
bind("n", "<up>", "<NOP>", opts)
bind("n", "<down>", "<NOP>", opts)
bind("n", "<left>", "<NOP>", opts)
bind("n", "<right>", "<NOP>", opts)

-- exit insert mode
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

-- new buffer
bind("n", "<Leader>n", ":enew<CR>", opts)

-- change pwd to current buffer
-- bind("n", "<Leader>cd", ":cd %:p:h<CR>", opts)
-- bind("n", "<Leader>cy", ':let @+ = expand("%:p:h")<CR>', opts)

-- extract vselection to new buffer
bind("v", "<Leader>ex", [[:'<,'> d | new +put! " | b#<CR><CR>]], opts)

-- toggle relativenumber
bind("n", "<Leader>rnn", ":exec &rnu? 'se nornu!' : 'se rnu!'<CR>", opts)

-- bind("n", ";", ":", opts)

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

-- treesitter
bind("n", "<Leader>ts", ":write | edit | TSBufEnable highlight<CR>", opts)

-- markdown-preview
bind("n", "<Leader>md", ":MarkdownPreview<CR>", opts)

-- obsidian.nvim
bind("n", "gf", function()
	if require("obsidian").util.cursor_on_markdown_link() then
		return "<cmd>ObsidianFollowLink<CR>"
	else
		return "gf"
	end
end, { noremap = false, expr = true })

bind("n", "<Leader>og", ":ObsidianSearch<CR>", opts)

-- diffview
--[[ bind("n", "<Leader>dh", ":DiffviewFileHistory<CR>", opts) ]]
--[[ function DiffviewToggle() ]]
--[[ 	local view = require("diffview.lib").get_current_view() ]]
--[[ 	if view then ]]
--[[ 		vim.cmd("DiffviewClose") ]]
--[[ 	else ]]
--[[ 		vim.cmd("DiffviewOpen") ]]
--[[ 	end ]]
--[[ end ]]

--[[ lua_bind("n", "<Leader>dv", DiffviewToggle, opts) ]]
