return {
  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "c", "cpp" })
      end
    end,
  },

  -- lsp includes formatter
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Ensure mason installs the server
        clangd = {
          keys = {
            { "<F4>", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
          },
          root_pattern = ".git",
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=never",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
        },
      },
    },
  },

  -- debugger
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      -- Ensure C/C++ debugger is installed
      "williamboman/mason.nvim",
      optional = true,
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, { "cpptools" })
        end
      end,
    },
    opts = function()
      local dap = require("dap")

      -- adapter --
      local path = require("mason-registry").get_package("cpptools"):get_install_path()
      if not dap.adapters["cppdbg"] then
        require("dap").adapters["cppdbg"] = {
          id = "cppdbg",
          type = "executable",
          command = path .. "/extension/debugAdapters/bin/OpenDebugAD7",
        }
      end

      -- configuration --
      local cpp_launch = {
        name = "Launch Executable",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", require("util").get_root() .. "/", "file")
        end,
        args = function()
          local args = {}
          local args_string = vim.fn.input("Args: ")
          for word in args_string:gmatch("%S+") do
            table.insert(args, word)
          end
          return args
        end,
        cwd = function()
          return require("util").get_root()
        end,
      }

      local function capture(cmd)
        local handle = assert(io.popen(cmd, "r"))
        local output = assert(handle:read("*a"))
        handle:close()
        return output
      end

      local cpp_attach = setmetatable({
        name = "Attach to process",
        type = "cppdbg",
        request = "attach",
      }, {
        __call = function(config)
          local result = vim.deepcopy(config)

          local option = require("dap.utils").pick_process()
          local co = coroutine.running()
          vim.schedule(function()
            coroutine.resume(option, co)
          end)
          local pid = coroutine.yield()
          result.processId = pid
          result.program = capture("readlink -f /proc/" .. tostring(pid) .. "/exe"):sub(1, -2)
          return result
        end,
      })

      local function extract_exectuable_from_file(file)
        local handle = io.popen("cd " .. require("util").get_root() .. " && cmake --build build --target help")
        if handle then
          for line in handle:lines() do
            -- Remove the dots from the beginning of the line
            line = string.gsub(line, "^[%s%.]+", "")
            if string.find(file, line) == 1 then
              return line
            end
          end

          handle:close()
        end
      end

      local cpp_test_launch = {
        name = "Launch Current Test File (Catch2)",
        type = "cppdbg",
        request = "launch",
        program = function()
          local current_file = vim.fn.expand("%:t:r")
          local test_executable = extract_exectuable_from_file(current_file)
          return require("util").get_root() .. "/bin/" .. test_executable
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
      }

      local function get_scenario_line()
        local current_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        for i = current_line, 1, -1 do
          if string.match(lines[i], "SCENARIO") then
            local content = string.match(lines[i], "%((.-)%)")
            local catch2_command = '"Scenario: ' .. content:sub(2)
            return catch2_command
          end
        end
        return ""
      end

      local cpp_test_tag_launch = {
        name = "Launch Current Test File (Catch2, Tag)",
        type = "cppdbg",
        request = "launch",
        program = function()
          local current_file = vim.fn.expand("%:t:r")
          local test_executable = extract_exectuable_from_file(current_file)
          return require("util").get_root() .. "/bin/" .. test_executable
        end,
        args = function()
          local args = {}
          local args_string = get_scenario_line()
          for word in args_string:gmatch("%S+") do
            table.insert(args, word)
          end
          return args
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
      }

      local last_config = {}

      local cpp_last_config = setmetatable({
        name = "Last Config",
        type = "cppdbg",
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
        cpp_test_launch,
        cpp_test_tag_launch,
      }

      dap.listeners.after.event_initialized["last_config"] = function()
        last_config = require("dap").session()["config"]
      end
    end,
  },
}
