return {
	{
		"benlubas/molten-nvim",
		event = "VeryLazy",
		build = ":UpdateRemotePlugins",
		dependencies = "willothy/wezterm.nvim",
		init = function()
			-- this config works with wezterm on Windows,
			-- on POSIX images can be shown directly inside nvim
			vim.g.molten_auto_open_output = false -- cannot be true if molten_image_provider = "wezterm"
			vim.g.molten_output_show_more = true
			vim.g.molten_image_provider = "wezterm" -- image.nvim does not work on windows
			vim.g.molten_output_virt_lines = true
			vim.g.molten_split_direction = "right" -- "left", "top", "bottom"
			vim.g.molten_split_size = 40 -- 0-100% size of the screen dedicated to the output window
			vim.g.molten_virt_text_output = true
			vim.g.molten_use_border_highlights = true
			vim.g.molten_virt_lines_off_by_1 = true
			vim.g.molten_auto_image_popup = false
			vim.g.molten_output_win_zindex = 50

			vim.keymap.set("n", "<leader>mi", function()
				local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
				if venv ~= nil then
					local name = venv:match("([^/\\]+)$") -- works on Windows and POSIX
					vim.cmd(("MoltenInit %s"):format(name))
				else
					vim.cmd("MoltenInit python3")
				end
			end, { desc = "Molten Initialize", silent = true })

			vim.keymap.set(
				"n",
				"<leader>me",
				":MoltenEvaluateOperator<CR>",
				{ silent = true, desc = "Molten Eval operator" }
			)
			vim.keymap.set("n", "<leader>m<CR>", function()
				vim.cmd("MoltenEvaluateOperator")
				vim.schedule(function()
					-- press i (inside) h (cell object befined by mini.ai)
					local keys = vim.api.nvim_replace_termcodes("ih", true, false, true)
					vim.api.nvim_feedkeys(keys, "m", false)
				end)
			end, { silent = true, desc = "Molten Eval cell" })
			vim.keymap.set("n", "<leader>ml", ":MoltenEvaluateLine<CR>", { silent = true, desc = "Molten Eval line" })
			vim.keymap.set(
				"n",
				"<leader>mr",
				":MoltenReevaluateCell<CR>",
				{ silent = true, desc = "Molten Re-eval cell" }
			)
			vim.keymap.set(
				"v",
				"<leader>mv",
				":<C-u>MoltenEvaluateVisual<CR>gv",
				{ silent = true, desc = "Molten Eval visual selection" }
			)
			vim.keymap.set("n", "<leader>mc", ":MoltenDelete<CR>", { silent = true, desc = "Molten Clear cell" })
			vim.keymap.set("n", "<leader>mp", ":MoltenImagePopup<CR>", { silent = true, desc = "Molten Popup" })
			-- vim.keymap.set("n", "<leader>mh", ":MoltenHideOutput<CR>", { silent = true, desc = "Molten Hide output" })
			-- vim.keymap.set(
			-- 	"n",
			-- 	"<leader>mo",
			-- 	":noautocmd MoltenEnterOutput<CR>",
			-- 	{ silent = true, desc = "Molten Show output" }
			-- )
		end,
	},
	{
		"GCBallesteros/NotebookNavigator.nvim",
		event = "VeryLazy",
		config = function()
			local nn = require("notebook-navigator")
			nn.setup({
				cell_markers = {
					-- python = "## %%",
				},
			})

			-- highlight ## separator
			require("mini.hipatterns").setup({
				highlighters = { cells = nn.minihipatterns_spec },
			})
			-- create new obj (eg can do 'dah' for cells like 'dap' for paragraphs)
			require("mini.ai").setup({
				custom_textobjects = { h = nn.miniai_spec },
			})
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			code = {
				language = false, -- show language header
				style = "language", -- disable codeblock highlighting
			},
		},
		keys = {
			{
				"<leader>md",
				"<cmd>RenderMarkdown toggle<CR>",
				desc = "Toggle RenderMarkdown",
			},
		},
	},
}
