return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			highlight = {
				enable = true,
				disable = { "csv" },
			},
			indent = { enable = true },
			fold = { enable = true },
		})

		require("nvim-treesitter.parsers").get_parser_configs().autohotkey = {
			install_info = {
				-- make the repo public to be able to connect
				url = "https://github.com/Lorenzo287/tree-sitter-autohotkey.git",
				files = { "src/parser.c", "src/scanner.c" },
				branch = "master",
			},
			filetype = "autohotkey",
		}
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

		require("nvim-treesitter.parsers").get_parser_configs().toyforth = {
			install_info = {
				url = "C:/Users/ltumi/OneDrive/CLOUD/CODE/C/antirez/toy_forth/tools/tree-sitter-toyforth",
				files = { "src/parser.c" },
				branch = "main",
			},
			filetype = "toyforth",
		}
		-- must manually copy queries to ~/AppData/Local/nvim/queries/toyforth/*.scm,
		-- alternatively add the repo to the nvim run time path
		vim.opt.rtp:append("C:/Users/ltumi/OneDrive/CLOUD/CODE/C/antirez/toy_forth/tools/tree-sitter-toyforth")
		vim.filetype.add({
			extension = {
				fth = "toyforth",
				tf = "toyforth",
			},
		})
	end,
}
