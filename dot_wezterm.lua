local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- Base Rendering Settings
config.front_end = "OpenGL"
-- config.prefer_egl = true
config.max_fps = 144
config.animation_fps = 1
config.term = "xterm-256color"
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500

-- Appearance
config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Regular' })
config.font_size = 14.0
config.cell_width = 1.0
config.line_height = 1.0

-- Opaque by default
config.window_background_opacity = 1.0

config.window_padding = {
	left = 20,
	right = 20,
	top = 20,
	bottom = 20,
}

config.window_decorations = "NONE | RESIZE"
config.window_frame = {
	font = wezterm.font({ family = "JetBrainsMono Nerd Font", weight = "Regular" }),
	active_titlebar_bg = "#1F1F28",
}

-- Tabs & Layout
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_max_width = 100
config.adjust_window_size_when_changing_font_size = false
config.initial_cols = 120
config.initial_rows = 30
config.scrollback_lines = 5000
config.audible_bell = "Disabled"

-- Color Scheme: Kanagawa
config.color_schemes = {
	["Kanagawa"] = {
		foreground = "#DCD7BA",
		background = "#1F1F28",
		cursor_bg = "#DCD7BA",
		cursor_border = "#DCD7BA",
		cursor_fg = "#1F1F28",
		selection_bg = "#2A2A37",
		selection_fg = "#DCD7BA",
		ansi = {
			"#1F1F28", "#E82424", "#76946A", "#FF9E3B",
			"#658594", "#957FB8", "#9CABCA", "#DCD7BA",
		},
		brights = {
			"#8181A9", "#FF5D62", "#98BB6C", "#E6C384",
			"#7FB4CA", "#D27E99", "#A3D4D5", "#DCD7BA",
		},
	},
}
config.color_scheme = "Kanagawa"

-- Shell / Program Defaults
config.default_prog = { "pwsh.exe", "-NoLogo" }

-- Key Bindings
config.keys = {
	-- Split panes
	{
		key = "h",
		mods = "CTRL|SHIFT|ALT",
		action = act.SplitPane({ direction = "Right", size = { Percent = 50 } }),
	},
	{
		key = "v",
		mods = "CTRL|SHIFT|ALT",
		action = act.SplitPane({ direction = "Down", size = { Percent = 50 } }),
	},

	-- Resize panes
	{ key = "U", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "I", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "O", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "P", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },

	-- Misc utilities
	-- { key = "9", mods = "CTRL", action = act.PaneSelect },
	-- { key = "L", mods = "CTRL", action = act.ShowDebugOverlay },

	-- Toggle transparency
	{
		key = "O",
		mods = "CTRL|ALT",
		action = wezterm.action_callback(function(window, _)
			local overrides = window:get_config_overrides() or {}
			if overrides.window_background_opacity == 1.0 then
				overrides.window_background_opacity = 0.9
			else
				overrides.window_background_opacity = 1.0
			end
			window:set_config_overrides(overrides)
		end),
	},
	{ key = "V", mods = "CTRL", action = act.PasteFrom("Clipboard") },
}

-- Window Behavior
-- wezterm.on("gui-startup", function(cmd)
-- 	local _, _, window = wezterm.mux.spawn_window(cmd or {})
-- 	local gui = window:gui_window()
--
-- 	-- Optional: comment out this line if you don’t want the window maximized
-- 	-- gui:maximize()
--
-- 	-- Center the window manually (only works if not maximized)
-- 	local screen = wezterm.gui.screens().active
-- 	local dimensions = gui:get_dimensions()
--
-- 	gui:set_position(
-- 		(screen.width - dimensions.pixel_width) / 2,
-- 		(screen.height - dimensions.pixel_height) / 2
-- 	)
-- end)

return config
