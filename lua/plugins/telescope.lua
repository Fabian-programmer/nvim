local function open_entry_in_diffview(cmd)
  -- Open in diffview
  local selected_entry = require('telescope.actions.state').get_selected_entry()
  local value = selected_entry.value
  -- close Telescope window properly prior to switching windows
  vim.api.nvim_win_close(0, true)
  vim.cmd("stopinsert")
  vim.schedule(function()
    vim.cmd(("DiffviewOpen %s" .. cmd):format(value))
  end)
end

local function debug_file_with_dap()
  local selected_entry = require('telescope.actions.state').get_selected_entry()
  local value = selected_entry.value
  -- close Telescope window properly prior to switching windows
  vim.api.nvim_win_close(0, true)
  vim.cmd("stopinsert")

  local config = {
    type = 'cppdbg',
    request = 'launch',
    program = value,
    args = function()
      local args = {}
      local args_string = vim.fn.input('Args: ')
      for word in args_string:gmatch("%S+") do
        table.insert(args, word)
      end
      return args
    end,
    cwd = '${workspaceFolder}',
    stopAtEntry = true,
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'enable pretty printing',
        ignoreFailures = false
      },
    },
  }
  vim.schedule(function()
    require("dap").run(config)
  end)
end

return {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>",                desc = "Find File" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>",                  desc = "Open Recent File" },
    { "<leader>fg", "<cmd>Telescope live_grep_args<cr>",            desc = "Grep" },
    { "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>fh", "<cmd>Telescope command_history<cr>",           desc = "Command History" },
    { "<leader>fp", "<cmd>Telescope project<cr>",                   desc = "Project" },
    { "<leader>fu", "<cmd>Telescope undo<cr>",                      desc = "Undo Tree" },
    {
      "<leader>fs",
      function()
        require("telescope.builtin").lsp_document_symbols({
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        })
      end,
      desc = "Goto Symbol"
    },
    { "<leader>fm", "<cmd>Telescope marks<cr>",        desc = "Jump to Mark" },
    { "<leader>ht", "<cmd>Telescope builtin<cr>",      desc = "Telescope" },
    { "<leader>hc", "<cmd>Telescope commands<cr>",     desc = "Commands" },
    { "<leader>hh", "<cmd>Telescope help_tags<cr>",    desc = "Help Pages" },
    { "<leader>hm", "<cmd>Telescope man_pages<cr>",    desc = "Man Pages" },
    { "<leader>hk", "<cmd>Telescope keymaps<cr>",      desc = "Key Maps" },
    { "<leader>hs", "<cmd>Telescope highlights<cr>",   desc = "Search Highlight Groups" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>",  desc = "Commits" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
    { "<leader>gs", "<cmd>Telescope git_status<cr>",   desc = "Status" },
  },
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim",    build = "make" },
    { "nvim-telescope/telescope-project.nvim" },
    { "nvim-telescope/telescope-dap.nvim" },
    { "nvim-telescope/telescope-live-grep-args.nvim" },
    { "debugloop/telescope-undo.nvim" },
  },
  config = function()
    local telescope = require("telescope")
    local borderless = true
    telescope.setup({
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          prompt_position = "top",
        },
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["<c-t>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
          },
        },
        prompt_prefix = " ",
        selection_caret = " ",
        winblend = borderless and 0 or 10,
      },
      pickers = {
        find_files = {
          mappings = {
            i = {
              ["<F5>"] = function()
                debug_file_with_dap()
              end,
            }
          }
        },
        git_commits = {
          mappings = {
            i = {
              ["<F2>"] = function()
                open_entry_in_diffview("")
              end,
              ["<F3>"] = function()
                open_entry_in_diffview("^!")
              end,
            }
          }
        },
        git_branches = {
          mappings = {
            i = {
              ["<F2>"] = function()
                open_entry_in_diffview("")
              end,
            }
          }
        },
      },
      extensions = {
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
              ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
              ["<C-a>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --no-ignore " }),
            },
          },
        },
        undo = {
          mappings = {
            i = {
              ["y"] = require("telescope-undo.actions").yank_additions,
              ["d"] = require("telescope-undo.actions").yank_deletions,
              ["<Enter>"] = require("telescope-undo.actions").restore,
            },
          },
        },
      }
    })
    telescope.load_extension("fzf")
    telescope.load_extension("project")
    telescope.load_extension("dap")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("undo")
  end,
}
