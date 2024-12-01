local wezterm = require("wezterm")
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Set background to same color as neovim
config.color_scheme = "Modus-Vivendi-Tritanopia"

config.font = wezterm.font_with_fallback({
	-- "OpenDyslexic",
	-- "Space Mono",
	"JetBrains Mono",
})
config.font_size = 18

-- default is true, has more "native" look
config.use_fancy_tab_bar = false

-- I don't like putting anything at the ege if I can help it.
config.enable_scroll_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

-- Spawn a fish shell in login mode
config.default_prog = { "/opt/homebrew/bin/fish", "--login" }

return config
