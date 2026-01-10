return {
	"ej-shafran/compile-mode.nvim",
	version = "^5.0.0",
	branch = "latest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "m00qek/baleia.nvim", tag = "v1.3.0" },
	},
	config = function()
		vim.g.compile_mode = {
			input_word_completion = true,
			default_command = "",
			baleia_setup = true,
			-- replace special characters (e.g. `%`) to behave more like `:!`
			bang_expansion = false,
			-- auto_jump_to_first_error = false,
		}
		vim.keymap.set("n", "<leader>c", "<cmd>below Compile<CR>", { desc = "Compile Mode" })
	end,
}
