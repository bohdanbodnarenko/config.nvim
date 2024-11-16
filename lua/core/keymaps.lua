vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- quit all
vim.keymap.set('n', '<leader>qq', '<cmd> qa <CR>', { desc = 'Exit neovim and save everything', silent = true })

-- delete single character without copying it to register
-- vim.keymap.set('n', 'x', '"_x')

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Buffers
-- vim.keymap.set('n', '<Tab>', ':bnext<CR>', { desc = '[B]uffer: go to the next buffer' })
-- vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', { desc = '[B]uffer: go to previous buffer' })
-- vim.keymap.set('n', '<leader>bx', ':bdelete!<CR>', { desc = '[B]uffer: close the buffer' }) -- close buffer
-- vim.keymap.set('n', '<leader>bb', '<cmd> enew <CR>', { desc = '[B]uffer: create new buffer' }) -- new buffer

-- TODO: fix search with split keybinds overlap
-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', { desc = '[S]plit: split window vertically' })
-- vim.keymap.set('n', '<leader>sh', '<C-w>s', { desc = '[S]plit: split window horizontally' })
-- vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = '[S]plit: make split equal width & height' })
-- vim.keymap.set('n', '<leader>sx', ':close<CR>', { desc = '[S]plit: close current split window' })

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', { desc = '[T]ab: open new tab' })
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', { desc = '[T]ab: close current tab' })
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', { desc = '[T]ab: go to the next tab' })
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', { desc = '[T]ab: go to previous tab' })

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP')
