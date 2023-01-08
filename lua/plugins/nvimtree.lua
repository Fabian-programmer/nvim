local M = {
  "nvim-tree/nvim-tree.lua",
  keys = {
    { "<C-n>", "<cmd>:NvimTreeToggle<cr>", desc = "NvimTree" },
  },

  dependencies = { "nvim-tree/nvim-web-devicons", config = { default = true } }
}

M.config = {
  filters = {
    dotfiles = false,
    custom = { "^\\.git" },
  },
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  view = {
    adaptive_size = false,
    side = "left",
    width = 25,
    hide_root_folder = true,
    mappings = {
      list = {
        { key = "C", action = "cd" },
        -- remove a default mappings
        { key = "<2-RightMouse>", action = "" },
        { key = "<2-LeftMouse>", action = "" },
        { key = "<C-]>", action = "" },
        { key = "]e", action = "" },
        { key = "[e", action = "" },
        { key = "]c", action = "" },
        { key = "[c", action = "" },
        { key = "<leader>e", action = "" },
      },
    },
  },
  git = {
    enable = false,
    ignore = true,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    change_dir = {
      global = true,
    },
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    highlight_git = false,
    highlight_opened_files = "none",

    indent_markers = {
      enable = false,
    },

    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = false,
      },

      glyphs = {
        default = "",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
}

return M
