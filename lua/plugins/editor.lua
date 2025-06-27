return {

  -- change buffer focus with keystroke
  {
    "leath-dub/snipe.nvim",
    keys = {
      { "ft", function() require("snipe").open_buffer_menu() end, desc = "Open buffer menu" },
    },
    opts = {},
  },

  -- finds everything
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>;",  function() Snacks.picker.resume() end,                      desc = "Resume" },
      -- find
      { "<leader>ff", function() Snacks.picker.files() end,                       desc = "Find Files" },
      { "<leader>fp", function() Snacks.picker.projects() end,                    desc = "Projects" },
      { "<leader>fo", function() Snacks.picker.recent() end,                      desc = "Open Recent File" },
      { "<leader>fg", function() Snacks.picker.grep() end,                        desc = "Grep" },
      { "gw",         function() Snacks.picker.grep_word() end,                   desc = "Visual selection or word", mode = { "n", "x" } },
      { "<leader>fb", function() Snacks.picker.lines({ layout = "default" }) end, desc = "Find in Buffer" },
      { "<leader>fm", function() Snacks.picker.marks() end,                       desc = "Marks" },
      --help
      { "<leader>ht", function() Snacks.picker.pickers() end,                     desc = "Pickers" },
      { "<leader>fc", function() Snacks.picker.command_history() end,             desc = "Command History" },
      { "<leader>hC", function() Snacks.picker.colorschemes() end,                desc = "Colorschemes" },
      { "<leader>hc", function() Snacks.picker.commands() end,                    desc = "Commands" },
      { "<leader>hh", function() Snacks.picker.help() end,                        desc = "Help Pages" },
      { "<leader>hm", function() Snacks.picker.man() end,                         desc = "Man Pages" },
      { "<leader>hk", function() Snacks.picker.keymaps() end,                     desc = "Keymaps" },
      -- git
      { "<leader>gc", function() Snacks.picker.git_log() end,                     desc = "Git Log" },
      { "<leader>gs", function() Snacks.picker.git_status() end,                  desc = "Git Status" },
      -- LSP
      { "gd",         function() Snacks.picker.lsp_definitions() end,             desc = "Goto Definition" },
      { "gr",         function() Snacks.picker.lsp_references() end,              nowait = true,                     desc = "References" },
      { "gI",         function() Snacks.picker.lsp_implementations() end,         desc = "Goto Implementation" },
      { "gy",         function() Snacks.picker.lsp_type_definitions() end,        desc = "Goto T[y]pe Definition" },
      { "<leader>cs", function() Snacks.picker.lsp_symbols() end,                 desc = "LSP Symbols" },
    },

    opts = {
      picker = {
        layouts = {
          default = {
            layout = {
              box = "horizontal",
              width = 0,
              height = 0.6,
              backdrop = 80,
              row = -1,
            },
          },
        },
        sources = {
          files = { ignored = true },
        },
      },
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
          { "<leader>b",     group = "buffer" },
          { "<leader>c",     group = "code" },
          { "<leader>d",     group = "debug" },
          { "<leader>f",     group = "find" },
          { "<leader>g",     group = "git" },
          { "<leader>h",     group = "help" },
          { "<leader>r",     group = "replace" },
          { "<leader>s",     group = "session" },
          { "<leader>w",     group = "window" },
          { "<leader>x",     group = "diagnostics/quickfix" },
          { "g",             group = "goto" },
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
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    },
  },

  -- buffer remove
  {
    "echasnovski/mini.bufremove",
    event = "BufReadPre",
    -- stylua: ignore
    keys = {
      { "<A-q>", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<A-Q>", function() require("mini.bufremove").delete(0, true) end,  desc = "Delete Buffer (Force)" },
    },
  },

  -- search/replace in multiple files
  {
    "MagicDuck/grug-far.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>rr", mode = "n", function() require('grug-far').open({ prefills = { paths = require("util").get_root() } }) end,          desc = "Replace all" },
      { "<leader>rw", mode = "n", function() require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } }) end,           desc = "Replace word under cursor" },
      { "<leader>rf", mode = "n", function() require('grug-far').open({ prefills = { paths = vim.fn.expand("%") } }) end,                  desc = "Replace in file" },
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
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cS", "<cmd>Trouble symbols toggle focus=false<cr>",      desc = "Symbols (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                  desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                   desc = "Quickfix List (Trouble)" },
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
    "echasnovski/mini.surround",
    keys = function(_, keys)
      local opts = require("util").opts("mini.surround")
      local mappings = {
        { opts.mappings.add,            desc = "Add Surrounding",                     mode = { "n", "v" } },
        { opts.mappings.delete,         desc = "Delete Surrounding" },
        { opts.mappings.find,           desc = "Find Right Surrounding" },
        { opts.mappings.find_left,      desc = "Find Left Surrounding" },
        { opts.mappings.highlight,      desc = "Highlight Surrounding" },
        { opts.mappings.replace,        desc = "Replace Surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gsa",            -- Add surrounding in Normal and Visual modes
        delete = "gsd",         -- Delete surrounding
        find = "gsf",           -- Find surrounding (to the right)
        find_left = "gsF",      -- Find surrounding (to the left)
        highlight = "gsh",      -- Highlight surrounding
        replace = "gsr",        -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
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
