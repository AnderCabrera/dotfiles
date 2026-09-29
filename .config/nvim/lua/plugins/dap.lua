return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "nvim-telescope/telescope-dap.nvim",
      "Weissle/persistent-breakpoints.nvim"
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup()
      require("dap-go").setup()
      require("nvim-dap-virtual-text").setup {
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
            return "*****"
          end
          if #variable.value > 15 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
          end
          return " " .. variable.value
        end,
      }

      -- CONFIGURAR BREAKPOINTS PERSISTENTES
      require('persistent-breakpoints').setup({
        save_dir = vim.fn.stdpath('data') .. '/nvim_checkpoints',
        load_breakpoints_event = { "BufReadPost" },
        -- Guardar automáticamente cuando se modifican
        on_load = true,
      })

      require('telescope').load_extension('dap')

      -- Configuración para JS/TS (js-debug-adapter)
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = { "${port}" },
        }
      }

      -- Configuraciones para JavaScript/TypeScript
      for _, language in ipairs({ "typescript", "javascript" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
          -- NestJS en modo desarrollo
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug NestJS (dev)",
            runtimeExecutable = "npm",
            runtimeArgs = {
              "run",
              "start:dev",
            },
            skipFiles = { "<node_internals>/**" },
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
          },
          -- NestJS en modo debug
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug NestJS (debug mode)",
            runtimeExecutable = "npm",
            runtimeArgs = {
              "run",
              "start:debug",
            },
            restart = true,
            console = "integratedTerminal",
            skipFiles = { "<node_internals>/**" },
            cwd = "${workspaceFolder}",
          },
          -- Attach a proceso NestJS corriendo
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to NestJS",
            port = 9229,
            restart = true,
            skipFiles = { "<node_internals>/**" },
            cwd = "${workspaceFolder}",
          },
          -- Debug tests de Jest
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Tests",
            runtimeExecutable = "node",
            runtimeArgs = {
              "./node_modules/jest/bin/jest.js",
              "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
          -- Debug test específico
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Current Jest Test",
            runtimeExecutable = "node",
            runtimeArgs = {
              "./node_modules/jest/bin/jest.js",
              "--runInBand",
              "${file}",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
        }
      end

      -- Keymaps
      local pb_api = require('persistent-breakpoints.api')

      vim.keymap.set("n", "<leader>b", pb_api.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>B", function()
        pb_api.set_conditional_breakpoint()
      end, { desc = "Conditional Breakpoint" })
      vim.keymap.set("n", "<leader>db", pb_api.clear_all_breakpoints, { desc = "Clear All Breakpoints" })

      vim.keymap.set("n", "<leader>gb", dap.run_to_cursor, { desc = "Run to Cursor" })
      vim.keymap.set("n", "<leader>?", function()
        require("dapui").eval(nil, { enter = true })
      end)

      vim.keymap.set("n", "<F1>", dap.continue)
      vim.keymap.set("n", "<F2>", dap.step_into)
      vim.keymap.set("n", "<F3>", dap.step_over)
      vim.keymap.set("n", "<F4>", dap.step_out)
      vim.keymap.set("n", "<F5>", dap.step_back)
      vim.keymap.set("n", "<F13>", dap.restart)

      -- Telescope DAP keymaps
      vim.keymap.set("n", "<leafer>fc", "<cmd>Telescope dap configurations<cr>", { desc = "Select Config" })
      vim.keymap.set("n", "<leader>fbb", "<cmd>Telescope dap list_breakpoints<cr>", { desc = "List Breakpoints" })
      vim.keymap.set("n", "<leader>fbv", "<cmd>Telescope dap variables<cr>", { desc = "Variables" })
      vim.keymap.set("n", "<leader>fbf", "<cmd>Telescope dap frames<cr>", { desc = "Frames" })

      -- DAP UI keymaps
      vim.keymap.set("n", "<leader>du", function()
        require("dapui").toggle()
      end, { desc = "Toggle Debug UI" })

      -- Listeners para dapui
      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
