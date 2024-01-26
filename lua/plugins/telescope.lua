return {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  keys = {
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>;", "<cmd>Telescope resume<cr>", desc = "Telescope Resume" },
    { "<leader>ff", "<cmd>Telescope find_files <cr>", desc = "Find File" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },
    { "<leader>fg", "<cmd>Telescope live_grep_args<cr>", desc = "Grep" },
    { "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find in Buffer" },
    { "<leader>ft", "<cmd>Telescope scope buffers<cr>", desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>fp", "<cmd>Telescope project<cr>", desc = "Project" },
    { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo Tree" },
    { "<leader>cc", "<cmd>Telescope cmake<cr>", desc = "CMake Targets" },
    {
      "<leader>fs",
      function()
        require("telescope.builtin").lsp_document_symbols({
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        })
      end,
      desc = "Goto Symbol",
    },
    { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>ht", "<cmd>Telescope builtin<cr>", desc = "Telescope" },
    { "<leader>hc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>hh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>hm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>hk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
    -- stylua: ignore
    { "gw", mode = "n", function() require("telescope-live-grep-args.shortcuts").grep_word_under_cursor() end, desc = "Find Word" },
    -- stylua: ignore
    { "gw", mode = "v", function() require("telescope-live-grep-args.shortcuts").grep_visual_selection() end, desc = "Find Selection" },
  },
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-project.nvim" },
    { "nvim-telescope/telescope-live-grep-args.nvim" },
    { "debugloop/telescope-undo.nvim" },
    {
      "Fabian-programmer/cmake.nvim",
      dependenciens = {
        { "stevearc/overseer.nvim" },
      },
    },
  },
  config = function()
    local telescope = require("telescope")
    local borderless = true
    telescope.setup({
      defaults = {
        layout_strategy = "bottom_pane",
        layout_config = {
          height = 25,
        },
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["<c-t>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
          },
        },
        prompt_prefix = " ",
        selection_caret = " ",
        winblend = borderless and 0 or 10,
      },
      pickers = {},
      extensions = {
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
              ["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({
                postfix = " --iglob !*messages-gen* --iglob ",
              }),
              ["<C-a>"] = require("telescope-live-grep-args.actions").quote_prompt({
                postfix = " --no-ignore ",
              }),
            },
          },
        },
        project = {
          on_project_selected = function(prompt_bufnr)
            local project_actions = require("telescope._extensions.project.actions")
            project_actions.change_working_directory(prompt_bufnr, false)
          end,
        },
        undo = {
          mappings = {
            i = {
              ["y"] = require("telescope-undo.actions").yank_additions,
              ["d"] = require("telescope-undo.actions").yank_deletions,
              ["<Enter>"] = require("telescope-undo.actions").restore,
            },
          },
        },
      },
    })
    telescope.load_extension("fzf")
    telescope.load_extension("project")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("undo")
    telescope.load_extension("scope")
    telescope.load_extension("possession")
    telescope.load_extension("cmake")
  end,
}
