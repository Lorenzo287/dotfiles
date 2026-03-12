vim.keymap.set("n", "<leader>x", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<c-k>", "<cmd>wincmd k<CR>")
vim.keymap.set("n", "<c-j>", "<cmd>wincmd j<CR>")
vim.keymap.set("n", "<c-h>", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<c-l>", "<cmd>wincmd l<CR>")
local str = string.format
for i = 1, 9 do
	vim.keymap.set("n", str("<A-%s>", i), str("%sgt", i), { desc = str("Goto tab %s", i) })
end
vim.keymap.set("n", "<A-0>", "<cmd>tab split<CR>", { desc = "Clone window in new tab" })
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", function()
	vim.cmd("FloaterminalClose")
	vim.cmd("qa")
end, { desc = "Quit all" })
vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "Exit terminal mode" })
-- vim.keymap.set("n", "<leader>v", "<cmd>e $MYVIMRC<CR>", { desc = "Edit config" })
-- vim.keymap.set({ "n", "v" }, "<leader>o", ":update<CR> :source<CR>", { desc = "Save and source file" })

vim.keymap.set(
	"n",
	"<leader>kc",
	"i#include <stdio.h><CR><CR>int main(void) {<CR>return 0;<CR>}<Esc>kO",
	{ noremap = true, silent = true, desc = "Insert main() C" }
)

vim.keymap.set(
	"n",
	"<leader>kp",
	"i#include <bits/stdc++.h><CR>using namespace std;<CR><CR>int main() {<CR>return 0;<CR>}<Esc>kO",
	{ noremap = true, silent = true, desc = "Insert main() C++" }
)

local function insert_snippet(name)
	local path = vim.fn.stdpath("config") .. "/snippets/" .. name
	vim.api.nvim_put(vim.fn.readfile(path), "l", true, true)
end

vim.keymap.set("n", "<leader>kb", function()
	insert_snippet("nob.c")
end, { desc = "Insert NOB build system" })

vim.keymap.set("n", "<leader>i", function()
	---@diagnostic disable-next-line: undefined-field
	if vim.opt.spell:get() then
		vim.opt.spell = false
		print("Spell check OFF")
	else
		vim.opt.spell = true
		vim.opt.spelllang = { "en" }
		print("Spell check ON")
	end
end, { desc = "Toggle spell check" })
-- ]s  Jump to next misspelled word
-- [s  Jump to previous misspelled word
-- z=  Show spelling suggestions
-- zg  Mark word as good (add to dictionary)
-- zw  Mark word as wrong
-- zug Undo 'good' word (remove from dictionary)
