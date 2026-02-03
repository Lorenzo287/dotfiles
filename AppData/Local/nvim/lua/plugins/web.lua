return {
	{
		"brianhuster/live-preview.nvim",
		ft = "html",
		opts = {
			browser = "firefox",
			picker = "telescope",
		},
		vim.keymap.set("n", "<leader>pf", "<cmd>LivePreview start<CR>", { desc = "Live preview" }),
	},
	{
		"windwp/nvim-ts-autotag",
		ft = "html",
		opts = {
			per_filetype = {
				["html"] = {
					enable_close = true,
					enable_rename = true,
				},
			},
		},
	},
}
