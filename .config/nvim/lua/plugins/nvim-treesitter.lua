return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,

  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
  },

  init = function()
    local ensure_installed = {
      'c',
      'vim',
      'vimdoc',
      'query',
      'javascript',
      'typescript',
      'lua',
      'html',
      'json'
    }

    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        pcall(vim.treesitter.start)

        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    local alreadyInstalled = require('nvim-treesitter.config').get_installed()
    local parsersToInstall = vim.iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(alreadyInstalled, parser)
        end)
        :totable()
    require('nvim-treesitter').install(parsersToInstall)
  end,

  config = function()
    require('treesitter-context').setup {
      enable = true,
      multiwindow = false,
      max_lines = 0,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = 'outer',
      mode = 'cursor',
      separator = nil,
      zindex = 20,
      on_attach = nil,
    }

    vim.keymap.set("n", "[f", function()
      require("treesitter-context").go_to_context(vim.v.count1)
    end, { silent = true })
  end,
}
