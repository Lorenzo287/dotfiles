return {
	{
		-- this is a remote plugin, may need to run :UpdateRemotePlugins after update,
		-- see https://github.com/benlubas/molten-nvim/blob/main/docs/Windows.md
		"benlubas/molten-nvim",
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
			vim.g.molten_virt_lines_off_by_1 = false
			vim.g.molten_auto_image_popup = false
			vim.g.molten_output_win_zindex = 50
		end,
		keys = {
			-- keys that load the plugin
			{
				"<leader>mi",
				function()
					local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
					local name = venv and venv:match("([^/\\]+)$") or "python3"
					vim.cmd(("MoltenInit %s"):format(name))
				end,
				desc = "Molten Initialize",
			},
			{ "<leader>ms", ":MoltenInit<CR>", desc = "Molten Select" },
			{ "<leader>me", ":MoltenEvaluateOperator<CR>", desc = "Molten Eval operator" },
			{ "<leader>ml", ":MoltenEvaluateLine<CR>", desc = "Molten Eval line" },
			{
				"<leader>mv",
				":<C-u>MoltenEvaluateVisual<CR>gv",
				mode = { "v" },
				desc = "Molten Eval visual selection",
			},
			{
				"<leader>m<CR>",
				function()
					vim.cmd("MoltenEvaluateOperator")
					vim.schedule(function()
						-- press i (inside) h (cell object befined by mini.ai)
						local keys = vim.api.nvim_replace_termcodes("ih", true, false, true)
						vim.api.nvim_feedkeys(keys, "m", false)
					end)
				end,
				desc = "Molten Eval cell",
			},
		},
		config = function()
			-- keys defined post-loading
			vim.keymap.set(
				"n",
				"<leader>mr",
				":MoltenReevaluateCell<CR>",
				{ silent = true, desc = "Molten Re-eval cell" }
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

			local notebook = require("mini_notebook")
			-- create new obj (eg can do 'dah' for cells like 'dap' for paragraphs)
			require("mini.ai").setup({
				custom_textobjects = {
					h = function()
						return notebook.miniai_spec("i", { python = "# %%", lua = "-- %%" })
					end,
				},
			})
			-- highlight # %% separator
			require("mini.hipatterns").setup({
				highlighters = {
					notebook_cells = notebook.minihipatterns_spec({ python = "# %%", lua = "-- %%" }, "Folded"),
				},
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
