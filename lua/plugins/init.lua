return {

  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  -- session manager
  {
    "jedrzejboczar/possession.nvim",
    event = "BufReadPre",
    cmd = { "PossessionLoad", "PossessionList" },
    keys = {
      {
        "<leader>sl",
        function()
          require("telescope").extensions.possession.list()
        end,
        desc = "List Sessions",
      },
      {
        "<leader>ss",
        function()
          local input = vim.fn.input("Enter the session name: ")
          if input ~= "" then
            require("possession.session").save(input)
          else
            print("No input provided.")
          end
        end,
        desc = "Save Session",
      },
    },
    opts = {
      telescope = {
        list = {
          default_action = "load",
          mappings = {
            delete = { n = "d", i = "<c-d>" },
            rename = { n = "r", i = "<c-r>" },
          },
        },
      },
    },
  },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>d"] = { name = "+debug" },
        ["<leader>f"] = { name = "+find" },
        ["<leader>h"] = { name = "+help" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunk" },
        ["<leader>r"] = { name = "+replace" },
        ["<leader>s"] = { name = "+session" },
        ["<leader><tab>"] = { name = "+tab" },
        ["<leader>w"] = { name = "+window" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },

  -- easily jump to any location and enhanced f/t motions for Leap
  {
    "ggandor/leap.nvim",
    event = "BufReadPre",
    keys = {
      { "s",  mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S",  mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
    dependencies = { "ggandor/leap-spooky.nvim", config = true },
  },

  -- buffer remove
  {
    "echasnovski/mini.bufremove",
    event = "BufReadPre",
    keys = {
      {
        "<A-q>",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete Buffer",
      },
      {
        "<A-Q>",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Delete Buffer (Force)",
      },
    },
  },

  {
    "echasnovski/mini.trailspace",
    event = "BufReadPre",
  },

  {
    "numToStr/Comment.nvim",
    keys = {
      {
        "<leader>/",
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        desc = "Comment",
      },
      {
        "<leader>/",
        "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
        desc = "Comment",
        mode = "v",
      },
    },
  },

  -- search/replace in multiple files
  {
    "windwp/nvim-spectre",
    keys = {
      {
        "<leader>rr",
        function()
          require("spectre").open()
        end,
        desc = "Replace all in cwd",
      },
      {
        "<leader>rf",
        function()
          require("spectre").open_file_search()
        end,
        desc = "Replace in file",
      },
      {
        "<leader>rw",
        function()
          require("spectre").open_visual({ select_word = true })
        end,
        desc = "Replace word under cursor",
      },

      { "<leader>fr", "<esc>:lua require('spectre').open_visual()<CR>", desc = "Replace word", mode = "v" },
    },
  },

  -- diagnostics
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
    },
    opts = {
      auto_open = false,
      use_diagnostic_signs = true,
    },
  },

  {
    "willothy/flatten.nvim",
    config = true,
    lazy = false,
    priority = 1001,
  },

  -- compiler explorer
  {
    "Fabian-programmer/compiler-explorer.nvim",
    cmd = { "CECompile" },
    config = true,
  },
}
