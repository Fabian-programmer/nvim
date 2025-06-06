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

  {
    "klen/nvim-config-local",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('config-local').setup {
        -- Default options (optional)

        -- Config file patterns to load (lua supported)
        config_files = { ".nvim.lua", ".nvimrc", ".exrc" },

        -- Where the plugin keeps files data
        hashfile = vim.fn.stdpath("data") .. "/config-local",

        autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
        commands_create = true,     -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalDeny)
        silent = false,             -- Disable plugin messages (Config loaded/denied)
        lookup_parents = false,     -- Lookup config files in parent directories
      }
    end
  },

}
