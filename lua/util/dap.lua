local M = {}

function M.pick_executable()
  local picker = function()
    local co = coroutine.running()
    require("snacks").picker.pick(nil, {
      title = "Executables",
      preview = "none",
      layout = {
        preset = "select",
      },
      format = "text",
      finder = function(config, ctx)
        return require("snacks.picker.source.proc").proc({
          config,
          {
            cmd = "fd",
            args = { "--type", "x", "-H", "-I", "--exclude", ".git" },
          }
        }, ctx)
      end,
      confirm = function(picker, item)
        picker:close()
        coroutine.resume(co, item.text)
      end
    })
    return coroutine.yield()
  end

  return picker()
end

function M.get_args(opts)
  local input = function()
    local co = coroutine.running()
    vim.ui.input(opts, function(user_input)
      coroutine.resume(co, user_input)
    end)
    return coroutine.yield()
  end

  return vim.split(input(), " +")
end

return M
