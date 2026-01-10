return {
	-- { "rcarriga/nvim-dap-ui", enabled = false },
	{
		"miroshQa/debugmaster.nvim",
		event = "VeryLazy",
		dependencies = {
			"mfussenegger/nvim-dap",
		},
		config = function()
			local dm = require("debugmaster")
			vim.keymap.set({ "n", "v" }, "<leader>d", dm.mode.toggle, { nowait = true, desc = "Toggle Debugmaster" })
			dm.plugins.osv_integration.enabled = false -- needed if you want to debug neovim lua code

			-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
			local dap = require("dap")
			dap.adapters.gdb = {
				type = "executable",
				command = "gdb",
				args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
			}
			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = vim.fn.stdpath("data") .. "/mason/bin/codelldb.cmd",
					args = { "--port", "${port}" },
					detached = false,
				},
			}
			dap.configurations.c = {
				{
					name = "Launch codelldb",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					args = {},
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
				-- gdb does not work well on windows, terminal opens in a separate window
				{
					name = "Launch gdb",
					type = "gdb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					args = {},
					cwd = "${workspaceFolder}",
					console = "integratedTerminal",
					stopAtBeginningOfMainSubprogram = false,
				},
			}
			dap.configurations.cpp = dap.configurations.c
			dap.configurations.rust = dap.configurations.c
		end,
	},
}
