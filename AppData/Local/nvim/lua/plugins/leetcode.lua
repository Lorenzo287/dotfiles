return {
	"kawre/leetcode.nvim",
	enabled = false,
	lazy = true,
	build = ":TSUpdate html",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {},
	cmd = "Leet",
}
