return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "folke/neodev.nvim",
  },

  config = function()
    -- neodev
    require("neodev").setup({})

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),

      callback = function(event)
        -- Mappings
        local map = function(m, l, r, desc, opts)
          opts = opts or { buffer = event.buffer, noremap = true, silent = true }
          desc = desc or nil
          opts.desc = desc
          vim.keymap.set(m, l, r, opts)
        end

        map("n", "gD", vim.lsp.buf.declaration, "go declaration")
        map("n", "gd", vim.lsp.buf.definition, "go definition new buffer")
        map("n", "vgd", function()
          -- open as vertical split
          vim.cmd("vsp | lua vim.lsp.buf.definition()")
          -- open as tabnew
          -- vim.cmd("tab split | lua vim.lsp.buf.definition()")
        end, "go definition vertical window")
        map("n", "gr", vim.lsp.buf.references, "references")
        map("n", "K", vim.lsp.buf.hover, "hover")
        map("n", "gi", vim.lsp.buf.implementation, "go implementation")
        map("n", "<space>k", vim.lsp.buf.signature_help, "signature help")
        map("n", "<space>ca", vim.lsp.buf.code_action, "code action")
        map("n", "<space>rn", vim.lsp.buf.rename, "rename")
        map("n", "<space>rl", vim.lsp.codelens.run, "run codelens")
        map("n", "<space>cr", vim.lsp.codelens.refresh, "refresh codelens")
        map("n", "<space>e", vim.diagnostic.open_float, "open diagnostics")
        map("n", "[d", vim.diagnostic.goto_prev, "diagnostics prev")
        map("n", "]d", vim.diagnostic.goto_next, "diagnostics next")
        map("n", "<space>cl", vim.diagnostic.setqflist, "diagnostics quicklist")
        map("n", "<space>f", vim.lsp.buf.format, "format")
        map("n", "<leader>uh", function()
          if vim.lsp.inlay_hint.is_enabled() then
            vim.lsp.inlay_hint.enable(false)
          else
            vim.lsp.inlay_hint.enable(true, { 0 })
          end
        end, "toggle inlay hints")

        -- stylua: ignore start
        map("n", "<space>ds", function() require("telescope.builtin").lsp_document_symbols() end, "document symbols")
        map("n", "<space>ws", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
          "workspace symbols")
        -- stylua: ignore end

        -- lesser used lsp functionality
        map("n", "<space>D", vim.lsp.buf.type_definition, "type definition")
        map("n", "<space>wa", vim.lsp.buf.add_workspace_folder, "add workspace folder")
        map("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, "remove workspace folder")
        map("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "list workspace folders")
      end,
    })

    -- Signs
    local function callSigns()
      local signs = {
        Error = "",
        Warn = "",
        Hint = "󰌶",
      }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end

    callSigns()

    local lspconf = require("lspconfig")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    lspconf.html.setup({
      capabilities = capabilities,
    })

    lspconf.emmet_language_server.setup({})

    lspconf.tsserver.setup({
      cmd = { "typescript-language-server", "--stdio" },
      name = "tsserver",
      root_dir = lspconf.util.root_pattern("package.json"),
      capabilities = capabilities,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
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
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      }
    })

    lspconf.lua_ls.setup({
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
          hint = {
            enable = true,
          },
        },
      },
    })

    local project_library_path = vim.fn.getcwd() .. "/bin"
    local cmd = {
      "ngserver",
      "--stdio",
      "--tsProbeLocations",
      project_library_path,
      "--ngProbeLocations",
      project_library_path,
    }
    lspconf.angularls.setup({
      cmd = cmd,
      on_new_config = function(new_config)
        new_config.cmd = cmd
      end,
      capabilities = capabilities,
    })

    lspconf.jsonls.setup({
      -- cmd = { "vscode-json-languageserver", "--stdio" },
      filetypes = { "json" },
      -- root_dir = lspconf.util.root_pattern(".git"),
    })

    lspconf.clangd.setup({
      cmd = { "clangd", "--background-index", "--offset-encoding=utf-16" },
      filetypes = { "c", "cpp" },
      clangd = {
        InlayHints = {
          Designators = true,
          Enabled = true,
          ParameterNames = true,
          DeducedTypes = true,
        },
        fallbackFlags = { "-std=c++20" },
      },
    })

    lspconf.tailwindcss.setup({
      cmd = { "tailwindcss-language-server", "--stdio" },
      root_dir = lspconf.util.root_pattern("tailwind.config.js"),
    })

    lspconf.pyright.setup({
      cmd = { "pyright-langserver", "--stdio" },
      filetypes = { "python" },
      root_dir = lspconf.util.root_pattern(".git"),
    })

    lspconf.arduino_language_server.setup({
      cmd = { "arduino-language-server", "--stdio" },
      filetypes = { "ino" },
      root_dir = lspconf.util.root_pattern(".git"),
    })

    lspconf.jdtls.setup({
      cmd = { "jdtls" },
      settings = {
        java = {
          inlayHints = {
            parameterNames = {
              enabled = "all",
              exclusions = { "this" },
            },
          },
        }
      }
    })

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "tsserver", "lua_ls", "clangd" },
    })
  end,
}
