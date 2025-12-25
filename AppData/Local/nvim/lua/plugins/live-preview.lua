return {
	"brianhuster/live-preview.nvim",
	event = "BufReadPre",
	opts = {
		browser = "firefox",
		picker = "telescope",
	},
	vim.keymap.set("n", "<leader>pf", "<cmd>LivePreview start<CR>", { desc = "Live Preview" }),
}
