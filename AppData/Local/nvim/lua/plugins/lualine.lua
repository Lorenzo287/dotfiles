return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	config = function()
		vim.opt.laststatus = 3 -- enables global statusline
		require("lualine").setup({
			options = {
				disabled_filetypes = { statusline = { "alpha" } },
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
				-- component_separators = { left = "", right = "" },
				-- section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = { "filename", "filesize" },
				lualine_x = { "filetype" },
				lualine_y = {
					"diagnostics",
					{
						"lsp_status",
						icon = "",
						symbols = { separator = " | ", done = "" },
						ignore_lsp = { "null-ls" },
					},
				},
				lualine_z = { "progress", "location" },
			},
		})
	end,
}
