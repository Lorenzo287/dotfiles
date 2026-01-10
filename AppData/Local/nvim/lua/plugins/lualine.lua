return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	config = function()
		local dmode_enabled = false
		vim.api.nvim_create_autocmd("User", {
			pattern = "DebugModeChanged",
			callback = function(args)
				dmode_enabled = args.data.enabled
			end,
		})
		require("lualine").setup({
			options = {
				globalstatus = true,
				disabled_filetypes = { statusline = { "alpha" } },
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
				-- component_separators = { left = "", right = "" },
				-- section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return dmode_enabled and "DEBUG" or str
						end,
						color = function(tb)
							return dmode_enabled and "dCursor" or tb
						end,
					},
				},
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
