#!/usr/bin/env fish
rm -rf ~/.config/nvim/lua/vsy
mkdir -p ~/.config/nvim/lua/vsy
ln -fs (pwd)/nvim/init.lua ~/.config/nvim/init.lua
ln -fs (pwd)/nvim/vsy/* ~/.config/nvim/lua/vsy/ 2>/dev/null; and echo "nvim modules installed"

mkdir -p ~/.config/fish
ln -f config.fish ~/.config/fish/config.fish 2>/dev/null; and echo "fish config installed"

mkdir -p ~/.config/starship
ln -f starship.toml ~/.config/starship/starship.toml 2>/dev/null; and echo "starship config installed"

ln -f wezterm.lua ~/.wezterm.lua 2>/dev/null; and echo "wezterm config installed"
