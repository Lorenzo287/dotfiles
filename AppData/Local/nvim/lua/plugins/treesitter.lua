return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	-- must use .setup() to enable the plugin,
	-- opts = {} won't work by itself
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
		-- must manually copy queries to ~/AppData/Local/nvim/queries/autohotkey/*.scm
		-- the default folder managed by treesitter should not be used
		-- ~/AppData/Local/nvim-data/lazy/nvim-treesitter/queries/autohotkey/*.scm
		require("nvim-treesitter.parsers").get_parser_configs().autohotkey = {
			install_info = {
				-- make the repo public to be able to connect
				url = "https://github.com/Lorenzo287/tree-sitter-autohotkey.git",
				files = { "src/parser.c", "src/scanner.c" },
				branch = "master",
			},
			filetype = "autohotkey",
		}
		-- fallback to native nvim indentation
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "autohotkey",
			callback = function(args)
				vim.bo[args.buf].indentexpr = ""
			end,
		})
	end,
}
