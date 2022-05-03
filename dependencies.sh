#!/bin/bash

# Homebrew
[[ -f $(which brew) ]] || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sh
if [[ $? ]]; then
    brew update
fi
echo "Homebrew installed"

# Rust toolchain
[[ -f $(which rustup) ]] || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo "Rustup installed"

# Rust utils
RUST_PKGS=(
    bat
    ripgrep
    git-delta
    alacritty
    dua-cli
    fd-find
    hyperfine
    sd
    zargs
    starship
    zellij
    git-interactive-rebase-tool
)
for pkg in ${RUST_PKGS[@]}; do
    INSTALLED=$(cargo install --list | grep ${pkg})
    if [[ ! ${INSTALLED} ]]; then
        cargo install ${pkg}
    fi
done
echo "Rust utils installed"

# Neovim
[[ -f $(which nvim) ]] || brew install neovim
echo "Neovim installed"

# Fish shell
[[ -f $(which fish) ]] || brew install fish
echo "Fish installed"

# pyenv
[[ -f $(which pyenv) ]] || brew install pyenv
echo "Pyenv installed"
