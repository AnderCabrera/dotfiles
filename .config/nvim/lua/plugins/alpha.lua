return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- require("alpha").setup(require("alpha.themes.startify").config)
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "                                           ",
      "                                           ",
      "                                           ",
      "                                           ",
      "                                           ",
      "                                           ",
      "                                           ",
      "                                           ",
      "                                           ",
      "                                           ",
      "                                           ",
      "                                           ",
      "                _       _     _            ",
      "               | |     | |   | |           ",
      "  __ _ _ __ ___| |__   | |__ | |___      __",
      " / _` | '__/ __| '_ \\  | '_ \\| __\\ \\ /\\ / /",
      "| (_| | | | (__| | | | | |_) | |_ \\ V  V / ",
      " \\__,_|_|  \\___|_| |_| |_.__/ \\__| \\_/\\_/  ",
      "                                           ",
      "                                           "
    }

    dashboard.section.header.opts.hl = "Normal"

    dashboard.section.buttons.val = {
      dashboard.button("i", "  New file", ":enew <cr>"),
      dashboard.button("f", "  Find file", ":Telescope find_files<cr>"),
      dashboard.button("r", "  Recent", ":Telescope oldfiles<cr>"),
      dashboard.button("u", "  Update Plugins", ":Lazy update<cr>"),
      dashboard.button("s", "  Settings", ":e $MYVIMRC | :cd %:p:h<cr>"),
      dashboard.button("q", "󰈆  Quit NVIM", ":qa<cr>"),
    }

    dashboard.section.buttons.opts.spacing = 0

    dashboard.section.footer.val = require("alpha.fortune")()
    dashboard.section.footer.opts.hl = "SpecialKey"

    alpha.setup(dashboard.opts)
  end,
}
