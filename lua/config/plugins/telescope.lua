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

  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-project.nvim" },
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
  end,
}
