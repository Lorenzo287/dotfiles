return {
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		config = function()
			local themes = require("themes")
			themes.load_last_theme() -- can pass a fallback
			themes.setup_autocmd()
			themes.setup_usercmd()
		end,
	},

	{ "ellisonleao/gruvbox.nvim", lazy = true },
	{ "folke/tokyonight.nvim", lazy = true },
	{ "catppuccin/nvim", name = "catppuccin", lazy = true },
	{ "navarasu/onedark.nvim", lazy = true },
	-- { "olimorris/onedarkpro.nvim", lazy = true },
	{ "mofiqul/dracula.nvim", lazy = true },
	{ "rose-pine/neovim", name = "rose-pine", lazy = true },
	{ "scottmckendry/cyberdream.nvim", lazy = true },
	{ "Mofiqul/vscode.nvim", lazy = true },
	{ "everviolet/nvim", name = "evergarden", lazy = true },
	{ "craftzdog/solarized-osaka.nvim", lazy = true },
	{ "vague-theme/vague.nvim", lazy = true },
	{ "https://codeberg.org/ericrulec/gruber-darker.nvim", lazy = true },
	-- { "blazkowolf/gruber-darker.nvim", lazy = true },

	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			user_default_options = {
				names = false,
			},
		},
	},
}
