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

mkdir -p ~/.config/alacritty
ln -f alacritty.toml ~/.config/alacritty/alacritty.toml 2>/dev/null; and echo "alacritty config installed"

mkdir -p ~/.config/ghostty
ln -f ghostty.config ~/.config/ghostty/config 2>/dev/null; and echo "ghostty config installed"

mkdir -p ~/.config/zellij
ln -f zellij.kdl ~/.config/zellij/config.kdl 2>/dev/null; and echo "zellij config installed"
ln -f cheatsheet.md ~/.config/zellij/cheatsheet.md 2>/dev/null; and echo "zellij cheatsheet installed"
