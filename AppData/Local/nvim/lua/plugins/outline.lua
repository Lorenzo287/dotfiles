return {
	"hedyhli/outline.nvim",
	enabled = false,
	lazy = true,
	cmd = { "Outline", "OutlineOpen" },
	keys = { -- Example mapping to toggle outline
		{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle Outline" },
	},
	opts = {
		outline_window = {
			position = "left",
		},
	},
}
