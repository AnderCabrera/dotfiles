return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.6',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch [G]rep' })
    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>st', builtin.colorscheme, { desc = '[S]earch [T]heme' })

    vim.keymap.set('n', '<leader>pws', function()
      local word = vim.fn.expand '<cword>'
      builtin.grep_string { search = word }
    end)
    vim.keymap.set('n', '<leader>pWs', function()
      local word = vim.fn.expand '<cWORD>'
      builtin.grep_string { search = word }
    end)
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string { search = vim.fn.input 'Grep > ' }
    end)

    require('telescope').setup {
      defaults = {
        file_ignore_patterns = { '%.git/', 'node_modules/', '%.cache/' },
        prompt_prefix = '❯ ',
        selection_caret = '❯ ',
      },
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
    }
  end,
}
