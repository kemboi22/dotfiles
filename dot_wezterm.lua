-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- Build the config object
local config = wezterm.config_builder()

-- =====================================================
-- 🎨 VISUAL APPEARANCE
-- =====================================================

-- Window styling with modern blur effects
config.window_background_opacity = 0.92
config.macos_window_background_blur = 30
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.enable_scroll_bar = false -- cleaner look
config.use_resize_increments = true

-- Modern window frame
config.window_frame = {
	inactive_titlebar_bg = "#1e1e2e",
	active_titlebar_bg = "#1e1e2e",
	inactive_titlebar_fg = "#6c7086",
	active_titlebar_fg = "#cdd6f4",
	inactive_titlebar_border_bottom = "#313244",
	active_titlebar_border_bottom = "#313244",
	button_fg = "#6c7086",
	button_bg = "#1e1e2e",
	button_hover_fg = "#cdd6f4",
	button_hover_bg = "#313244",
}

-- =====================================================
-- 🔤 FONT CONFIGURATION
-- =====================================================

-- FantasqueSansM Nerd Font - quirky and beautiful!
config.font = wezterm.font_with_fallback({
	{ family = "FantasqueSansM Nerd Font", weight = "Regular" },
	{ family = "JetBrainsMono Nerd Font", weight = "Regular" }, -- fallback
	{ family = "Symbols Nerd Font Mono", weight = "Regular" }, -- symbols
})

config.font_rules = {
	-- Bold
	{
		intensity = "Bold",
		font = wezterm.font("FantasqueSansM Nerd Font", { weight = "Bold" }),
	},
	-- Italic
	{
		italic = true,
		font = wezterm.font("FantasqueSansM Nerd Font", { style = "Italic" }),
	},
	-- Bold Italic
	{
		italic = true,
		intensity = "Bold",
		font = wezterm.font("FantasqueSansM Nerd Font", { weight = "Bold", style = "Italic" }),
	},
}

config.font_size = 11.5
config.line_height = 1.15
config.cell_width = 1.0
config.freetype_load_target = "HorizontalLcd"
config.freetype_render_target = "HorizontalLcd"

-- =====================================================
-- 🌈 COLOR SCHEME & THEMES
-- =====================================================

config.color_scheme = "Catppuccin Mocha"

-- Custom color overrides for extra coolness
config.colors = {
	-- Cursor styling
	cursor_bg = "#f5c2e7", -- Pink cursor
	cursor_fg = "#1e1e2e",
	cursor_border = "#f5c2e7",

	-- Selection colors
	selection_bg = "#414559",
	selection_fg = "#cdd6f4",

	-- Split borders
	split = "#6c7086",

	-- Tab bar colors
	tab_bar = {
		background = "#11111b",
		active_tab = {
			bg_color = "#cba6f7",
			fg_color = "#11111b",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#313244",
			fg_color = "#6c7086",
		},
		inactive_tab_hover = {
			bg_color = "#45475a",
			fg_color = "#cdd6f4",
		},
		new_tab = {
			bg_color = "#181825",
			fg_color = "#6c7086",
		},
		new_tab_hover = {
			bg_color = "#313244",
			fg_color = "#cdd6f4",
		},
	},
}

-- =====================================================
-- 📐 WINDOW CONFIGURATION
-- =====================================================

config.initial_cols = 140
config.initial_rows = 35

-- Gorgeous padding with asymmetric design
config.window_padding = {
	left = 20,
	right = 20,
	top = 15,
	bottom = 15,
}

-- =====================================================
-- 🔥 TAB BAR STYLING
-- =====================================================

config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = false
config.show_new_tab_button_in_tab_bar = true
config.tab_max_width = 32

