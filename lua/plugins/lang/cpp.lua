return {
  -- language server
  {
    "mason-org/mason-lspconfig.nvim",
    opts = { ensure_installed = { "clangd" } },
  },

  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "c", "cpp" } },
  },

  -- debugger
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      local util = require("util.dap")
      dap.adapters.gdb = { type = "executable", command = "gdb", args = { "-i", "dap" } }

      -- configuration --
      local cpp_launch = {
        name = "Launch Executable",
        type = "gdb",
        request = "launch",
        program = function()
          return util.pick_executable()
        end,
        args = function()
          return util.get_args({ prompt = "Arguments: " })
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = true,
      }

      local cpp_attach = {
        name = "Attach to process",
        type = "gdb",
        request = "attach",
        pid = require("dap.utils").pick_process,
      }

      local last_config = {}

      local cpp_last_config = setmetatable({
        name = "Last Config",
        type = "gdb",
        request = "launch",
      }, {
        __call = function()
          return last_config
        end,
      })

      dap.configurations["cpp"] = {
        cpp_launch,
        cpp_attach,
        cpp_last_config,
      }

      dap.listeners.after.event_initialized["last_config"] = function()
        last_config = require("dap").session()["config"]
      end
    end,
  },
}
