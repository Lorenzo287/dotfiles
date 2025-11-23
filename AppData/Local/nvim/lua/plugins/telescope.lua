return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"debugloop/telescope-undo.nvim",
		},
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>tf", builtin.find_files, { desc = "Telescope Find Files" })
			vim.keymap.set("n", "<leader>tg", builtin.live_grep, { desc = "Telescope Live Grep" })
			vim.keymap.set("n", "<leader>tc", builtin.colorscheme, { desc = "Telescope Colorscheme" })
			vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "LSP Document Symbols" })
			vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "LSP References" })
			vim.keymap.set("n", "<leader>le", builtin.diagnostics, { desc = "LSP Diagnostics" })
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				extensions = {
					undo = {},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			-- telescope.load_extension("refactoring")
			-- telescope.load_extension("undo")
			-- vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
			telescope.load_extension("ui-select")
			telescope.load_extension("ascii")
		end,
	},
}
