local M = {}

function M.find_latest_build_folder()
  local build_path = require("util").get_root() .. "/build"
  local latest_folder = ""
  local latest_time = 0

  -- Ensure build directory exists
  if vim.fn.isdirectory(build_path) == 0 then
    vim.notify("Build directory does not exist: " .. build_path, vim.log.levels.ERROR)
    return latest_folder
  end

  -- Check if there's a CMakeCache.txt in the build directory
  local cmake_cache = build_path .. "/CMakeCache.txt"
  if vim.fn.filereadable(cmake_cache) == 1 then
    latest_folder = build_path
    return latest_folder
  end

  -- Recursive function to scan subdirectories
  local function scan_dir(path)
    local entries = vim.fn.readdir(path) -- Get all entries in the directory

    for _, entry in ipairs(entries) do
      local full_path = path .. "/" .. entry
      if vim.fn.isdirectory(full_path) == 1 then
        -- Check for CMakeCache.txt in this directory
        local cmake_cache = full_path .. "/CMakeCache.txt"
        if vim.fn.filereadable(cmake_cache) == 1 then
          local mod_time = vim.fn.getftime(cmake_cache) -- Get CMakeCache.txt modification time
          if mod_time > latest_time then
            latest_time = mod_time
            latest_folder = full_path
          end
        end

        -- Recursively scan subdirectories
        scan_dir(full_path)
      end
    end
  end

  scan_dir(build_path)

  return latest_folder
end

function M.find_cmake_targets()
  local find_cmake_targets = function(opts, ctx)
    return require("snacks.picker.source.proc").proc({
      opts,
      {
        cmd = "cmake",
        args = {
          "--build",
          M.find_latest_build_folder(),
          "--target",
          "help",
        },
        transform = function(item)
          if item.text:match("^%.%.%.%s*(.+)") then -- filter only results with the pattern "... <word>"
            item.text = item.text:match("^%S+%s+(%S+)") -- return second word, which represents the target
          else
            return false
          end
        end,
      },
    }, ctx)
  end

  Snacks.picker.pick({
    source = "CMake Targets",
    finder = find_cmake_targets,
    preview = "none",
    format = "text",
    layout = {
      preset = "select",
    },
    confirm = function(picker, item)
      picker:close()
      local overseer = require("overseer")
      local task = overseer.new_task({
        name = "- Build",
        strategy = {
          "orchestrator",
          tasks = {
            {
              "shell",
              name = "- Build this target → " .. item.text,
              cwd = require("util").get_root(),
              cmd = "cmake --build build --target " .. item.text .. " -- -j8",
            },
          },
        },
      })
      task:start()
      vim.cmd("OverseerOpen")
    end,
  })
end

return M
