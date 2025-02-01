local M = {}

M.root_patterns = { ".git" }
function M.get_clients(...)
  local fn = vim.lsp.get_clients or vim.lsp.get_active_clients
  return fn(...)
end

function M.has(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      fn()
    end,
  })
end

function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
function M.get_root()
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace
          and vim.tbl_map(function(ws)
            return vim.uri_to_fname(ws.uri)
          end, workspace)
        or client.config.root_dir and { client.config.root_dir }
        or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  return root
end

function M.toggle_inlay_hints(buf, value)
  local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
  if type(ih) == "function" then
    ih(buf, value)
  elseif type(ih) == "table" and ih.enable then
    if value == nil then
      value = not ih.is_enabled({ bufnr = buf or 0 })
    end
    ih.enable(value, { bufnr = buf })
  end
end

function M.create_fullscreen_terminal(command)
  require("toggleterm.terminal").Terminal
    :new({
      cmd = command,
      hidden = true,
      direction = "float",
      float_opts = {
        width = vim.o.columns,
        height = vim.o.lines,
      },
    })
    :toggle()
end

function M.projects()
  local project_file = os.getenv("HOME") .. "/.local/share/nvim/projects.txt"

  local gen_items_from_file = function(filepath)
    local items = {}
    local file = io.open(filepath, "r")
    if not file then
      vim.notify("Failed to open file: " .. filepath, vim.log.levels.ERROR)
      return items
    end

    for line in file:lines() do
      table.insert(items, { text = line })
    end
    file:close()

    return items
  end

  Snacks.picker.pick({
    source = "Projects",
    items = gen_items_from_file(project_file),
    preview = "none",
    format = "text",
    layout = {
      preset = "select",
    },
    confirm = function(picker, item)
      picker:close()
      vim.notify("Changed cwd to: " .. item.text)
      vim.cmd("cd " .. item.text)
    end,
  })
end

function M.find_directory()
  local cmd = "fd --type d --hidden --follow --exclude .git --exclude .npm --exclude node_modules . $HOME"

  local gen_items_from_cmd = function(command)
    -- Run the command and get the output as a list
    local raw_items = vim.fn.systemlist(command)

    -- Convert raw list into { { text = "..." }, { text = "..." } } format
    local items = {}
    for _, line in ipairs(raw_items) do
      table.insert(items, { text = line })
    end

    return items
  end

  Snacks.picker.pick({
    source = "Directories",
    items = gen_items_from_cmd(cmd),
    preview = "none",
    format = "text",
    layout = {
      preset = "select",
    },
    confirm = function(picker, item)
      picker:close()
      vim.notify("Changed cwd to: " .. item.text)
      vim.cmd("cd " .. item.text)
    end,
  })
end

return M
