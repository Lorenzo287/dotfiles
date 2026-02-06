return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	-- must use .setup() to enable the plugin,
	-- opts = {} won't work by itself
	config = function()
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			highlight = {
				enable = true,
				disable = { "csv" },
			},
			indent = { enable = true },
			fold = { enable = true },
		})
	end,
}
