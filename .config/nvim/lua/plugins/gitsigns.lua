return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },

      current_line_blame = true, -- Activar el blame en línea
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- Mostrar el blame al final de la línea
        delay = 0,         -- Retraso en ms antes de mostrar el blame
        ignore_whitespace = false,
      },
    })
  end,
}
