vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	desc = "Setup Jupytext and open py file",
	pattern = "*.ipynb",
	callback = function(args)
		if vim.bo.filetype == "python" then
			return
		end
		local base = vim.fn.fnamemodify(args.file, ":r")
		local pyfile = base .. ".py"
		if vim.fn.filereadable(pyfile) == 0 then
			vim.fn.jobstart({
				"jupytext",
				"--set-formats",
				"ipynb,py:hydrogen,md:markdown",
				args.file,
			}, {
				on_exit = function()
					vim.schedule(function()
						vim.cmd("edit " .. pyfile)
					end)
					-- vim.notify("Jupytext paired: py + md", vim.log.levels.INFO)
				end,
			})
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	desc = "Sync notebooks on save",
	pattern = { "*.py", "*.md", "*.ipynb" },
	callback = function(args)
		local ext = vim.fn.expand("%:e")
		if ext ~= "ipynb" and vim.fn.filereadable(vim.fn.expand("%:r") .. ".ipynb") == 0 then
			return
		end
		vim.fn.jobstart({
			"jupytext",
			"--sync",
			args.file,
		}, { detach = true })
	end,
})

local augroup = vim.api.nvim_create_augroup("numbertoggle", {})

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
	desc = "Switch to relative numbers",
	group = augroup,
	callback = function()
		if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
			vim.opt.relativenumber = true
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
	desc = "Switch to absolute numbers",
	group = augroup,
	callback = function()
		if vim.o.nu then
			vim.opt.relativenumber = false
			-- Redraw fix for specific command types
			if not vim.tbl_contains({ "@", "-" }, vim.v.event.cmdtype) then
				vim.cmd("redraw")
			end
		end
	end,
})

vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
	desc = "Sync terminal background",
	callback = function()
		local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
		if normal.bg then
			io.stdout:write(string.format("\027]11;#%06x\007", normal.bg))
		end
	end,
})

-- does not work reliably
vim.api.nvim_create_autocmd({ "UILeave", "VimSuspend" }, {
	desc = "Reset terminal background on exit",
	callback = function()
		io.stdout:write("\027]111\007")
	end,
})

-- change highlight color of floating window (background, border, title)
-- vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
-- vim.cmd("highlight FloatBorder guibg=NormalFloat")
-- vim.cmd("highlight FloatTitle guibg=NormalFloat")
