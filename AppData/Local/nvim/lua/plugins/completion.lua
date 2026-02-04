return {
	{
		"saghen/blink.cmp",
		event = "VeryLazy",
		-- dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		opts = {
			keymap = {
				["<CR>"] = { "accept", "fallback" },
				["<C-e>"] = { "show", "hide", "fallback" }, --"show_documentation", "hide_documentation"
				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},
			appearance = { nerd_font_variant = "normal" }, -- "mono"

			completion = {
				menu = {
					border = BORDER,
					auto_show = false,
					draw = { treesitter = { "lsp" } },
				},
				documentation = {
					window = { border = BORDER },
					auto_show = false,
					auto_show_delay_ms = 0,
				},
				-- don't select by default, insert without CR after selection
				-- list = { selection = { preselect = false, auto_insert = true } },
			},
			signature = {
				window = {
					border = BORDER,
					show_documentation = false,
				},
				enabled = true,
				trigger = { enabled = false }, -- does not show automatically
			},

			sources = { default = { "lsp", "path", "buffer" } }, -- "snippets"
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
	},
	{
		"github/copilot.vim",
		lazy = true,
		keys = {
			{
				"<leader>y",
				function()
					if vim.g.copilot_enabled then
						vim.cmd("Copilot disable")
						vim.g.copilot_enabled = false
						print("Copilot disabled")
					else
						vim.cmd("Copilot enable")
						vim.g.copilot_enabled = true
						print("Copilot enabled")
					end
				end,
				desc = "Toggle Copilot",
			},
		},
		init = function()
			vim.g.copilot_enabled = false
		end,
	},
	-- {
	-- 	"Exafunction/windsurf.nvim",
	-- 	keys = {
	-- 		{ "<leader>c", "<cmd>Codeium Toggle<CR>", desc = "Toggle Codeium" },
	-- 	},
	-- 	config = function()
	-- 		require("codeium").setup({
	-- 			enable_cmp_source = false,
	-- 			virtual_text = { enabled = true },
	-- 		})
	-- 	end,
	-- },
}
