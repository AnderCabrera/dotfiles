return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c", "vim", "vimdoc", "query", "javascript", "typescript", "lua", "html" },
        highlight = { enable = true, disable = { "" }, additional_vim_regex_highlighting = true },
        indent = { enable = true },
      })
    end,
  },
}
