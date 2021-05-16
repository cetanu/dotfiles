#!/usr/bin/env fish
mkdir -p ~/.config/nvim
ln init.vim ~/.config/nvim/init.vim 2>/dev/null; or echo "nvim config installed"

mkdir -p ~/.config/fish
ln config.fish ~/.config/fish/config.fish 2>/dev/null; or echo "fish config installed"

mkdir -p ~/.config/tmux
ln tmux.conf ~/.config/tmux/.tmux.conf 2>/dev/null; or echo "tmux config installed"

mkdir -p ~/.config/alacritty
ln alacritty.yml ~/.config/alacritty/alacritty.yml 2>/dev/null; or echo "alacritty config installed"

mkdir -p ~/.config/starship
ln starship.toml ~/.config/starship/starship.toml 2>/dev/null; or echo "starship config installed"
