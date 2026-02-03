return {
	{
		"CRAG666/code_runner.nvim",
		event = "VeryLazy",
		dependencies = {
			-- "CRAG666/betterTerm.nvim", -- for better_term mode
		},
		config = function()
			require("code_runner").setup({
				mode = "term", -- term, tab, float, toggle, vimux, better_term
				term = {
					position = "below",
					-- "bot" goes over center.lua,
					-- "below is aligned to current buffer
				},
				float = { border = BORDER },
				filetype = {
					lua = { "lua54" }, -- by default uses nvim api
					python = "python", -- default is unbuffered (-u)
				},
			})
			vim.keymap.set("n", "<leader><CR>", "<cmd>RunCode<CR>", { desc = "Run code" })
		end,
	},
	{
		"ej-shafran/compile-mode.nvim",
		version = "^5.0.0",
		branch = "latest",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- { "m00qek/baleia.nvim", tag = "v1.3.0" },
		},
		config = function()
			vim.g.compile_mode = {
				input_word_completion = true,
				default_command = "",
				baleia_setup = false,
				-- replace special characters (e.g. `%`) to behave more like `:!`
				bang_expansion = false,
				-- auto_jump_to_first_error = false,
			}
			vim.keymap.set("n", "<leader>c", "<cmd>below Compile<CR>", { desc = "Compile Mode" })
		end,
	},
}
