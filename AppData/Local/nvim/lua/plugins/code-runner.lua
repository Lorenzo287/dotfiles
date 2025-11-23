return {
	{
		"CRAG666/code_runner.nvim",
		event = "VeryLazy",
		config = function()
			require("code_runner").setup({
				mode = "float",
				float = { border = "rounded" },
				filetype = {
					lua = { "lua" },
				},
			})
			vim.keymap.set("n", "<leader><CR>", "<cmd>RunCode<CR>", { desc = "Run code" })
		end,
	},
	{
		"CRAG666/betterTerm.nvim",
		event = "VeryLazy",
	},
}
