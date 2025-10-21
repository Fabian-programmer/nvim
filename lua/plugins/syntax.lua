return {
  {
    "nvim-treesitter/nvim-treesitter",
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
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts_extend = { "ensure_installed" },
    opts = {
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
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
            ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
            ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
          },
        },
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
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
