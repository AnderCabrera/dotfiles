vim.lsp.enable({
  "lua_ls",
  "ts_ls",
  "jsonls",
  "bashls"
})

-- Diagnostic display configuration
vim.diagnostic.config({
  -- virtual_lines = true,
  virtual_text = {
    spacing = 4,
    prefix = "●",
    severity = { min = vim.diagnostic.severity.WARN },
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
      [vim.diagnostic.severity.HINT] = "DiagnosticHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
    }
  },
  severity_sort = true,
  float = { border = "rounded" },
})

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
    map('n', '<leader>lh', vim.lsp.buf.signature_help, 'signature help')
    map('n', '<leader>ac', vim.lsp.buf.code_action, 'code action')
    map('n', '<leader>rn', vim.lsp.buf.rename, 'rename')
    map('n', '<leader>rl', vim.lsp.codelens.run, 'run codelens')
    map('n', '<leader>rc', vim.lsp.codelens.refresh, 'refresh codelens')
    map('n', '<space>e', vim.diagnostic.open_float, 'open diagnostics')
    map('n', '[d', vim.diagnostic.goto_prev, 'diagnostics prev')
    map('n', ']d', vim.diagnostic.goto_next, 'diagnostics next')
    map('n', '<leader>f', vim.lsp.buf.format, 'format')
    map('n', '<leader>uh', function()
      if vim.lsp.inlay_hint.is_enabled() then
        vim.lsp.inlay_hint.enable(false)
      else
        vim.lsp.inlay_hint.enable(true, { 0 })
      end
    end, 'toggle inlay hints')



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
