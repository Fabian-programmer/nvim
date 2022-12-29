local M = {
  "mfussenegger/nvim-dap",

  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end,
    },
    { "theHamsta/nvim-dap-virtual-text", config = true },
  },
}

function M.init()
  vim.keymap.set("n", "<F5>", function()
    require("dap").continue()
  end, { desc = "Continue Debug" })

  vim.keymap.set("n", "<F6>", function()
    require("dap").terminate()
  end, { desc = "Terminate Debug" })

  vim.keymap.set("n", "<F7>", function()
    require("dap").step_into()
  end, { desc = "Step Into" })

  vim.keymap.set("n", "<F8>", function()
    require("dap").step_over()
  end, { desc = "Step Over" })

  vim.keymap.set("n", "<F9>", function()
    require("dap").step_out()
  end, { desc = "Step Out" })

  vim.keymap.set("n", "<F10>", function()
    require("dap").toggle_breakpoint()
  end, { desc = "Toggle Breakpoint" })

  vim.keymap.set("n", "<F11>", function()
    require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: '))
  end, { desc = "Set Breakpoint" })

  vim.keymap.set("n", "<leader>dr", function()
    require("dap").repl.open()
  end, { desc = "Repl" })

  vim.keymap.set("n", "<leader>du", function()
    require("dapui").toggle({})
  end, { desc = "Dap UI" })
end

function M.config()
  local dap = require("dap")
  local dapui = require("dapui")

  require("config.plugins.dap.cpp")
  require("config.plugins.dap.python")

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
    dap.repl.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
    dap.repl.close()
  end
end

return M
