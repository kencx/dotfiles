-- bind('mode', 'key', 'cmd', *opts)
local bind = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true}

vim.g.mapleader = " "
bind('n', ';', ':', opts)

--> unbind arrow keys
bind('n', '<up>', '<NOP>', opts)
bind('n', '<down>', '<NOP>', opts)
bind('n', '<left>', '<NOP>', opts)
bind('n', '<right>', '<NOP>', opts)

--> window movement
bind('n', '<C-h>', '<C-w>h', opts)
bind('n', '<C-j>', '<C-w>j', opts)
bind('n', '<C-k>', '<C-w>k', opts)
bind('n', '<C-l>', '<C-w>l', opts)

--> better indent
bind('v', '<', '<gv', opts)
bind('v', '>', '>gv', opts)

--> shift lines up and down with alt-{j,k}
bind('n', '<a-j>', ':<c-u>execute "move +". v:count1<cr>', opts)
bind('n', '<a-k>', ':<c-u>execute "move -1-". v:count1<cr>', opts)

--> turn off search highlighting
bind('n', '<Leader>h', ':set hlsearch!<CR>', opts)

--> nvim-tree
bind('n', '<Leader>t', ':NvimTreeToggle<CR>', opts)
bind('n', '<Leader>r', ':NvimTreeRefresh<CR>', opts) -- consider remove

--> barbar.nvim
-- move to prev/next
bind('n', '<A-,>', ':BufferPrevious<CR>', opts)
bind('n', '<A-.>', ':BufferNext<CR>', opts)
-- reorder to prev/next
bind('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
bind('n', '<A->>', ':BufferMoveNext<CR>', opts)
-- move to buffer position
bind('n', '<A-1>', ':BufferGoto 1<CR>', opts)
bind('n', '<A-2>', ':BufferGoto 2<CR>', opts)
bind('n', '<A-3>', ':BufferGoto 3<CR>', opts)
bind('n', '<A-4>', ':BufferGoto 4<CR>', opts)
bind('n', '<A-5>', ':BufferGoto 5<CR>', opts)
bind('n', '<A-6>', ':BufferGoto 6<CR>', opts)
bind('n', '<A-7>', ':BufferGoto 7<CR>', opts)
bind('n', '<A-8>', ':BufferGoto 8<CR>', opts)
bind('n', '<A-9>', ':BufferGoto 9<CR>', opts)
bind('n', '<A-0>', ':BufferLast <CR>', opts)
-- pin/unpin
bind('n', '<A-p>', ':BufferPin<CR>', opts)
-- close buffer
bind('n', '<A-w>', ':BufferClose<CR>', opts)
-- Magic buffer-picking mode
-- bind('n', '<C-p>', ':BufferPick<CR>', opts)
-- Sort automatically by
bind('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>', opts)
-- bind('n', '<Space>bd', ':BufferOrderByDirectory<CR>', opts)
-- bind('n', '<Space>bl', ':BufferOrderByLanguage<CR>', opts)

--> telescope
bind('n', '<Leader>ff', ':Telescope find_files<CR>', opts)
bind('n', '<Leader>fg', ':Telescope live_grep<CR>' , opts)
bind('n', '<Leader>fb', ':Telescope buffers<CR>' , opts)
bind('n', '<Leader>fh', ':Telescope help_tags<CR>' , opts)

--> comments
bind('n', '<Leader>/', ':CommentToggle<CR>', opts)
