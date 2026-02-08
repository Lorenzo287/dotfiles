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
		-- must manually copy queries to nvim/queries/autohotkey/*.scm
		require("nvim-treesitter.parsers").get_parser_configs().autohotkey = {
			install_info = {
				url = "https://github.com/alfredomtx/tree-sitter-autohotkey",
				files = { "src/parser.c", "src/scanner.c" },
				branch = "master",
			},
			filetype = "autohotkey",
		}
		-- fallback to native nvim indentation
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "autohotkey",
			callback = function()
				vim.bo.indentexpr = ""
			end,
		})
	end,
}