-- Custom tab title function
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local edge_background = "#181825"
	local background = "#313244"
	local foreground = "#6c7086"

	if tab.is_active then
		background = "#cba6f7"
		foreground = "#11111b"
	elseif hover then
		background = "#45475a"
		foreground = "#cdd6f4"
	end

	local edge_foreground = background
	local title = tab.active_pane.title

	-- Shorten title if too long
	if #title > max_width - 4 then
		title = wezterm.truncate_right(title, max_width - 4) .. "…"
	end

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = "" },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = " " .. title .. " " },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = "" },
	}
end)

-- =====================================================
-- ⌨️  KEYBINDINGS & SHORTCUTS
-- =====================================================

config.keys = {
	-- Pane management
	{ key = "d", mods = "CMD", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "d", mods = "CMD|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "w", mods = "CMD", action = act.CloseCurrentPane({ confirm = true }) },

	-- Pane navigation
	{ key = "h", mods = "CMD", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CMD", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "CMD", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CMD", action = act.ActivatePaneDirection("Down") },

	-- Pane resizing
	{ key = "h", mods = "CMD|SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "l", mods = "CMD|SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ key = "k", mods = "CMD|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "j", mods = "CMD|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },

	-- Tab management
	{ key = "t", mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "1", mods = "CMD", action = act.ActivateTab(0) },
	{ key = "2", mods = "CMD", action = act.ActivateTab(1) },
	{ key = "3", mods = "CMD", action = act.ActivateTab(2) },
	{ key = "4", mods = "CMD", action = act.ActivateTab(3) },
	{ key = "5", mods = "CMD", action = act.ActivateTab(4) },
	{ key = "6", mods = "CMD", action = act.ActivateTab(5) },
	{ key = "7", mods = "CMD", action = act.ActivateTab(6) },
	{ key = "8", mods = "CMD", action = act.ActivateTab(7) },
	{ key = "9", mods = "CMD", action = act.ActivateTab(8) },

	-- Font size
	{ key = "=", mods = "CMD", action = act.IncreaseFontSize },
	{ key = "-", mods = "CMD", action = act.DecreaseFontSize },
	{ key = "0", mods = "CMD", action = act.ResetFontSize },

	-- Search
	{ key = "f", mods = "CMD", action = act.Search({ CaseInSensitiveString = "" }) },

	-- Copy/Paste
	{ key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },

	-- Toggle fullscreen
	{ key = "Enter", mods = "CMD", action = act.ToggleFullScreen },

	-- Quick terminal
	{ key = "`", mods = "CMD", action = act.ShowLauncher },
}

-- =====================================================
-- 🚀 ADVANCED FEATURES
-- =====================================================

-- Scrollback
config.scrollback_lines = 10000

-- Performance optimizations
config.max_fps = 120
config.animation_fps = 60

-- Bell configuration
config.audible_bell = "Disabled"
config.visual_bell = {
	fade_in_function = "EaseIn",
	fade_in_duration_ms = 150,
	fade_out_function = "EaseOut",
	fade_out_duration_ms = 150,
}

-- Mouse bindings
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = act.OpenLinkAtMouseCursor,
	},
	{
		event = { Down = { streak = 3, button = "Left" } },
		action = act.SelectTextAtMouseCursor("Line"),
		mods = "NONE",
	},
}

-- Hyperlink rules for clickable links
config.hyperlink_rules = {
	{
		regex = "\\b\\w+://[\\w.-]+:[0-9]+\\S*\\b",
		format = "$0",
	},
	{
		regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
		format = "$0",
	},
	{
		regex = "\\b[\\w.-]+@[\\w.-]+\\.[a-z]{2,15}\\b",
		format = "mailto:$0",
	},
	{
		regex = "\\bfile://\\S*\\b",
		format = "$0",
	},
	{
		regex = "\\b\\w+://(?:[\\d]{1,3}\\.){3}[\\d]{1,3}\\S*\\b",
		format = "$0",
	},
}

-- Cursor styling
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Miscellaneous
config.automatically_reload_config = true
config.check_for_updates = false
config.show_update_window = false

-- Return the configuration
return config
