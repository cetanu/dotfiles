#!/usr/bin/env fish
mkdir -p ~/.config/nvim
ln -f nvim/init.lua ~/.config/nvim/init.lua 2>/dev/null; and echo "nvim init installed"
ln -f nvim/old_config.vim ~/.config/nvim/old_config.vim 2>/dev/null
rm -rf ~/.config/nvim/lua/vsy
mkdir -p ~/.config/nvim/lua/vsy
ln -fs (pwd)/nvim/vsy/* ~/.config/nvim/lua/vsy/ 2>/dev/null; and echo "nvim modules installed"

mkdir -p ~/.config/fish
ln -f config.fish ~/.config/fish/config.fish 2>/dev/null; and echo "fish config installed"

mkdir -p ~/.config/tmux
ln -f tmux.conf ~/.config/tmux/.tmux.conf 2>/dev/null; and echo "tmux config installed"

mkdir -p ~/.config/alacritty
ln -f alacritty.yml ~/.config/alacritty/alacritty.yml 2>/dev/null; and echo "alacritty config installed"

mkdir -p ~/.config/starship
ln -f starship.toml ~/.config/starship/starship.toml 2>/dev/null; and echo "starship config installed"

ln -f notetaker.bash /usr/local/bin/notetaker 2>/dev/null; and echo "note script installed"

grep delta ~/.gitconfig; or cat gitconfig >> ~/.gitconfig
