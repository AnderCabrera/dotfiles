local map = function(m, l, r, desc, opts)
	opts = opts or { noremap = true, silent = true }
	desc = desc or nil
	opts.desc = desc
	vim.keymap.set(m, l, r, opts)
end

vim.g.mapleader = ","

-- Save with CTRL S
map("n", "<C-s>", ":w<CR>")
map("i", "<C-s>", "<Esc>:w<CR>")

-- Indent with tab
map("v", "<TAB>", ">gv")
map("v", "<S-TAB>", "<gv")
map("v", ">", ">gv")
map("v", "<", "<gv")

-- NvimTree
map("n", "<leader>c", vim.cmd.NvimTreeToggle)

-- Buffer
map("n", "<leader>bn", ":BufferNext<CR>")
map("n", "<leader>bp", ":BufferPrevious<CR>")
map("n", "<leader>bd", ":BufferClose<CR>")

-- Replace word or text
map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("v", "<leader>r", "\"hy:%s/<C-r>h/<C-r>h/g<left><left>")

-- Move selected lines up and down
map("v", "<C-M-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-M-k>", ":m '<-2<CR>gv=gv")

-- Terminal
map("n", "<leader>t", ":belowright split +resize-20 | terminal<CR>")
map("t", "<C-n>", "<C-\\><C-n>")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")

-- Resize windows
map("n", "<M-h>", ":vertical resize +5<CR>")
map("n", "<M-l>", ":vertical resize -5<CR>")
map("n", "<M-j>", ":horizontal resize -5<CR>")
map("n", "<M-k>", ":horizontal resize +5<CR>")

-- Stay in the middle while half page scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- telescope
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files, {})
map("n", "<leader>fg", builtin.live_grep, {})
map("n", "<leader>fb", builtin.buffers, {})
map("n", "<leader>fh", builtin.help_tags, {})

map("n", "<C-k>t", builtin.colorscheme, {})
