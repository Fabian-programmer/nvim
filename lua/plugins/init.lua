return {
  {
    "willothy/flatten.nvim",
    config = true,
    lazy = false,
    priority = 1001,
  },

  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  -- framework to run tasks
  {
    "stevearc/overseer.nvim",
    opts = {
      -- Tasks are disposed 5 minutes after running to free resources.
      -- If you need to close a task immediatelly:
      -- press ENTER in the menu you see after compiling on the task you want to close.
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
        bindings = {
          ["q"] = function()
            vim.cmd("OverseerClose")
          end,
        },
      },
    },
  },

  -- run cli commands in float window
  {
    "akinsho/toggleterm.nvim",
    version = "*",
  },

  -- special handling for big files, like .asm
  {
    "folke/snacks.nvim",
    opts = {
      bigfile = {},
    },
  },
}
