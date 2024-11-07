return {
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({
        style = "darker",
        transparent = false,
      })
    end
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      local rosepine = require("rose-pine")

      rosepine.setup({
        variant = "auto",      -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
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
          transparency = false,
        },
      })
    end
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
  "folke/tokyonight.nvim",
  "ellisonleao/gruvbox.nvim",
  "shaunsingh/nord.nvim",
  "Mofiqul/vscode.nvim",
  "marko-cerovac/material.nvim",
  "ayu-theme/ayu-vim",
  "rebelot/kanagawa.nvim"
}
