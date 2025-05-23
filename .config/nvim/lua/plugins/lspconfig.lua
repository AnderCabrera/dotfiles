return {
  'neovim/nvim-lspconfig',

  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'folke/neodev.nvim',
  },

  config = function()
    -- neodev
    require('neodev').setup {}

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),

      callback = function(event)
        -- Mappings
        local map = function(m, l, r, desc, opts)
          opts = opts or { buffer = event.buffer, noremap = true, silent = true }
          desc = desc or nil
          opts.desc = desc
          vim.keymap.set(m, l, r, opts)
        end

        map('n', 'gD', vim.lsp.buf.declaration, 'go declaration')
        map('n', 'gd', vim.lsp.buf.definition, 'go definition new buffer')
        map('n', 'vgd', function()
          -- open as vertical split
          vim.cmd 'vsp | lua vim.lsp.buf.definition()'
          -- open as tabnew
          -- vim.cmd("tab split | lua vim.lsp.buf.definition()")
        end, 'go definition vertical window')
        map('n', 'gr', vim.lsp.buf.references, 'references')
        map('n', 'K', vim.lsp.buf.hover, 'hover')
        map('n', 'gi', vim.lsp.buf.implementation, 'go implementation')
        map('n', '<leader>k', vim.lsp.buf.signature_help, 'signature help')
        map('n', '<leader>ac', vim.lsp.buf.code_action, 'code action')
        map('n', '<leader>rn', vim.lsp.buf.rename, 'rename')
        map('n', '<leader>rl', vim.lsp.codelens.run, 'run codelens')
        map('n', '<leader>rc', vim.lsp.codelens.refresh, 'refresh codelens')
        map('n', '<leader>e', vim.diagnostic.open_float, 'open diagnostics')
        map('n', '[d', vim.diagnostic.goto_prev, 'diagnostics prev')
        map('n', ']d', vim.diagnostic.goto_next, 'diagnostics next')
        map('n', '<leader>lc', vim.diagnostic.setqflist, 'diagnostics quicklist')
        map('n', '<leader>f', vim.lsp.buf.format, 'format')
        map('n', '<leader>uh', function()
          if vim.lsp.inlay_hint.is_enabled() then
            vim.lsp.inlay_hint.enable(false)
          else
            vim.lsp.inlay_hint.enable(true, { 0 })
          end
        end, 'toggle inlay hints')

        -- stylua: ignore start
        map("n", "<leader>ds", function() require("telescope.builtin").lsp_document_symbols() end, "document symbols")
        map("n", "<leader>ws", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
          "workleader symbols")
        -- stylua: ignore end

        -- lesser used lsp functionality
        map('n', '<leader>D', vim.lsp.buf.type_definition, 'type definition')
        map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, 'add workspace folder')
        map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, 'remove workspace folder')
        map('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
        end, 'list workspace folders')

        -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
          if vim.fn.has 'nvim-0.11' == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end


        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end
      end,
    })

    -- vim.diagnostic.config({
    --   signs = {
    --     text = {
    --       [vim.diagnostic.severity.ERROR] = '',
    --       [vim.diagnostic.severity.WARN] = '',
    --       [vim.diagnostic.severity.INFO] = '',
    --       [vim.diagnostic.severity.HINT] = '',
    --     },
    --     numhl = {
    --       [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
    --       [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
    --       [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
    --       [vim.diagnostic.severity.HINT] = 'DiagnosticHint',

    --     },
    --   },
    -- })

    -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    --   vim.lsp.diagnostic.on_publish_diagnostics, {
    --     virtual_text = false
    --   }
    -- )

    -- Signs
    local function callSigns()
      local signs = {
        Error = '',
        Warn = '',
        Hint = '󰌶',
      }

      for type, icon in pairs(signs) do
        local hl = 'DiagnosticSign' .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end

    -- callSigns()

    local lspconf = require 'lspconfig'
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    lspconf.html.setup {
      capabilities = capabilities,
    }

    lspconf.emmet_language_server.setup {}

    lspconf.ts_ls.setup {
      cmd = { 'typescript-language-server', '--stdio' },
      name = 'tsserver',
      root_dir = lspconf.util.root_pattern 'package.json',
      capabilities = capabilities,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    }

    lspconf.lua_ls.setup {
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          hint = {
            enable = true,
          },
        },
      },
    }

    local default_node_modules = vim.fn.getcwd() .. '/node_modules'

    local ngls_cmd = {
      'ngserver',
      '--stdio',
      '--tsProbeLocations',
      default_node_modules,
      '--ngProbeLocations',
      default_node_modules,
    }

    -- lspconf.angularls.setup({
    --   cmd = ngls_cmd,
    --   filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
    --   root_dir = lspconf.util.root_pattern("angular.json", "tsconfig.json"),
    --   on_new_config = function(new_config)
    --     new_config.cmd = ngls_cmd
    --   end,
    -- })

    lspconf.jsonls.setup {
      -- cmd = { "vscode-json-languageserver", "--stdio" },
      filetypes = { 'json' },
      -- root_dir = lspconf.util.root_pattern(".git"),
    }

    lspconf.clangd.setup {
      cmd = { 'clangd', '--background-index', '--offset-encoding=utf-16' },
      filetypes = { 'c', 'cpp' },
      -- clangd = {
      --   InlayHints = {
      --     Designators = true,
      --     Enabled = true,
      --     ParameterNames = true,
      --     DeducedTypes = true,
      --   },
      --   fallbackFlags = { '-std=c++20' },
      -- },
    }

    lspconf.tailwindcss.setup {
      cmd = { 'tailwindcss-language-server', '--stdio' },
      root_dir = lspconf.util.root_pattern 'tailwind.config.js',
    }

    lspconf.pyright.setup {
      cmd = { 'pyright-langserver', '--stdio' },
      filetypes = { 'python' },
      root_dir = lspconf.util.root_pattern '.git',
    }

    lspconf.arduino_language_server.setup {
      cmd = { 'arduino-language-server', '--stdio' },
      filetypes = { 'ino' },
      root_dir = lspconf.util.root_pattern '.git',
    }

    lspconf.jdtls.setup {
      cmd = { 'jdtls' },
      settings = {
        java = {
          inlayHints = {
            parameterNames = {
              enabled = 'all',
              exclusions = { 'this' },
            },
          },
        },
      },
    }

    lspconf.intelephense.setup {
      cmd = { 'intelephense', '--stdio' },
      filetypes = { 'php' },
      root_dir = lspconf.util.root_pattern('composer.json', '.git'),
    }

    lspconf.sqls.setup {
      on_attach = function(client, bufnr)
        require('sqls').on_attach(client, bufnr)
      end,
    }

    lspconf.prismals.setup {}

    require('mason').setup()
    require('mason-lspconfig').setup {
      ensure_installed = { 'ts_ls', 'lua_ls', 'clangd' },
    }
  end,
}
