return {
  "nvim-tree/nvim-web-devicons",
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  {
    "kdheepak/lazygit.nvim",
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },
}
