return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("util").get_root() })
        end,
        desc = "File Explorer (root dir)",
      },
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "File Explorer (cwd)",
      },
    },
    opts = {
      open_files_do_not_replace_types = { "trouble", "qf", "terminal" },
      -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
      file_size = {
        enabled = false,
      },
      type = {
        enabled = false,
      },
      last_modified = {
        enabled = false,
      },
      created = {
        enabled = false,
      },
      symlink_target = {
        enabled = true,
      },
      filesystem = {
        bind_to_cwd = true,
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        filtered_items = {
          hide_gitignored = false,
        },
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["y"] = "yank_path",
        },
      },
      commands = {
        yank_path = function(state)
          -- copy path of current node to unnamed register
          vim.fn.setreg("+", state.tree:get_node().path)
        end,
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
  },
}
