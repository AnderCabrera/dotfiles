return {
  'norcalli/nvim-colorizer.lua',
  init = function() vim.opt.termguicolors = true end,
  config = function()
    require('colorizer').setup()

    -- Detach colorizer from lazy plugin manager buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "lazy",
      callback = function()
        vim.cmd("ColorizerDetachFromBuffer")
      end,
    })
  end,
}
