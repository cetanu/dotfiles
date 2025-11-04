local wezterm = require("wezterm")
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Set background to same color as neovim
config.color_scheme = "Modus-Vivendi-Tritanopia"
config.color_scheme = "Atelier Plateau (base16)"

config.font = wezterm.font_with_fallback({
	-- "OpenDyslexic",
	-- "Space Mono",
	"JetBrains Mono",
})
config.font_size = 16

-- default is true, has more "native" look
config.use_fancy_tab_bar = true

-- I don't like putting anything at the ege if I can help it.
config.enable_scroll_bar = false
config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 5,
}

config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

-- Spawn a fish shell in login mode
config.default_prog = { "/usr/local/bin/fish", "--login" }

return config
