local M = {}

function M.find_cmake_targets(opts)
  opts = opts or {}
  opts.fn_transform = function(x)
    if x:match("^%.%.%.%s*(.+)") then -- filter only results with the pattern "... <word>"
      return x:match("^%S+%s+(%S+)") -- return second word, which represents the target
    end
  end
  opts.actions = {
    ["default"] = function(selected, _)
      local overseer = require("overseer")
      local task = overseer.new_task({
        name = "- Build",
        strategy = {
          "orchestrator",
          tasks = {
            {
              "shell",
              name = "- Build this target → " .. selected[1],
              cwd = require("util").get_root(),
              cmd = "cmake --build build --target " .. selected[1] .. " -- -j8",
            },
          },
        },
      })
      task:start()
      vim.cmd("OverseerOpen")
    end,
    ["ctrl-y"] = function(selected, _)
      vim.fn.setreg("+", selected[1])
    end,
  }
  opts.prompt = "CMake Targets> "

  local buildFolder = require("util").get_root() .. "/build"
  require("fzf-lua").fzf_exec("cmake --build " .. buildFolder .. " --target help", opts)
end

return M
