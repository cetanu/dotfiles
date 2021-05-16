#!/usr/bin/env fish
mkdir -p ~/.config/nvim
ln -f init.vim ~/.config/nvim/init.vim 2>/dev/null; and echo "nvim config installed"

mkdir -p ~/.config/fish
ln -f config.fish ~/.config/fish/config.fish 2>/dev/null; and echo "fish config installed"

mkdir -p ~/.config/tmux
ln -f tmux.conf ~/.config/tmux/.tmux.conf 2>/dev/null; and echo "tmux config installed"

mkdir -p ~/.config/alacritty
ln -f alacritty.yml ~/.config/alacritty/alacritty.yml 2>/dev/null; and echo "alacritty config installed"

mkdir -p ~/.config/starship
ln -f starship.toml ~/.config/starship/starship.toml 2>/dev/null; and echo "starship config installed"
