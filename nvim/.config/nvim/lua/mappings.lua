local bind = vim.api.nvim_set_keymap
-- bind('mode', 'key', 'cmd', *opts)

vim.g.mapleader = " "
bind('n', ';', ':', {noremap = true})

-- unbind arrow keys
bind('n', '<up>', '<NOP>', {noremap = true})
bind('n', '<down>', '<NOP>', {noremap = true})
bind('n', '<left>', '<NOP>', {noremap = true})
bind('n', '<right>', '<NOP>', {noremap = true})

-- window movement
bind('n', '<C-h>', '<C-w>h', {silent = true})
bind('n', '<C-j>', '<C-w>j', {silent = true})
bind('n', '<C-k>', '<C-w>k', {silent = true})
bind('n', '<C-l>', '<C-w>l', {silent = true})

-- better indent
bind('v', '<', '<gv', { noremap = true, silent = true})
bind('v', '>', '>gv', { noremap = true, silent = true})

-- shift lines up and down with alt-{j,k}
bind('n', '<a-j>', ':<c-u>execute "move +". v:count1<cr>', {noremap = true})
bind('n', '<a-k>', ':<c-u>execute "move -1-". v:count1<cr>', {noremap = true})

-- turn off search highlighting
bind('n', '<Leader>h', ':set hlsearch!<CR>', {noremap = true, silent = true})

-- explorer
bind('n', '<Leader>t', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
bind('n', '<Leader>r', ':NvimTreeRefresh<CR>', {noremap = true, silent = true})

-- telescope
bind('n', '<Leader>ff', ':Telescope find_files<CR>', {noremap = true, silent = true})
bind('n', '<Leader>fg', ':Telescope live_grep<CR>' , {noremap = true, silent = true})
bind('n', '<Leader>fb', ':Telescope buffers<CR>' , {noremap = true, silent = true})
bind('n', '<Leader>fh', ':Telescope help_tags<CR>' , {noremap = true, silent = true})

-- comments
bind('n', '<Leader>/', ':CommentToggle<CR>', {noremap = true, silent = true})
