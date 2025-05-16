local map = function(m, l, r, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(m, l, r, opts)
end

vim.g.mapleader = ' '

-- Save with CTRL S
-- map("n", "<C-s>", ":w<CR>")
-- map("i", "<C-s>", "<Esc>:w<CR>")

-- Indent with tab
map('v', '<TAB>', '>gv')
map('v', '<S-TAB>', '<gv')
map('v', '>', '>gv')
map('v', '<', '<gv')

-- NvimTree
map('n', '<leader>c', ':NvimTreeToggle<CR>')

-- Buffer
map('n', '<leader>bn', ':bnext<CR>')
map('n', '<leader>bp', ':bprevious<CR>')
map('n', '<leader>bd', ':bdelete<CR>')

-- Replace word or text
map('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map('v', '<leader>r', '"hy:%s/<C-r>h/<C-r>h/g<left><left>')

-- Move selected lines up and down
map('v', '<C-S-Up>', ":m '<-2<CR>gv=gv")
map('v', '<C-S-Down>', ":m '>+1<CR>gv=gv")

-- Terminal
map('n', '<leader>t', ':belowright split +resize-20 | terminal<CR>')
map('t', '<C-n>', '<C-\\><C-n>')
map('t', '<C-k>', '<C-\\><C-n><C-w>k')

-- Resize windows
map('n', '<M-h>', ':vertical resize +5<CR>')
map('n', '<M-l>', ':vertical resize -5<CR>')
map('n', '<M-j>', ':horizontal resize -5<CR>')
map('n', '<M-k>', ':horizontal resize +5<CR>')

-- Stay in the middle while half page scrolling
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

-- Lazygit
map('n', '<leader>lg', ':LazyGit<CR>')

-- Git fugitive
map('n', '<leader>gs', ':G<CR>')

-- Undo tree
map('n', '<leader>ut', ':UndotreeToggle<CR>')

-- Quickfix
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<C-j>', ':cnext<CR>zz')
vim.keymap.set('n', '<C-k>', ':cprev<CR>zz')
vim.keymap.set('n', '<leader>j', ':lnext<CR>zz')
vim.keymap.set('n', '<leader>k', ':lprev<CR>zz')

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

map('i', '<C-c>', '<Esc>')

