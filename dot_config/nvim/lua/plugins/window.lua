return {
	{
		"pogyomo/winresize.nvim",
		config = function()
			local resize = function(win, amt, dir)
				return function()
					require("winresize").resize(win, amt, dir)
				end
			end
			vim.keymap.set("n", "<Left>", resize(0, 2, "left"))
			vim.keymap.set("n", "<Down>", resize(0, 2, "down"))
			vim.keymap.set("n", "<Up>", resize(0, 2, "up"))
			vim.keymap.set("n", "<Right>", resize(0, 2, "right"))
		end,
	},
	{
		"shortcuts/no-neck-pain.nvim",
		version = "*",
		config = function()
			require("no-neck-pain").setup({
				width = 95,
				buffers = {
					-- scratchPad = {
					-- 	enabled = true, -- autosaving
					-- 	location = nil, -- current working dir
					-- },
					-- bo = {
					-- 	filetype = "md",
					-- },
					wo = {
						fillchars = "eob: ",
					},
					right = {
						enabled = false,
					},
				},
			})
			vim.keymap.set("n", "<leader>z", "<cmd>NoNeckPain<CR>", { desc = "Toggle Noneckpain" })
		end,
	},
}
