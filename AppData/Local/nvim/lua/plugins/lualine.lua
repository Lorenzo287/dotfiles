return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = function()
			vim.api.nvim_set_hl(0, "dCursor", { fg = "#000000", bg = "#e06c75", bold = false })
			local dmode_enabled = false
			vim.api.nvim_create_autocmd("User", {
				pattern = "DebugModeChanged",
				callback = function(args)
					dmode_enabled = args.data.enabled
					require("lualine").refresh()
				end,
			})
			require("lualine").setup({
				options = {
					globalstatus = true,
					disabled_filetypes = { statusline = { "alpha" } },
					always_show_tabline = false,
					component_separators = { left = "|", right = "|" },
					section_separators = { left = "", right = "" },
					-- component_separators = { left = "", right = "" },
					-- section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = {
						{ "tabs", show_modified_status = false },
						{
							"mode",
							fmt = function(str)
								return dmode_enabled and "DEBUG" or str
							end,
							color = function()
								if dmode_enabled then
									return dmode_enabled and "dCursor" or nil
								end
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
				-- tabline = {
				-- 	lualine_a = { { "tabs", mode = 0, path = 0 } },
				-- 	lualine_b = {},
				-- 	lualine_c = {},
				-- 	lualine_x = { "windows" },
				-- 	lualine_y = {},
				-- 	lualine_z = {},
				-- },
			})
		end,
	},
	{
		"willothy/flatten.nvim",
		lazy = false,
		priority = 1001,
		opts = {
			integrations = {
				wezterm = false,
			},
		},
	},
}
