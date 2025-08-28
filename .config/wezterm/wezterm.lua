-- Pull in the wezterm API
local wezterm = require 'wezterm'

local tab_style = "square"

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 12
config.font = wezterm.font 'Fira Code'
-- config.color_scheme = 'AlienBlood'

--tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

config.window_background_opacity = 0.8
config.text_background_opacity = 0.4



-- Finally, return the configuration to wezterm:
return config
