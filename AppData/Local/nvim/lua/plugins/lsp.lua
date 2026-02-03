return {
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		config = function()
			require("mason").setup({
				ui = {
					border = BORDER,
					backdrop = 100,
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = "VeryLazy",
		opts = {
			-- this is not needed to use an lsp, once installed manually form Mason it works automatically
			-- this is useful when importing this config to a new computer to install lsp automatically
			ensure_installed = {
				"clangd", -- C server

				"lua_ls", -- Lua server
				"stylua", -- Lua format

				"ts_ls", -- JS server

				"tinymist", -- Typst server

				"ty", -- Py server
				"ruff", -- Py lint, format
				-- "pyright", -- Py server
				-- "black", -- Py format
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			vim.lsp.set_log_level("off")
			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--background-index",
					-- "--compile-commands-dir=" .. vim.fn.getcwd(),
				},
			})

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			vim.keymap.set("n", "<leader>lk", function()
				vim.lsp.buf.hover({ border = BORDER })
			end, { desc = "LSP Hover" })
			vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "LSP Go to definition" })
			-- vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { desc = "LSP References" })
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP Code actions" })
			vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "LSP Rename" })
			vim.keymap.set("n", "<leader>ll", function()
				if vim.diagnostic.is_enabled() then
					vim.diagnostic.disable()
					print("Diagnostics disabled")
				else
					vim.diagnostic.enable()
					print("Diagnostics enabled")
				end
			end, { desc = "LSP Toggle" })
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		event = "VeryLazy",
		config = function()
			local null_ls = require("null-ls")

			-- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins
			null_ls.setup({
				border = BORDER,
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.prettier,
					-- null_ls.builtins.formatting.black,

					-- null_ls.builtins.diagnostics.cppcheck.with({
					-- 	extra_args = function(params)
					-- 		return {
					-- 			params.bufname,
					-- 			"--suppress=normalCheckLevelMaxBranches",
					-- 			"--inline-suppr",
					-- 			"--template=gcc",
					-- 		}
					-- 	end,
					-- }),
				},
			})
			vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format file" })
		end,
	},
}
