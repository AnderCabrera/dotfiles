return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = { "%.git/", "node_modules/", "%.cache/" },
        prompt_prefix = "❯ ",
        selection_caret = "❯ ",
      },
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      }
    })
  end,
}
