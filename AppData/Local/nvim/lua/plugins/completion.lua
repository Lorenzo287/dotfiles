return {
	{
		"github/copilot.vim",
		event = "VeryLazy",
		config = function()
			vim.cmd("Copilot disable")
			local copilot_enabled = false

			vim.keymap.set("n", "<leader>c", function()
				if copilot_enabled then
					vim.cmd("Copilot disable")
					copilot_enabled = false
					print("Copilot disabled")
				else
					vim.cmd("Copilot enable")
					copilot_enabled = true
					print("Copilot enabled")
				end
			end, { noremap = true, silent = true, desc = "Toggle Copilot" })
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
	{
		"saghen/blink.cmp",
		event = "VeryLazy",
		-- dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		opts = {
			keymap = { ["<CR>"] = { "accept", "fallback" } },
			appearance = { nerd_font_variant = "mono" }, -- or "normal"
			completion = { menu = { border = "rounded" } },
			sources = { default = { "lsp", "path", "buffer" } }, -- "snippets"
			signature = { enabled = false },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
	},
}
