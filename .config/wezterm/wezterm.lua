local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.color_scheme = "Catppuccin Frappe"

config.window_background_opacity = 0.8
config.window_decorations = "RESIZE"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 16.0

config.enable_tab_bar = false
return config
