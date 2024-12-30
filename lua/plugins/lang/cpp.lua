return {
  -- external artefacts
  {
    "mason.nvim",
    opts = { ensure_installed = { "clangd" } },
  },

  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "c", "cpp" } },
  },

  -- lsp includes formatter
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
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
    opts = function()
      local dap = require("dap")

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" },
      }

      -- configuration --
      local cpp_launch = {
        name = "Launch Executable",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", require("util").get_root() .. "/", "file")
        end,
        args = function()
          local args_str = vim.fn.input({
            prompt = "Arguments: ",
          })
          return vim.split(args_str, " +")
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

      local function extract_exectuable_from_file()
        local file = vim.fn.expand("%:t:r")
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
        type = "gdb",
        request = "launch",
        program = function()
          local test_executable = extract_exectuable_from_file()
          return require("util").get_root() .. "/bin/" .. test_executable
        end,
        cwd = "${workspaceFolder}",
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
        type = "gdb",
        request = "launch",
        program = function()
          local test_executable = extract_exectuable_from_file()
          return require("util").get_root() .. "/bin/" .. test_executable
        end,
        args = function()
          return get_scenario_line()
        end,
        cwd = "${workspaceFolder}",
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
        cpp_test_launch,
        cpp_test_tag_launch,
      }

      dap.listeners.after.event_initialized["last_config"] = function()
        last_config = require("dap").session()["config"]
      end
    end,
  },

  -- compiler explorer
  {
    "Fabian-programmer/compiler-explorer.nvim",
    cmd = { "CECompile" },
  },

  -- find cmake targets
  {
    "ibhagwan/fzf-lua",
    optional = true,
    keys = {
      {
        "<leader>cc",
        function()
          local buildFolder = require("util").get_root() .. "/build"
          local bashCommand = "cmake --build " .. buildFolder .. " --target help"

          require("fzf-lua").fzf_exec(bashCommand, {
            fn_transform = function(x)
              if x:match("^%.%.%.%s*(.+)") then -- filter only results with "... word"
                return x:match("^%S+%s+(%S+)") -- return second word
              end
            end,
            actions = {
              ["default"] = function(selected, _)
                local overseer = require("overseer")
                local task = overseer.new_task({
                  name = "- Build",
                  strategy = {
                    "orchestrator",
                    tasks = {
                      {
                        "shell",
                        name = "- Build this target → " .. selected[1],
                        cwd = require("util").get_root(),
                        cmd = "cmake --build build --target " .. selected[1] .. " -- -j8",
                      },
                    },
                  },
                })
                task:start()
                vim.cmd("OverseerOpen")
              end,
              ["ctrl-y"] = function(selected, _)
                vim.fn.setreg("+", selected[1])
              end,
            },
            prompt = "CMake Targets> ",
            previewer = false,
          })
        end,
        desc = "CMake Targets",
      },
    },
  },
}
