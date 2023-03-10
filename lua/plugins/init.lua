return {

  "nvim-lua/plenary.nvim",

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        plugins = { spelling = true },
        key_labels = { ["<leader>"] = "SPC" },
        icons = {
          separator = "→", -- symbol used between a key and it's label
        },
      })
      wk.register({
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>d"] = { name = "+debug" },
        ["<leader>f"] = { name = "+find" },
        ["<leader>fr"] = { name = "+replace" },
        ["<leader>h"] = { name = "+help" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunk" },
        ["<leader>t"] = { name = "+test" },
        ["<leader><tab>"] = { name = "+tab" },
        ["<leader>w"] = { name = "+window" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      })
    end,
  },

  -- easily jump to any location and enhanced f/t motions for Leap
  {
    "ggandor/leap.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
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
      vim.keymap.del({ "n" }, "cc")
    end,
  },

  -- buffer remove
  {
    "echasnovski/mini.bufremove",
    event = "BufReadPre",
    keys = {
      { "<A-q>", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<A-Q>", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },

  {
    "echasnovski/mini.trailspace",
    event = "BufReadPre",
  },

  {
    "numToStr/Comment.nvim",
    keys = {
      { "<leader>/", function() require("Comment.api").toggle.linewise.current() end, desc = "Comment" },
      { "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", desc = "Comment",
        mode = "v" },
    },
  },

  -- search/replace in multiple files
  {
    "windwp/nvim-spectre",
    keys = {
      { "<leader>frr", function() require("spectre").open() end, desc = "Replace all in cwd" },
      { "<leader>frf", function() require("spectre").open_file_search() end, desc = "Replace in file" },
      { "<leader>frw", function() require("spectre").open_visual({ select_word = true }) end,
        desc = "Replace word under cursor" },

      { "<leader>fr", "<esc>:lua require('spectre').open_visual()<CR>", desc = "Replace word", mode = "v" },
    },
  },

  -- diagnostics
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
    },
    config = {
      auto_open = false,
      use_diagnostic_signs = true,
    },
  },

  -- compiler explorer
  {
    "Fabian-programmer/compiler-explorer.nvim",
    cmd = { "CECompile" },
    config = true,
  },
}
