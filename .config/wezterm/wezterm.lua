-- Pull in the wezterm API
local wezterm = require("wezterm")

--[[ local tab_style = "square" ]]

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
config.enable_wayland = false
-- For example, changing the initial geometry for new windows:
--[[ config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 12
--config.font = wezterm.font 'JetBrains Mono'
--config.font = wezterm.font("FiraCode")
-- config.color_scheme = 'AlienBlood'
 ]]
local color = "Modus-Vivendi"

local color = "Modus-Vivendi"
local color = "GruvboxDark"
-- local color = "SynthwaveAlpha"
config.color_scheme = color
local font = "Consolas"
font = "Fira Code"
-- font = "JetBrains Mono"
-- font = "mononoki"
-- font = "OCR-B 10 BT"
-- font = "terminus (TTF)"
--font = "IBM plex mono"
-- font = "Perfect DOS VGA 437"
-- font = 'Adwaita Mono'
-- font = "NotoSansMono-Regular"
-- font = "Nimbus Mono PS"
-- font = "PxPlus IBM VGA8"
-- font = "Modern DOS 9x16"
-- font = "Classic Console Neue"
-- font = "Geist Mono"
config.font = wezterm.font(font)
config.font_size = 12
-- config.font = wezterm.font("FiraCode")
--config.font = wezterm.font("JetBrains Mono")

--tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false

-- config.window_background_opacity = 0.8
-- config.text_background_opacity = 0.4

config.window_padding = {
    left = 0, right = 0, top = 0, bottom = 0 }

-- inputs
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
    {
        key = "d", mods = "CTRL|SHIFT", action = wezterm.action.ShowLauncher
    },
    {
        key = 'v',
        mods = 'LEADER',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },

    {
        key = 's',
        mods = 'LEADER',
        action = wezterm.action.SplitVertical {
            domain = 'CurrentPaneDomain'
        }
    },
    {
        key = 'c',
        mods = 'LEADER',
        action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    {
        key = 'a',
        mods = 'LEADER',
        action = wezterm.action_callback(function(window, pane)
            window:toast_notification(
                "Leader Keys",
                "s: split | v: vsplit | h/j/k/l: move",
                nil,
                2000
            )
        end),
    }
}
for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'LEADER',
        action = wezterm.action.ActivateTab(i - 1),
    })
end
-- show leader indicator
local colors = {
    yellow = "#b57414",
    green = "#8ec07c",
    greendark = "#79740e",
    white = "#ffffff"
}
wezterm.on('update-right-status', function(window, pane)
    local leader = ''
    if window:leader_is_active() then
        leader = wezterm.format({
            { Attribute = { Intensity = "Bold" } },
            { Foreground = { Color = "#ffffff" } },
            { Background = { Color = colors.greendark } },
            --[[ { Foreground = { Color = "#8ec07c" } }, ]]
            --[[  { Background = { Color = "#5f00af" } }, ]]
            { Text = " ~ " },
        })
    end
    window:set_left_status(leader)
end)



-- launch
-- config.default_prog = {
--  'usr/bin/env bash'
--}
-- config.launch_menu = {
--     {
--         label = "Nixos config",
--         cwd = "/etc/nixos/",
--         args = { "sudo", "hx" },
--     },
--  {
--    args = {'nixos-rebuild', 'switch'}
--  },
--  {
--    label = 'Projects',
--    cwd = "~/Projects"
--  }
--}

-- config.default_prog = {"/run/current-system/sw/bin/fish"}
-- Finally, return the configuration to wezterm:
return config
