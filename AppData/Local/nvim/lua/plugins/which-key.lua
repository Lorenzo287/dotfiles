return {
	-- :checkhealth which-key to find OVERLAPPING keybindings
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		sort = { "local", "order", "group", "alphanum", "mod" },
	},
	-- keys = {
	-- 	{
	-- 		"<leader>?",
	-- 		function()
	-- 			require("which-key").show({ global = false })
	-- 		end,
	-- 		desc = "Buffer Local Keymaps (which-key)",
	-- 	},
	-- },
}
