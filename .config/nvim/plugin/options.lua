local set = vim.opt

set.number = true
set.relativenumber = true
set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.encoding = "UTF-8"
set.mouse = "a"
set.clipboard = "unnamedplus"
-- optionally enable 24-bit colour
set.termguicolors = true
-- no show mode
set.showmode = false

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

