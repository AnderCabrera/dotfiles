return {
  {
    'xiyaowong/transparent.nvim',
    config = function()
      local transparent = require('transparent')

      transparent.setup({
        extra_groups = {
          "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
          "TelescopeBorder",
          "MiniFilesBorder",
          "BlinkCmpMenuBorder",
        },
      })

      transparent.clear_prefix("NeoTree")
    end
  },
  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup {
        style = 'darker',
        transparent = false,
      }
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      local rosepine = require 'rose-pine'

      rosepine.setup {
        variant = 'auto',      -- auto, main, moon, or dawn
        dark_variant = 'main', -- main, moon, or dawn
        dim_inactive_windows = true,
        extend_background_behind_borders = true,

        enable = {
          terminal = false,
          legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
          migrations = true,         -- Handle deprecated options automatically
        },

        styles = {
          bold = true,
          italic = false,
          transparency = true,
        },
      }
    end,
  },
  {
    'uloco/bluloco.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      -- your optional config goes here, see below.
    end,
  },
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('kanso').setup({
        compile = false,  -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = {},
        typeStyle = {},
        disableItalics = false,
        transparent = false,   -- do not set background color
        dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {             -- add/modify theme and palette colors
          palette = {},
          theme = { zen = {}, pearl = {}, ink = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = "zen",  -- Load "zen" theme
        background = {  -- map the value of 'background' option to a theme
          dark = "zen", -- try "ink" !
          light = "pearl"
        },
      })
    end
  },
  'folke/tokyonight.nvim',
  'shaunsingh/nord.nvim',
  'Mofiqul/vscode.nvim',
  'marko-cerovac/material.nvim',
  'ayu-theme/ayu-vim',
  'rebelot/kanagawa.nvim',
}
