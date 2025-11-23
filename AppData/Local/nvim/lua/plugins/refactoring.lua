return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{
			"<leader>rr",
			function()
				require("refactoring").select_refactor({ prefer_ex_cmd = true })
			end,
			mode = { "n", "x" },
			desc = "Refactor",
		},
		{
			"<leader>rp",
			function()
				require("refactoring").debug.printf({ below = false })
			end,
			desc = "Print debug",
		},
		{
			"<leader>rv",
			function()
				require("refactoring").debug.print_var()
			end,
			mode = { "n", "x" },
			desc = "Print variable",
		},
		{
			"<leader>rc",
			function()
				require("refactoring").debug.cleanup()
			end,
			desc = "Cleanup prints",
		},
	},
	opts = {
		prompt_func_return_type = {
			go = true,
			cpp = true,
			c = true,
			java = true,
		},
		prompt_func_param_type = {
			go = true,
			cpp = true,
			c = true,
			java = true,
		},
	},
}
