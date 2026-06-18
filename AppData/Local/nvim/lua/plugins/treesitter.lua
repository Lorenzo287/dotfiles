return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		local function add_custom_parsers()
			local parsers = require("nvim-treesitter.parsers")

			parsers.autohotkey = {
				install_info = {
					-- make the repo public to be able to connect
					url = "https://github.com/Lorenzo287/tree-sitter-autohotkey.git",
					branch = "master",
				},
			}

			parsers.toyforth = {
				install_info = {
					path = "C:/toy/tree-sitter-toyforth",
				},
			}
		end

		add_custom_parsers()
		vim.api.nvim_create_autocmd("User", {
			pattern = "TSUpdate",
			callback = add_custom_parsers,
		})

		vim.treesitter.language.register("autohotkey", "autohotkey")

		-- must manually copy queries to ~/AppData/Local/nvim/queries/autohotkey/*.scm
		-- the default folder managed by treesitter should not be used
		-- ( ~/AppData/Local/nvim-data/lazy/nvim-treesitter/queries/autohotkey/*.scm )

		-- fallback to native nvim indentation
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "autohotkey",
			callback = function(args)
				vim.bo[args.buf].indentexpr = ""
			end,
		})

		vim.treesitter.language.register("toyforth", "toy")
		-- Add queries to runtime path
		vim.opt.rtp:append("C:/toy/tree-sitter-toyforth")

		vim.api.nvim_create_autocmd("FileType", {
			desc = "Enable Treesitter highlighting, indentation, and folds",
			group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
			callback = function(args)
				if vim.bo[args.buf].filetype == "csv" then
					return
				end

				local ok = pcall(vim.treesitter.start, args.buf)
				if not ok then
					return
				end

				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				vim.wo.foldmethod = "expr"
				vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			end,
		})
	end,
}
