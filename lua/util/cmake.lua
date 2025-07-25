local M = {}

function M.pick_build_dir(callback)
  local proc = require("snacks.picker.source.proc").proc
  local pick = Snacks.picker.pick

  pick({
    source = "Build Directory",
    finder = function(opts, ctx)
      return proc({
        opts,
        {
          cmd = "fd",
          args = {
            "CMakeCache.txt",
            "--type", "f",
            "--hidden",
            "--no-ignore",
            "--exec", "dirname",
          },
        },
      }, ctx)
    end,
    format = "text",
    preview = "none",
    layout = { preset = "select" },
    confirm = function(_, item)
      callback(item.text) -- Call with selected directory
    end,
  })
end

function M.find_cmake_targets(build_folder)
  local proc = require("snacks.picker.source.proc").proc
  local pick = Snacks.picker.pick

  local function select_target(build_dir)
    pick({
      source = "CMake Targets",
      finder = function(opts, ctx)
        return proc({
          opts,
          {
            cmd = "cmake",
            args = { "--build", build_dir, "--target", "help" },
            transform = function(item)
              if item.text:match("^%.%.%.%s*(.+)") then
                item.text = item.text:match("^%S+%s+(%S+)")
              else
                return false
              end
            end,
          },
        }, ctx)
      end,
      format = "text",
      preview = "none",
      layout = { preset = "select" },
      confirm = function(_, target_item)
        local overseer = require("overseer")
        local task = overseer.new_task({
          name = "- Build",
          strategy = {
            "orchestrator",
            tasks = {
              {
                "shell",
                name = "- Build this target → " .. target_item.text,
                cwd = require("util").get_root(),
                cmd = "cmake --build " .. build_dir .. " --target " .. target_item.text .. " -- -j8",
              },
            },
          },
        })
        task:start()
        vim.cmd("OverseerOpen")
      end,
    })
  end

  if build_folder then
    select_target(build_folder)
  else
    M.pick_build_dir(select_target)
  end
end

return M
