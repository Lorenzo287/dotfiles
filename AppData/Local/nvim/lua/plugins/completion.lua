return {
	{
		"saghen/blink.cmp",
		event = "VeryLazy",
		-- dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		opts = {
			keymap = {
				["<CR>"] = { "accept", "fallback" },
				["<C-e>"] = { "show", "show_documentation", "hide_documentation" }, -- "hide" for toggle behavior
				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},
			appearance = { nerd_font_variant = "normal" }, -- "mono"

			completion = {
				menu = {
					border = BORDER,
					auto_show = false, -- for buffers
					draw = { treesitter = { "lsp" } },
				},
				documentation = {
					window = { border = BORDER },
					auto_show = false,
					auto_show_delay_ms = 0,
				},
				list = {
					selection = {
						preselect = true, -- open with first item selected
						auto_insert = false, -- insert without CR after selection
					},
				},
			},
			signature = {
				window = {
					border = BORDER,
					show_documentation = false,
				},
				enabled = true,
				trigger = { enabled = false }, -- does not show automatically
			},
			cmdline = {
				completion = {
					menu = {
						auto_show = true, -- for cmdline
					},
				},
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
