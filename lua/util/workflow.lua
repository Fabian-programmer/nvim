local M = {}

function M.find_asm_file(latest_build_folder, current_file)
  -- Get the current file's name without the extension
  local filename = vim.fn.fnamemodify(current_file, ":t:r")         -- Get the filename without the path and extension
  local asm_file = latest_build_folder .. "/" .. filename .. ".asm" -- Construct the path for the .asm file

  -- Check if the .asm file exists
  if vim.fn.filereadable(asm_file) == 1 then
    return asm_file -- Return the path to the .asm file if it exists
  else
    return nil      -- Return nil if the .asm file does not exist
  end
end

function M.open_asm_file_in_split()
  local current_file = vim.api.nvim_buf_get_name(0)
  current_file = current_file ~= "" and vim.loop.fs_realpath(current_file) or nil

  if current_file == nil then
    require("lazy.core.util").warn(current_file .. " does not exist", { title = "ASM file" })
    return
  end

  local build_folder = require("util").find_latest_build_folder()

  if build_folder == nil then
    require("lazy.core.util").warn("build folder for " .. current_file .. " not found", { title = "ASM file" })
    return
  end

  local asm_file_path = M.find_asm_file(build_folder, current_file)

  if asm_file_path then
    -- Open the ASM file in a vertical split
    vim.cmd("vsplit " .. asm_file_path)
  else
    require("lazy.core.util").warn(asm_file_path .. " does not exist", { title = "ASM file" })
  end
end

return M
