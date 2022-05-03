#!/bin/bash

# Homebrew
[[ -f $(which brew) ]] || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sh
echo "Homebrew installed"

# Fish shell
[[ -f $(which fish) ]] || brew install fish
echo "Fish installed"

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
    xxv
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
