return {

  -- change buffer focus with keystroke
  {
    "leath-dub/snipe.nvim",
    -- stylua: ignore
    keys = {
      { "ft", function() require("snipe").open_buffer_menu() end, desc = "Open buffer menu" },
    },
    opts = {},
  },

  -- finds everything
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function(_, _)
      local actions = require("fzf-lua.actions")

      return {
        "default-title",
        fzf_colors = true,
        defaults = {
          formatter = "path.dirname_first",
        },
        winopts = {
          height = 0.6,
          width = 1.0,
          row = 1.0,
          backdrop = 80,
        },
        files = {
          cwd_prompt = false,
          git_icons = false,
          actions = {
            ["ctrl-h"] = { actions.toggle_hidden },
          },
        },
        grep = {
          rg_glob = true,
          glob_flag = "--iglob",
          glob_separator = "%s%-%-",
          actions = {
            ["ctrl-h"] = { actions.toggle_hidden },
          },
        },
      }
    end,
    -- stylua: ignore
    keys = {
      { "<leader>;", function() require('fzf-lua').resume() end, desc = "FzfLua Resume" },
      { "<leader>ht", function() require('fzf-lua').builtin() end, desc = "FzfLua Builtin" },
      { "<leader>fh", function() require('fzf-lua').command_history() end, desc = "Command History" },
      { "<leader>hC", function() require('fzf-lua').colorschemes() end, desc = "Colorschemes" },
      { "<leader>fm", function() require('fzf-lua').marks() end, desc = "Jump to Mark" },
      { "<leader>hc", function() require('fzf-lua').commands() end, desc = "Commands" },
      { "<leader>hh", function() require('fzf-lua').help_tags() end, desc = "Help Pages" },
      { "<leader>hm", function() require('fzf-lua').man_pages() end, desc = "Man Pages" },
      { "<leader>hk", function() require('fzf-lua').keymaps() end, desc = "Key Maps" },
      -- search
      { "<leader>fg", function() require('fzf-lua').live_grep() end, desc = "Grep" },
      { "<leader>ff", function() require('fzf-lua').files() end, desc = "Find File" },
      { "<leader>fo", function() require('fzf-lua').oldfiles() end, desc = "Open Recent File" },
      { "<leader>fb", function() require('fzf-lua').blines() end, desc = "Find in Buffer" },
      { "gw", mode = "n", function() require('fzf-lua').grep_cword() end, desc = "Find Word" },
      { "gw", mode = "v", function() require('fzf-lua').grep_visual() end, desc = "Find Selection" },
      -- git
      { "<leader>gc", function() require('fzf-lua').git_commits() end, desc = "Commits" },
      { "<leader>gb", function() require('fzf-lua').git_branches() end, desc = "Branches" },

    },
  },

  -- key guide
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 500,
      icons = {
        rules = false,
      },
      spec = {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "tab" },
          { "<leader>b", group = "buffer" },
          { "<leader>c", group = "code" },
          { "<leader>d", group = "debug" },
          { "<leader>f", group = "find" },
          { "<leader>g", group = "git" },
          { "<leader>h", group = "help" },
          { "<leader>r", group = "replace" },
          { "<leader>s", group = "session" },
          { "<leader>w", group = "window" },
          { "<leader>x", group = "diagnostics/quickfix" },
          { "g", group = "goto" },
        },
      },
    },
  },

  -- easily jump to any location and enhanced f/t motions
  {
    "folke/flash.nvim",
    event = { "BufReadPost", "BufNewFile" },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
  },

  -- buffer remove
  {
    "echasnovski/mini.bufremove",
    event = "BufReadPre",
    -- stylua: ignore
    keys = {
      { "<A-q>", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<A-Q>", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },

  -- search/replace in multiple files
  {
    "MagicDuck/grug-far.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>rr", mode = "n", function() require('grug-far').grug_far({ prefills = { paths = require("util").get_root()} }) end, desc = "Replace all" },
      { "<leader>rw", mode = "n", function() require('grug-far').grug_far({ prefills = { search = vim.fn.expand("<cword>") } }) end, desc = "Replace word under cursor" },
      { "<leader>rf", mode = "n", function() require('grug-far').grug_far({ prefills = { paths = vim.fn.expand("%") } }) end, desc = "Replace in file" },
      { "<leader>rf", mode = "v", function() require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand("%") } }) end, desc = "Replace in file" },
    },
    config = function()
      require("grug-far").setup({
        transient = true,
        keymaps = {
          close = { n = "q" },
        },
      })
    end,
  },

  -- diagnostics
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      {
        "<leader>cS",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP references/definitions/... (Trouble)",
      },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "üq",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "+q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },

  {
    "akinsho/toggleterm.nvim",
    optional = true,
    -- stylua: ignore
    keys = {
      { "<leader>hp", function() require("util").create_fullscreen_terminal("htop") end, desc = "Htop" },
    },
  },
}
