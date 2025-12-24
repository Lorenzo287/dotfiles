return {
	{
		-- TODO:
		-- FIX:
		-- NOTE:
		-- WARN:
		-- HACK:
		-- PERF:
		-- TEST:
		-- COOL:
		"folke/todo-comments.nvim",
		opts = {
			keywords = {
				FIX = { alt = { "FIXED" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "󰓅 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
				COOL = { icon = " ", color = "error", alt = { "FIGO", "FIGATA" } },
				-- can use HEX for color eg #348d72, but won't folow theme
			},
		},
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = false },
			explorer = { enabled = false }, -- neotree alternative
			indent = { enabled = false },
			input = { enabled = true },
			picker = { enabled = false }, -- telescope alternative
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = false }, -- highliht multiple word occurences
		},
	},
}
