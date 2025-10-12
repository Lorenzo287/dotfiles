return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			auto_install = true,
			highlight = {
				enable = true,
				disable = { "csv" },
			},
			indent = { enbale = true },
			fold = { enable = true },
		})
	end,
}
