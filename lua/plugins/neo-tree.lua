return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = get_root() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
    },
  },

}



-- local M = {
--   "nvim-tree/nvim-tree.lua",
--   keys = {
--     { "<C-n>", "<cmd>:NvimTreeToggle<cr>", desc = "NvimTree" },
--   },
--
-- }
--
-- M.config = {
--   filters = {
--     dotfiles = false,
--     custom = { "^\\.git" },
--   },
--   disable_netrw = true,
--   hijack_netrw = true,
--   open_on_setup = false,
--   hijack_cursor = true,
--   hijack_unnamed_buffer_when_opening = false,
--   update_cwd = true,
--   update_focused_file = {
--     enable = true,
--     update_cwd = false,
--   },
--   view = {
--     adaptive_size = false,
--     side = "left",
--     width = 25,
--     hide_root_folder = true,
--     mappings = {
--       list = {
--         { key = "C", action = "cd" },
--         -- remove a default mappings
--         { key = "<2-RightMouse>", action = "" },
--         { key = "<2-LeftMouse>", action = "" },
--         { key = "<C-]>", action = "" },
--         { key = "]e", action = "" },
--         { key = "[e", action = "" },
--         { key = "]c", action = "" },
--         { key = "[c", action = "" },
--         { key = "<leader>e", action = "" },
--       },
--     },
--   },
--   git = {
--     enable = false,
--     ignore = true,
--   },
--   filesystem_watchers = {
--     enable = true,
--   },
--   actions = {
--     change_dir = {
--       global = true,
--     },
--     open_file = {
--       resize_window = true,
--     },
--   },
--   renderer = {
--     highlight_git = false,
--     highlight_opened_files = "none",
--
--     indent_markers = {
--       enable = false,
--     },
--
--     icons = {
--       show = {
--         file = true,
--         folder = true,
--         folder_arrow = true,
--         git = false,
--       },
--
--       glyphs = {
--         default = "",
--         symlink = "",
--         folder = {
--           default = "",
--           empty = "",
--           empty_open = "",
--           open = "",
--           symlink = "",
--           symlink_open = "",
--           arrow_open = "",
--           arrow_closed = "",
--         },
--         git = {
--           unstaged = "✗",
--           staged = "✓",
--           unmerged = "",
--           renamed = "➜",
--           untracked = "★",
--           deleted = "",
--           ignored = "◌",
--         },
--       },
--     },
--   },
-- }
--
-- return M
