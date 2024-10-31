return { -- Autoformat
  "stevearc/conform.nvim",
  lazy = false,
  keys = {
    {
      "<M-S-f>",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = false,
    -- format_on_save = function(bufnr)
    -- 	-- Disable "format_on_save lsp_fallback" for languages that don't
    -- 	-- have a well standardized coding style. You can add additional
    -- 	-- languages here or re-enable it for the disabled ones.
    -- 	local disable_filetypes = { c = true, cpp = true }
    -- 	return {
    -- 		timeout_ms = 500,
    -- 		lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
    -- 	}
    -- end,
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "autopep8", "isort", "black" },
      javascript = { "prettier", stop_after_first = true },
      typescript = { "prettier", stop_after_first = true },
      javascriptreact = { "prettier", stop_after_first = true },
      typescriptreact = { "prettier", stop_after_first = true },
      html = { "prettier", stop_after_first = true },
      css = { "prettier", stop_after_first = true },
      scss = { "prettier", stop_after_first = true },
      json = { "prettier", stop_after_first = true },
      yaml = { "prettier", stop_after_first = true },
      -- rust = { "rustfmt" },
      -- go = { "gofmt", "goimports" },
      -- sh = { "shfmt" },
    },
  },
}
