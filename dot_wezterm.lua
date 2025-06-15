-- Pull in the wezterm API
local wezterm = require("wezterm")

-- Build the config object
local config = wezterm.config_builder()

-- Window Appearance
config.window_background_opacity = 0.85 -- semi-transparent
config.macos_window_background_blur = 20 -- macOS only; for blur behind terminal
config.window_decorations = "RESIZE" -- clean titlebar
config.enable_scroll_bar = false

-- Font Setup
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" })
config.font_size = 10
config.line_height = 1.1

-- Initial terminal size
config.initial_cols = 120
config.initial_rows = 28

-- Colors
config.color_scheme = "Catppuccin Mocha" -- use one of the Catppuccin themes

-- Padding for breathing room
config.window_padding = {
	left = 8,
	right = 8,
	top = 6,
	bottom = 6,
}

-- Other enhancements
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

-- Return config
return config
