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

return {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
    { "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>fh", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>fp", "<cmd>Telescope project<cr>", desc = "Project" },
    { "<leader>fs",
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
      end, desc = "Goto Symbol" },
    { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },

    { "<leader>ht", "<cmd>Telescope builtin<cr>", desc = "Telescope" },
    { "<leader>hc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>hh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>hm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>hk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>hs", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },

    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
    { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status" },
  },

  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-project.nvim" },
    { "nvim-telescope/telescope-dap.nvim" },
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
    })
    telescope.load_extension("fzf")
    telescope.load_extension("project")
    telescope.load_extension("dap")
  end,
}
