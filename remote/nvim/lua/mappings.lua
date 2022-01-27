-- bind('mode', 'key', 'cmd', *opts)
local bind = vim.api.nvim_set_keymap
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
bind("v", "wl", [[c[<c-r>"]()<esc>]], opts)

-- change pwd to current buffer
bind("n", "<Leader>cd", ":cd %:p:h<CR>", opts)
