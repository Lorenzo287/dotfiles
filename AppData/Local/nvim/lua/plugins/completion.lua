return {
	-- {
	-- 	"github/copilot.vim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		vim.cmd("Copilot disable")
	-- 		local copilot_enabled = false
	--
	-- 		vim.keymap.set("n", "<leader>c", function()
	-- 			if copilot_enabled then
	-- 				vim.cmd("Copilot disable")
	-- 				copilot_enabled = false
	-- 				print("Copilot disabled")
	-- 			else
	-- 				vim.cmd("Copilot enable")
	-- 				copilot_enabled = true
	-- 				print("Copilot enabled")
	-- 			end
	-- 		end, { noremap = true, silent = true, desc = "Toggle Copilot" })
	-- 	end,
	-- },
	{
		{
			"Exafunction/windsurf.nvim",
			cmd = { "Codeium Toggle" },
			config = function()
				require("codeium").setup({
					enable_cmp_source = false,
					virtual_text = { enabled = true },
				})
			end,
			vim.keymap.set("n", "<leader>c", function()
				local lazy = require("lazy")
				local cfg = require("lazy.core.config")
				local plugin = cfg.plugins["windsurf.nvim"]

				if not plugin or not plugin._.loaded then
					lazy.load({ plugins = { "windsurf.nvim" } })
					-- defer toggle slightly to allow command registration
					vim.defer_fn(function()
						vim.cmd("Codeium Toggle")
					end, 100)
				else
					vim.cmd("Codeium Toggle")
				end
			end, { desc = "Toggle Codeium" }),
		},
	},
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
			signature = { enabled = true },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
	},
}
