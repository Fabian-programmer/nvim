local M = {}

-- returns the root directory based on:
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
function M.get_root()
  local lsp_clients = vim.lsp.get_clients({ bufnr = 0 })
  if #lsp_clients > 0 then
    for _, client in ipairs(lsp_clients) do
      if client.config.root_dir then
        return client.config.root_dir
      end
    end
  end

  local root_patterns = { ".git" }

  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil

  return path and vim.fs.root(path, root_patterns) or vim.loop.cwd()
end

function M.create_fullscreen_float_terminal(command)
  require("toggleterm.terminal").Terminal
      :new({
        cmd = command,
        close_on_exit = true,
        direction = "float",
        float_opts = {
          width = vim.o.columns,
          height = vim.o.lines,
        },
      })
      :toggle()
end

function M.create_terminal(command)
  if command then
    command = "terminal " .. command
  else
    command = "terminal"
  end
  vim.cmd(command)
  vim.cmd("startinsert")

  -- Set ESC mapping for the current terminal buffer
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_keymap(bufnr, 't', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
end

function M.find_directory(path)
  local find_directory = function(opts, ctx)
    return require("snacks.picker.source.proc").proc({
      opts,
      {
        cmd = "fd",
        args = { "--type", "d", "--hidden", "--exclude", ".git", "--exclude", ".npm", "--exclude", "node_modules", "--exclude", "mnt", ".", path },
      },
    }, ctx)
  end

  local change_directory = function(picker)
    picker:close()
    local item = picker:current()
    if not item then
      return
    end
    local dir = item.text
    vim.fn.chdir(dir)
  end

  Snacks.picker.pick({
    source = "Directories",
    finder = find_directory,
    format = "text",
    confirm = change_directory,
    preview = "none",
    layout = {
      preset = "select",
    },
  })
end

return M
