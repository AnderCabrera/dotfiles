return {
  "theprimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- require("harpoon"):setup()

    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
  end,
  -- keys = {
  --   { "<leader>A", function() require("harpoon"):list():add() end,     desc = "harpoon file", },
  --   {
  --     "<leader>a",
  --     function()
  --       local harpoon = require("harpoon")
  --       harpoon.ui:toggle_quick_menu(harpoon:list())
  --     end,
  --     desc = "harpoon quick menu",
  --   },
  --   { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1", },
  --   { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2", },
  --   { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3", },
  --   { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4", },
  --   { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5", },
  -- },
}
