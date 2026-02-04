return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		vim.keymap.set("n", "<leader>N", "<cmd>Neotree toggle left<CR>", { desc = "Toggle Neotree left" })
		vim.keymap.set("n", "<leader>n", "<cmd>Neotree toggle right<CR>", { desc = "Toggle Neotree right" })
		vim.keymap.set(
			"n",
			"<leader>lS",
			"<cmd>Neotree document_symbols right<CR>",
			{ desc = "LSP Document symbols (neo-tree)" }
		)

		local maps = require("delete")
		require("neo-tree").setup({
			log_to_file = false,
			sources = {
				"filesystem",
				"buffers",
				"git_status",
				"document_symbols",
			},
			source_selector = {
				winbar = false,
			},
			-- "bold" and others are not among the defaults,
			-- throws an ERROR in checkhealth but still works
			popup_border_style = BORDER,
			filesystem = {
				filtered_items = {
					visible = true,
					-- Uncomment these if you don't want to see them gray
					-- hide_dotfiles = false,
					-- hide_gitignored = false,
				},
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
				window = {
					mappings = {
						["d"] = maps.delete,
					},
				},
			},
			window = {
				width = 30, -- default 40
				mappings = { ["<C-r>"] = "" }, -- suppress warning
			},
		})
	end,
}
