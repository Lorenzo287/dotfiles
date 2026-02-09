return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			-- "debugloop/telescope-undo.nvim",
		},
		config = function()
			local telescope = require("telescope")

			local function get_border_chars(style)
				local borders = {
					none = { " ", " ", " ", " ", " ", " ", " ", " " },
					single = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					double = { "═", "║", "═", "║", "╔", "╗", "╝", "╚" },
					rounded = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					bold = { "━", "┃", "━", "┃", "┏", "┓", "┛", "┗" },
					solid = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
				}
				return borders[style] or borders.rounded
			end
			local border_style = BORDER or "rounded"
			local selected_border = get_border_chars(border_style)

			telescope.setup({
				defaults = {
					borderchars = selected_border,
					sorting_strategy = "ascending",
					layout_config = {
						prompt_position = "top",
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							borderchars = selected_border,
						}),
					},
				},
			})

			telescope.load_extension("ui-select")
			telescope.load_extension("ascii")
			-- telescope.load_extension("undo")
			-- telescope.load_extension("refactoring")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>tf", builtin.find_files, { desc = "Telescope Find files" })
			vim.keymap.set("n", "<leader>tg", builtin.live_grep, { desc = "Telescope Live grep" })
			vim.keymap.set("n", "<leader>tc", builtin.colorscheme, { desc = "Telescope Colorscheme" })
			vim.keymap.set("n", "<leader>tk", builtin.keymaps, { desc = "Telescope Keymaps" })
			vim.keymap.set("n", "<leader>ta", "<cmd>Telescope ascii<CR>", { desc = "Telescope Ascii" })
			vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "LSP Document symbols" })
			vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "LSP References" })
			vim.keymap.set("n", "<leader>le", builtin.diagnostics, { desc = "LSP Diagnostics" })
			-- vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<CR>", { desc = "Telescope Undo" })
		end,
	},
}
