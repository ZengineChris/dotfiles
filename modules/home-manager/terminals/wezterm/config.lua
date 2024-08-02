-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Catppuccin Mocha'
config.font_size = 16.0
config.enable_tab_bar = false
config.window_background_opacity = 0.98
config.window_decorations = "RESIZE"
config.font = wezterm.font('JetBrains Mono')

-- and finally, return the configuration to wezterm
return config
