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

  -- The framework we use to run tasks
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

  -- easily jump to any location and enhanced f/t motions for Leap
  {
    "folke/flash.nvim",
    event = { "BufReadPost", "BufNewFile" },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
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

  {
    "echasnovski/mini.trailspace",
    event = "BufReadPre",
  },

  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    build = false,
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>rr", function() require("spectre").open() end, desc = "Replace all in cwd" },
      { "<leader>rw", function() require("spectre").open_visual({ select_word = true }) end, desc = "Replace word under cursor" },
      { "<leader>rf", function() require("spectre").open_file_search() end, desc = "Replace in file" },
    },
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
    "willothy/flatten.nvim",
    config = true,
    lazy = false,
    priority = 1001,
  },

  -- compiler explorer
  {
    "Fabian-programmer/compiler-explorer.nvim",
    cmd = { "CECompile" },
  },
}
