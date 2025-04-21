-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
local act = wezterm.action
config.prefer_egl=true
-- config.window_background_opacity = 0.96
-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'
config.color_scheme = 'Default (dark) (terminal.sexy)'
config.window_decorations = 'TITLE|RESIZE'
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.window_close_confirmation = 'NeverPrompt'
-- Enable the scrollbar.
-- It will occupy the right window padding space.
-- If right padding is set to 0 then it will be increased
-- to a single cell width
config.enable_scroll_bar = true
config.scrollback_lines = 35000
config.window_padding = {
  left = 5,
  right = 13,
  top = 4,
  bottom = 0,
}
-- disable font ligatures
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.keys = {
  { key = 'Enter', mods = 'CTRL|SHIFT',   action = act.TogglePaneZoomState },
  { key = 'w',     mods = 'CTRL|SHIFT',   action = act.CloseCurrentPane({ confirm = false }) },
  -- This will create a new split and run the `top` program inside it
  {
    key = [["]],
    mods = 'CTRL|SHIFT',
    action = act.SplitVertical {
      domain = "CurrentPaneDomain",
    },
  },
  {
    key = 's',
    mods = 'CTRL|SHIFT',
    action = act.SplitHorizontal {
      domain = "CurrentPaneDomain",
    },
  },
-- Move to pane to the bottom
  { key = 'k',  mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection('Up') },
  { key = 'j',  mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection('Down') },
  { key = 'h',  mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection('Left') },
  { key = 'l',  mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection('Right') },

}
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.CompleteSelection('ClipboardAndPrimarySelection'),
  },
  {
    event = { Drag = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.ExtendSelectionToMouseCursor("Block"),
  },
  {
    event = { Down = { streak = 1, button = 'Left' } },
    mods = 'CTRL',
    action = act.SelectTextAtMouseCursor("Block"),
  },
}

-- and finally, return the configuration to wezterm
return config
