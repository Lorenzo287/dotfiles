return {
	{
		"CRAG666/code_runner.nvim",
		event = "VeryLazy",
		config = function()
			require("code_runner").setup({
				mode = "term", -- tab, float, better_term, toggle, vimux
				term = {
					position = "below",
					-- "bot" goes over center.lua,
					-- "below is aligned to current buffer
				},
				float = { border = BORDER },
				filetype = {
					lua = { "lua" },
					python = "python", -- default is unbuffered (-u)
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
