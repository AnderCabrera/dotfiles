return {
  {
    "rmagatti/auto-session",
    dependencies = {
      "nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
    },
    config = function()
      require("auto-session").setup({
        enabled = false,                             -- Enables/disables auto creating, saving and restoring
        root_dir = vim.fn.stdpath "data" .. "/sessions/", -- Root dir where sessions will be stored
        auto_save = true,                            -- Enables/disables auto saving session on exit
        auto_restore = true,                         -- Enables/disables auto restoring session on start
        auto_create = true,                          -- Enables/disables auto creating new session files. Can take a function that should return true/false if a new session file should be created or not
        suppressed_dirs = nil,                       -- Suppress session restore/create in certain directories
        allowed_dirs = nil,                          -- Allow session restore/create in certain directories
      })
    end,
  },
}
