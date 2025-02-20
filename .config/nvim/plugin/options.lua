-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Decrease update time
-- vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- vim.opt.timeoutlen = 1000

-- Save undo history
vim.opt.undofile = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Indentation
vim.opt.smartindent = true

-- Tabs
-- vim.opt.tabstop = 2
-- vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.encoding = 'UTF-8'
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- dark mode to ayu
vim.g.ayucolor = 'dark'

-- no show mode
vim.opt.showmode = false

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Don't wrap text
vim.opt.wrap = false

-- Vertical markers
vim.opt.signcolumn = 'yes'
vim.opt.colorcolumn = '80'

-- Don't load netrw because we use nvim-tree
vim.g.load_netrw = 1
vim.g.load_netrwPlugin = 1

-- Searching
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- nvim-cmp height popup
vim.opt.pumheight = 15

vim.o.splitright = true
