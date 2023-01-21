local dap = require("dap")
local mason_registry = require("mason-registry")

local cpp_launch = {
  name = 'Launch Executable',
  type = 'cppdbg',
  request = 'launch',
  program = function()
    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  end,
  args = function()
    local args = {}
    local args_string = vim.fn.input('Args: ')
    for word in args_string:gmatch("%S+") do
      table.insert(args, word)
    end
    return args
  end,
  cwd = '${workspaceFolder}',
  stopAtEntry = true,
  setupCommands = {
    {
      text = '-enable-pretty-printing',
      description = 'enable pretty printing',
      ignoreFailures = false
    },
  },
}

local function capture(cmd)
  local handle = assert(io.popen(cmd, 'r'))
  local output = assert(handle:read('*a'))
  handle:close()
  return output
end

local cpp_attach = setmetatable(
  {
    name = "Attach to process",
    type = 'cppdbg',
    request = 'attach',
    setupCommands = {
      {
        text = '-enable-pretty-printing',
        description = 'enable pretty printing',
        ignoreFailures = false
      },
    },
  }, {
  __call = function(config)
    local result = vim.deepcopy(config)

    local option = require('dap.utils').pick_process()
    local co = coroutine.running()
    vim.schedule(function()
      coroutine.resume(option, co)
    end)
    local pid = coroutine.yield()
    result.processId = pid
    result.program = capture('readlink -f /proc/' .. tostring(pid) .. '/exe'):sub(1, -2)
    return result
  end,
})

local last_config = {}

local cpp_last_config = setmetatable(
  {
    name = 'Last Config',
    type = 'cppdbg',
    request = 'launch',
  }, {
  __call = function()
    return last_config
  end,
})

local cpptools = mason_registry.get_package("cpptools")

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = cpptools:get_install_path() .. '/extension/debugAdapters/bin/OpenDebugAD7'
}

dap.configurations.cpp = {
  cpp_launch, cpp_attach, cpp_last_config
}

dap.listeners.after.event_initialized["last_config"] = function()
  last_config = require("dap").session()["config"]
end
