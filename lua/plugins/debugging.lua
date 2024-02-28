return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
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
        -- stylua: ignore
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({}) end
          dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close({}) end
          dap.listeners.before.event_exited["dapui_config"] = function() dapui.close({}) end
        end,
      },

      -- which key integration
      {
        "folke/which-key.nvim",
        optional = true,
        opts = {
          defaults = {
            ["<leader>d"] = { name = "+debug" },
          },
        },
      },
    },

    keys = {
      -- stylua: ignore start
      { "<F5>", function() require("dap").continue() end, desc = "Continue" },
      { "<F7>", function() require("dap").step_into() end, desc = "Step Into" },
      { "<F8>", function() require("dap").step_over() end, desc = "Step Over" },
      { "<F9>", function() require("dap").step_out() end, desc = "Step Out" },
      { "<F10>", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>de", function() require("dapui").float_element(nil, {enter = true}) end, desc = "Open Element" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      -- stylua: ignore end
      {
        "<leader>dt",
        function()
          require("dapui").close()
          require("dap").repl.close()
          local session = require("dap").session()
          if session then
            require("dap").terminate()
          end
        end,
        desc = "Terminate",
      },
      {
        "<leader>do",
        function()
          local session = require("dap").session()
          local command = "source /usr/local/OpenImageDebugger/oid.py"
          session:evaluate(command, function(err)
            if err then
              require("dap.repl").append(err.message)
              return
            end
          end)
          require("dap.repl").append(command)
        end,
        desc = "OpenImageDebugger",
      },

      {
        "<leader>ds",
        function()
          local widgets = require("dap.ui.widgets")
          widgets.centered_float(widgets.scopes)
        end,
        desc = "Scope",
      },
    },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "dap-float" },
        callback = function(event)
          vim.keymap.set("n", "<Tab>", "", { buffer = event.buf, silent = true })
          vim.keymap.set("n", "<S-Tab>", "", { buffer = event.buf, silent = true })
        end,
      })

      require("dap").listeners.after.event_initialized["dapui_config"] = function()
        require("dapui").open()
      end

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      local config = require("config")
      for name, sign in pairs(config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        -- stylua: ignore
      vim.fn.sign_define("Dap" .. name, { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] })
      end
    end,
  },
}
