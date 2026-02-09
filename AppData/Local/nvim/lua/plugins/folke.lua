return {
	{
		"folke/todo-comments.nvim",
		opts = {
			keywords = {
				FIX = { alt = { "FIXED", "BUG" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "󰓅 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				COOL = { icon = " ", color = "error", alt = { "FIGO", "FIGATA" } },
				-- can use HEX for color eg #348d72, but won't folow theme
			},
		},
		-- TODO:
		-- FIX:
		-- NOTE:
		-- WARN:
		-- HACK:
		-- PERF:
		-- TEST:
		-- COOL:
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = false },
			explorer = { enabled = false }, -- neotree alternative
			indent = { enabled = false },
			input = { enabled = false },
			picker = { enabled = false }, -- telescope alternative
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = false }, -- highliht multiple word occurences
		},
	},
	{
		-- :checkhealth which-key to find OVERLAPPING keybindings
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "classic", -- "modern", "helix"
			win = { border = BORDER },
			sort = { "local", "order", "group", "alphanum", "mod" },
		},
	},
}
