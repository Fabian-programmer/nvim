local function commit_range()
  local first_commit_line = string.gsub(vim.fn.getline('v'), '*', '')
  local second_commit_line = string.gsub(vim.fn.getline('.'), '*', '')

  local first_commit = vim.split(first_commit_line, '%s+')[2]
  local second_commit = vim.split(second_commit_line, '%s+')[2]

  local range = first_commit .. ".." .. second_commit

  return range
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "NeogitLogView",
  },
  callback = function(event)
    vim.keymap.set("v", "d", function()
      vim.api.nvim_command("DiffviewOpen " .. commit_range())
    end, { buffer = event.buf })
  end,
})


return {
  "Fabian-programmer/neogit",
  cmd = "Neogit",
  config = {
    disable_commit_confirmation = false,
    disable_insert_on_commit = false,
    disable_builtin_notifications = true,
    signs = {
      -- { CLOSED, OPENED }
      section = { "", "" },
      item = { "", "" },
      hunk = { "", "" },
    },
    integrations = { diffview = true },
  },
  keys = {
    { "<leader>gg", function()
      require("neogit").open({cwd = get_root()})
    end, desc = "Neogit" },
    { "<leader>gl", function()
      require("neogit.popups.log").create()
      vim.cmd('normal l')
      vim.cmd(':wincmd p| wincmd T')
    end, desc = "Log current" },
    { "<leader>gL", function()
      require("neogit.popups.log").create()
      vim.cmd('normal b')
      vim.cmd(':wincmd p| wincmd T')
    end, desc = "Log" },
  },
}
