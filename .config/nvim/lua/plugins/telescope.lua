return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    vim.keymap.set("n", "<leader>h", builtin.colorscheme, {})
    vim.keymap.set("n", "<leader>ms", require("auto-session.session-lens").search_session)

    vim.keymap.set('n', '<leader>pws', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end)
    vim.keymap.set('n', '<leader>pWs', function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end)
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)

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
