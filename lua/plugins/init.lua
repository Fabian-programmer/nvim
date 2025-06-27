return {
  {
    "willothy/flatten.nvim",
    config = true,
    lazy = false,
    priority = 1001,
  },

  -- framework to run tasks
  {
    "stevearc/overseer.nvim",
    keys = {
      { "<leader>oo", "<cmd>OverseerOpen<cr>", desc = "Open Overseer" },
    },
    opts = {
      task_list = {
        min_height = 25,
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

  {
    "klen/nvim-config-local",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('config-local').setup {
        config_files = { ".nvim.lua", ".nvimrc", ".exrc" },
        hashfile = vim.fn.stdpath("data") .. "/config-local",
        autocommands_create = true,
        commands_create = true,
        silent = false,
        lookup_parents = false,
      }
    end
  },

}
