-- Pull in the wezterm API
local wezterm = require 'wezterm'

local tab_style = "square"

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
config.enable_wayland = false
-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 12
-- config.font = wezterm.font 'JetBrains Mono'
config.font = wezterm.font 'FiraCode'
-- config.color_scheme = 'AlienBlood'

--tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false

config.window_background_opacity = 0.8
config.text_background_opacity = 0.4

-- inputs
config.keys = {
  { key = 'd', mods = 'CTRL|SHIFT', action = wezterm.action.ShowLauncher },
 }

-- launch
-- config.default_prog = {
--  'usr/bin/env bash'
--}
config.launch_menu = {
  {
    label = 'Nixos config',
    cwd = '/etc/nixos/',
    args = { 'sudo', 'hx' }
  },
--  {
--    args = {'nixos-rebuild', 'switch'}
--  },
--  {
--    label = 'Projects',
--    cwd = "~/Projects"
--  }
}
-- config.default_prog = {"/run/current-system/sw/bin/fish"}
-- Finally, return the configuration to wezterm:
return config
