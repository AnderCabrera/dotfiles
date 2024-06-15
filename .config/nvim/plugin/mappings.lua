local map = function(m, l, r, desc, opts)
	opts = opts or { noremap = true, silent = true }
	desc = desc or nil
	opts.desc = desc
	vim.keymap.set(m, l, r, opts)
end

vim.g.mapleader = ","

map("n", "<leader>c", ":Neotree left<CR>")
map("n", "<leader>f", ":Neotree focus<CR>")
map("n", "<leader>t", ":Neotree toggle<CR>")
map("n", "<leader>q", ":Neotree close<CR>")
map("n", "<leader>un", ":noh<CR>")

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- This is a custom mapping for opening the telescope quickfix list
-- vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { noremap = true, silent = true })
