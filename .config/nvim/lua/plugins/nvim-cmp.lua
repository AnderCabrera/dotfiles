---@diagnostic disable: missing-fields
return {
  "hrsh7th/cmp-nvim-lsp",

  event = "InsertEnter",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp-signature-help",

    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",

    -- icons (optional!)
    "onsails/lspkind.nvim",
  },

  config = function()
    local cmp = require("cmp")
    local kind_icons = {
      Text = "",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "󰇽",
      Variable = "󰂡",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰅲",
    }

    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
          -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
        end,
      },

      window = {
        completion = cmp.config.window,
        documentation = cmp.config.window,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "vsnip" }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
        { name = "nvim_lsp_signature_help" }
      }, {
        { name = "buffer" },
      }),

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      }),

      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          -- Customization for Pmenu
          vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
          vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })
          -- gray
          vim.api.nvim_set_hl(
            0,
            "CmpItemAbbrDeprecated",
            { bg = "NONE", strikethrough = true, fg = "#808080" }
          )
          -- blue
          vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { bg = "NONE", fg = "#569CD6" })
          vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" })
          -- light blue
          vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "#9CDCFE" })
          vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
          vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
          -- pink
          vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "#C586C0" })
          vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
          -- front
          vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "#D4D4D4" })
          vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
          vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })

          local lspkind_ok, lspkind = pcall(require, "lspkind")

          if not lspkind_ok then
            local icon = kind_icons[vim_item.kind]

            vim_item.menu = vim_item.kind
            vim_item.kind = (icon or "")

            -- Source
            -- vim_item.menu = ({
            -- 	buffer = "[Buffer]",
            -- 	nvim_lsp = "[LSP]",
            -- 	luasnip = "[LuaSnip]",
            -- 	nvim_lua = "[Lua]",
            -- 	latex_symbols = "[LaTeX]",
            -- })[entry.source.name]

            return vim_item
          else
            -- From lspkind
            local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"

            return kind
          end
        end,
      },
    })

    -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
    -- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
    -- require("lspconfig")["html"].setup({
    -- 	capabilities = capabilities,
    -- })
  end,
}
