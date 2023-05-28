vim.api.nvim_create_autocmd("FileType", {
	pattern = { "dap-float" },
	callback = function(event)
		vim.keymap.set("n", "<Tab>", "", { buffer = event.buf, silent = true })
		vim.keymap.set("n", "<S-Tab>", "", { buffer = event.buf, silent = true })
	end,
})

local M = {
	"mfussenegger/nvim-dap",
	branch = "master",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			config = function()
				require("dapui").setup({
					layouts = {
						{
							elements = {
								-- Elements can be strings or table with id and size keys.
								{ id = "scopes", size = 0.4 },
								"breakpoints",
								"stacks",
								"watches",
							},
							size = 50, -- 40 columns
							position = "left",
						},
						{
							elements = {
								"console",
							},
							size = 0.3,
							position = "bottom",
						},
					},
					controls = {
						enabled = true,
					},
				})
			end,
		},
		{ "theHamsta/nvim-dap-virtual-text", config = true },
	},
}

function M.init()
	vim.keymap.set("n", "<F5>", function()
		require("dap").continue()
	end, { desc = "Continue Debug" })
	vim.keymap.set("n", "<F7>", function()
		require("dap").step_into()
	end, { desc = "Step Into" })
	vim.keymap.set("n", "<F8>", function()
		require("dap").step_over()
	end, { desc = "Step Over" })
	vim.keymap.set("n", "<F9>", function()
		require("dap").step_out()
	end, { desc = "Step Out" })
	vim.keymap.set("n", "<F10>", function()
		require("dap").run_to_cursor()
	end, { desc = "Run to Cursor" })
	vim.keymap.set("n", "<leader>db", function()
		require("dap").toggle_breakpoint()
	end, { desc = "Toggle Breakpoint" })
	vim.keymap.set("n", "<leader>dB", function()
		require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
	end, { desc = "Set Breakpoint" })
	vim.keymap.set("n", "<leader>de", function()
		require("dapui").float_element()
	end, { desc = "Open Element" })

	vim.keymap.set("n", "<leader>dt", function()
		require("dapui").close()
		require("dap").repl.close()
		local session = require("dap").session()
		if session then
			require("dap").terminate()
		end
		require("nvim-dap-virtual-text").refresh()
	end, { desc = "Terminate Debug" })

	vim.keymap.set("n", "<leader>do", function()
		local session = require("dap").session()
		local command = "-exec source /home/hfu5fe/cp/cp.avp.openimagedebugger/bin/OpenImageDebugger/oid.py"
		session:evaluate(command, function(err)
			if err then
				require("dap.repl").append(err.message)
				return
			end
		end)
		require("dap.repl").append(command)
	end, { desc = "OpenImageDebugger" })

	vim.keymap.set("n", "<leader>dg", function()
		local line = vim.fn.expand("%:line")
		local col = vim.fn.col(".")
		local start_col = vim.fn.search("\\<", "bcn", line .. "c" .. col) + 1
		local end_col = vim.fn.search("\\>", "cn", line .. "c" .. col)
		local grid_input = string.sub(line, start_col, end_col)

		local session = require("dap").session()
		local command = "print " .. grid_input
		session:evaluate(command, function(err)
			if err then
				require("dap.repl").append(err.message)
				return
			end
		end)
		require("dap.repl").append(command)

		command = "-exec print " .. grid_input
		session:evaluate(command, function(err)
			if err then
				require("dap.repl").append(err.message)
				return
			end
		end)
		require("dap.repl").append(command)
	end, { desc = "Load grid" })

	vim.keymap.set("n", "<leader>ds", function()
		local widgets = require("dap.ui.widgets")
		widgets.centered_float(widgets.scopes)
	end, { desc = "Scope" })

	vim.keymap.set("n", "<leader>dh", function()
		local widgets = require("dap.ui.widgets")
		widgets.hover()
	end, { desc = "Hover" })
end

function M.config()
	require("plugins.dap.cpp")
	require("plugins.dap.python")

	require("dap").listeners.after.event_initialized["dapui_config"] = function()
		require("dapui").open()
	end

	local config = require("config")
	vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

	for name, sign in pairs(config.icons.dap) do
		sign = type(sign) == "table" and sign or { sign }
		vim.fn.sign_define(
			"Dap" .. name,
			{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
		)
	end
end

return M
