-- bind('mode', 'key', 'cmd', *opts)
local bind = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
bind("n", ";", ":", opts)

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

-- markdown
bind("v", "wl", [[c[<c-r>"]()<esc>]], opts)

-------------
-- plugins --
-------------

-- nvim-tree
bind("n", "<Leader>t", ":NvimTreeToggle<CR>", opts)
bind("n", "<Leader>r", ":NvimTreeRefresh<CR>", opts) -- consider remove

-- barbar.nvim
-- move to prev/next
bind("n", "<A-,>", ":BufferPrevious<CR>", opts)
bind("n", "<A-.>", ":BufferNext<CR>", opts)
-- reorder to prev/next
bind("n", "<A-<>", ":BufferMovePrevious<CR>", opts)
bind("n", "<A->>", ":BufferMoveNext<CR>", opts)
-- move to buffer position
bind("n", "<A-1>", ":BufferGoto 1<CR>", opts)
bind("n", "<A-2>", ":BufferGoto 2<CR>", opts)
bind("n", "<A-3>", ":BufferGoto 3<CR>", opts)
bind("n", "<A-4>", ":BufferGoto 4<CR>", opts)
bind("n", "<A-5>", ":BufferGoto 5<CR>", opts)
bind("n", "<A-6>", ":BufferGoto 6<CR>", opts)
bind("n", "<A-7>", ":BufferGoto 7<CR>", opts)
bind("n", "<A-8>", ":BufferGoto 8<CR>", opts)
bind("n", "<A-9>", ":BufferGoto 9<CR>", opts)
bind("n", "<A-0>", ":BufferLast <CR>", opts)
-- pin/unpin
bind("n", "<A-p>", ":BufferPin<CR>", opts)
-- close buffer
bind("n", "<A-w>", ":BufferClose<CR>", opts)
-- Sort automatically by
bind("n", "<Space>bb", ":BufferOrderByBufferNumber<CR>", opts)

-- telescope
bind("n", "<Leader>ff", ":Telescope find_files hidden=true <CR>", opts)
bind("n", "<Leader>fg", ":Telescope live_grep<CR>", opts)
bind("n", "<Leader>fb", ":Telescope buffers<CR>", opts)
bind("n", "<Leader>fc", ":Telescope commands<CR>", opts)
bind("n", "<Leader>fd", ":Telescope lsp_document_diagnostics<CR>", opts)

-- colorizer
bind("n", "<Leader>cc", ":ColorizerToggle<CR>", opts)
