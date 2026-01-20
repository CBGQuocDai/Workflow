local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font 'JetBrains Mono'

-- Combo Background đẹp:
config.window_background_opacity = 1
config.window_background_image = '/home/quocdai/background/bg.jpg'
config.window_background_image_hsb = {
  brightness = 0.1, -- Rất tối để nổi bật chữ trắng
  saturation = 0.8,
}
return config
quocdai@nixos:~
