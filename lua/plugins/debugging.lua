return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        opts = {
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
                "repl",
              },
              size = 0.3,
              position = "bottom",
            },
          },
          controls = {
            enabled = false,
          },
        },
      },
    },

    keys = {
      { "<F5>",       function() require("dap").continue() end,                                                  desc = "Continue" },
      { "<F7>",       function() require("dap").step_into() end,                                                 desc = "Step Into" },
      { "<F8>",       function() require("dap").step_over() end,                                                 desc = "Step Over" },
      { "<F9>",       function() require("dap").step_out() end,                                                  desc = "Step Out" },
      { "<F10>",      function() require("dap").run_to_cursor() end,                                             desc = "Run to Cursor" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,      desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                         desc = "Toggle Breakpoint" },
      { "<leader>dj", function() require("dap").down() end,                                                      desc = "Down" },
      { "<leader>dk", function() require("dap").up() end,                                                        desc = "Up" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                          desc = "Widgets" },
      { "<leader>dt", function() require("dap").terminate() end,                                                 desc = "Terminate" },
      { "<leader>ds", function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes) end, desc = "Scope" },
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = dapui.open
      dap.listeners.before.launch.dapui_config = dapui.open
      dap.listeners.before.event_terminated.dapui_config = dapui.close
      dap.listeners.before.event_exited.dapui_config = dapui.close

      ---@format disable-next
      vim.fn.sign_define("DapStopped", { text = " ", texthl = "DiagnosticWarn", linehl = "DapStoppedLine", numhl = "DapStoppedLine" })
      vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "DiagnosticInfo" })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "dap-float" },
        callback = function(event)
          vim.keymap.set("n", "<Tab>", "<Nop>", { buffer = event.buf, silent = true })
          vim.keymap.set("n", "<S-Tab>", "<Nop>", { buffer = event.buf, silent = true })
        end,
      })

      -- rerun last config
      local last_config = {}
      dap.listeners.after.event_initialized["last_config"] = function(session)
        last_config = session.config
      end

      local function run_last()
        if last_config then
          dap.run(last_config)
        else
          dap.continue()
        end
      end

      vim.keymap.set('n', '<Leader>dl', function() run_last() end, { desc = "Run last config" })
    end,
  },
}
