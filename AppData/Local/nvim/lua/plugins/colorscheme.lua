return {
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		config = function()
			-- Path to store last used colorscheme
			local last_theme_file = vim.fn.stdpath("data") .. "/last_colorscheme"

			-- Function to safely apply a colorscheme
			local function safe_colorscheme(name)
				if not name or name == "" then
					return
				end

				-- Theme-specific setup (only for the one being used)
				if name == "cyberdream" then
					require("cyberdream").setup({
						variant = "default",
						transparent = true,
					})
				elseif name == "rose-pine" then
					require("rose-pine").setup({
						palette = {
							main = {
								pine = "#3e93b5", -- #46a7cd
							},
						},
						styles = {
							bold = true,
							italic = false,
							transparency = true,
						},
					})
				elseif name == "onedark" then
					require("onedark").setup({
						style = "warmer",
						-- colors = {
						-- 	grey = "#7e8084",
						-- },
					})
				elseif name == "solarized-osaka" then
					require("solarized-osaka").setup({
						transparent = true,
					})
				elseif name == "vague" then
					require("vague").setup({
						transparent = true,
					})
				end

				local ok, err = pcall(vim.cmd.colorscheme, name)
				if not ok then
					vim.notify("Failed to load colorscheme: " .. name .. "\n" .. tostring(err), vim.log.levels.WARN)
				end
			end

			-- Try to load last used theme
			local theme = nil
			if vim.fn.filereadable(last_theme_file) == 1 then
				theme = vim.fn.readfile(last_theme_file)[1]
			end

			if theme and theme ~= "" then
				safe_colorscheme(theme)
			else
				safe_colorscheme("kanagawa-wave")
			end

			-- Save theme on ColorScheme change
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function(args)
					local file = io.open(last_theme_file, "w")
					if file then
						file:write(args.match)
						file:close()
						vim.notify("Saved last theme: " .. args.match, vim.log.levels.INFO)
					end
				end,
			})
		end,
	},

	-- Other themes (lazy-loaded)
	{ "ellisonleao/gruvbox.nvim", lazy = true },
	{ "folke/tokyonight.nvim", lazy = true },
	{ "catppuccin/nvim", name = "catppuccin", lazy = true },
	{ "navarasu/onedark.nvim", lazy = true },
	{ "mofiqul/dracula.nvim", lazy = true },
	{ "rose-pine/neovim", name = "rose-pine", lazy = true },
	{ "scottmckendry/cyberdream.nvim", lazy = true },
	{ "Mofiqul/vscode.nvim", lazy = true },
	-- { "olimorris/onedarkpro.nvim", lazy = true },
	{ "everviolet/nvim", name = "evergarden", lazy = true },
	{ "craftzdog/solarized-osaka.nvim", lazy = true },
	{ "vague-theme/vague.nvim", lazy = true },

	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			user_default_options = {
				names = false,
			},
		},
	},
}
