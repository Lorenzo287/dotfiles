return {
	"chomosuke/typst-preview.nvim",
	lazy = false, -- or ft = 'typst'
	version = "1.*",
	opts = {}, -- lazy.nvim will implicitly calls `setup {}`
	vim.keymap.set("n", "<leader>pt", "<cmd>TypstPreview<CR>", { desc = "Typst Preview" }),
	vim.keymap.set("n", "<leader>pf", "<cmd>!firefox %<CR>", { desc = "Firefox Preview" }),
}
