local set = vim.opt

-- Line numbers
set.number = true
set.relativenumber = true

-- Indentation
vim.opt.smartindent = true

-- Tabs
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2

set.encoding = "UTF-8"
vim.o.mouse = 'a'
set.clipboard = "unnamedplus"

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- no show mode
set.showmode = false

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Don't wrap text
vim.opt.wrap = false

-- Vertical markers
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

-- Don't load netrw because we use nvim-tree
vim.g.load_netrw = 1
vim.g.load_netrwPlugin = 1

-- Searching
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- vim.g.barbar_auto_setup = false

-- nvim-cmp height popup
set.pumheight = 15

vim.o.splitright = true
