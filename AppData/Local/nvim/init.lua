-- --------------------
--  Global Variables
-- --------------------
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.have_nerd_font = true
vim.g.python3_host_prog = vim.fn.expand("~/AppData/local/nvim/nvim_venv/Scripts/python")

-- border can be set globally with vim.opt but not every plugin supports it,
-- better to use a global variable for convenience
BORDER = "bold" -- "bold", "shadow", "rounded", "single", "double", "solid", "none"

-- --------------------
--  Options
-- --------------------
vim.opt.winborder = BORDER

-- vim.cmd([[set mouse=]])
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.cursorcolumn = false
vim.o.cursorline = false
vim.opt.ignorecase = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"
vim.opt.mouse = "a"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.scrolloff = 10
vim.opt.confirm = true
-- vim.opt.shell = "pwsh -NoLogo"

-- "za" to fold
vim.wo.foldenable = true
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldlevel = 99
vim.wo.foldcolumn = "0"

-- global clipboard
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- --------------------
--  Keymaps
-- --------------------
vim.keymap.set("n", "<leader>x", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<c-k>", "<cmd>wincmd k<CR>")
vim.keymap.set("n", "<c-j>", "<cmd>wincmd j<CR>")
vim.keymap.set("n", "<c-h>", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<c-l>", "<cmd>wincmd l<CR>")
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", function()
	vim.cmd("CloseFloaterminal")
	vim.cmd("wqa")
end, { desc = "Quit all" })
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

-- --------------------
--  Autocmds
-- --------------------
require("autocmd")

-- --------------------
--  Plugins
-- --------------------
require("config.lazy")
require("terminal")
require("cheat-sh")

-- --------------------
--  Neovide
-- --------------------
require("neovide")
