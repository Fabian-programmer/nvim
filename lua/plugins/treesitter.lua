return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    opts_extend = { "ensure_installed" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "diff",
        "html",
        "json",
        "markdown",
        "markdown_inline",
        "regex",
        "query",
        "vim",
        "vimdoc",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<A-space>",
          node_incremental = "<A-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["+f"] = "@function.outer", ["+c"] = "@class.outer", ["+a"] = "@parameter.inner" },
          goto_next_end = { ["+F"] = "@function.outer", ["+C"] = "@class.outer", ["+A"] = "@parameter.inner" },
          goto_previous_start = { ["üf"] = "@function.outer", ["üc"] = "@class.outer", ["üa"] = "@parameter.inner" },
          goto_previous_end = { ["üF"] = "@function.outer", ["üC"] = "@class.outer", ["üA"] = "@parameter.inner" },
        },
      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    enabled = true,
    config = function()
      local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
      -- If treesitter is already loaded, we need to run config again for textobjects
      if plugin then
        local opts = require("lazy.core.plugin").values(plugin, "opts", false)
        require("nvim-treesitter.configs").setup({ textobjects = opts.textobjects })
      end
    end,
  },
}
