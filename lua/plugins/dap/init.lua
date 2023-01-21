
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "dap-float" },
  callback = function(event)
    vim.keymap.set("n", "<Tab>", "", { buffer = event.buf, silent = true })
    vim.keymap.set("n", "<S-Tab>", "", { buffer = event.buf, silent = true })
  end,
})

local M = {
  "mfussenegger/nvim-dap",
  branch = "master",

  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup({
          layouts = {
            {
              elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.4 },
                "breakpoints",
                "stacks",
                "watches",
              },
              size = 50, -- 40 columns
              position = "left",
            },
            {
              elements = {
                "console",
              },
              size = 0.3,
              position = "bottom",
            },
          },
          controls = {
            enabled = false,
          },
        })
      end,
    },
    { "theHamsta/nvim-dap-virtual-text", config = true },
  },
}

function M.init()
  vim.keymap.set("n", "<F5>", function() require("dap").continue() end, { desc = "Continue Debug" })
  vim.keymap.set("n", "<F7>", function() require("dap").step_into() end, { desc = "Step Into" })
  vim.keymap.set("n", "<F8>", function() require("dap").step_over() end, { desc = "Step Over" })
  vim.keymap.set("n", "<F9>", function() require("dap").step_out() end, { desc = "Step Out" })
  vim.keymap.set("n", "<F10>", function() require("dap").run_to_cursor() end, { desc = "Run to cursor" })
  vim.keymap.set("n", "<leader>dt", function() require("dap").terminate() end, { desc = "Terminate Debug" })
  vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Run Last" })
  vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
  vim.keymap.set("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: '))  end, { desc = "Set Breakpoint" })
  vim.keymap.set("n", "<leader>dr", function() require("dap").repl.toggle() end, { desc = "Repl" })
  vim.keymap.set("n", "<leader>du", function() require("dapui").toggle({}) end, { desc = "UI" })

  vim.keymap.set("n", "<leader>ds", function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
  end, { desc = "Scope" })

  vim.keymap.set("n", "<leader>dh", function()
  local widgets = require('dap.ui.widgets')
  widgets.hover()
  end, { desc = "Hover" })
end

function M.config()
  local dap = require("dap")
  local dapui = require("dapui")

  require("plugins.dap.cpp")
  require("plugins.dap.python")

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
    dap.repl.close()
  end
  dap.listeners.before.disconnect["dapui_config"] = function()
    dapui.close()
    dap.repl.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
    dap.repl.close()
  end
end

return M
