return {
	{
		"MaximilianLloyd/ascii.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim", -- ":lua require("ascii").preview()"
		},
	},
	{
		"goolord/alpha-nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.startify")
			dashboard.file_icons.provider = "devicons" -- default is mini.icons
			local ascii = require("ascii")

			-- dashboard.section.header.val = ascii.art.text.neovim.sharp
			dashboard.section.header.val = ascii.art.text.neovim.bloody
			-- dashboard.section.header.val = ascii.art.text.neovim.ansi_shadow
			-- dashboard.section.header.val = ascii.art.text.neovim.slant_relief
			-- dashboard.section.header.val = ascii.art.planets.planets.saturn
			-- dashboard.section.header.val = ascii.get_random("text", "neovim")

			alpha.setup(dashboard.opts)
		end,
	},
}
