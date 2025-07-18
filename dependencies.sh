#!/bin/bash

# Homebrew
if [[ ! -f $(which brew) ]]; then
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sudo bash
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew update
fi
echo "Homebrew installed"

# yazi
brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick font-symbols-only-nerd-font

# orbstack
brew install docker docker-compose orbstack

# Fish shell
[[ -f $(which fish) ]] || brew install fish
echo "Fish installed"

# Rust toolchain
if [[ ! -f $(which rustup) ]]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustup toolchain install stable
fi
echo "Rustup installed"

# Rust utils
RUST_PKGS=(
    bat
    lsd
    ripgrep
    git-delta
    dua-cli
    fd-find
    hyperfine
    oha
    starship
    git-interactive-rebase-tool
    wezterm
)
for pkg in ${RUST_PKGS[@]}; do
    INSTALLED=$(cargo install --list | grep ${pkg})
    if [[ ! ${INSTALLED} ]]; then
        cargo install ${pkg}
    fi
done
echo "Rust utils installed"

# Neovim
if [[ ! -f $(which nvim) ]]; then
	git clone https://github.com/neovim/neovim --depth 1
	xcode-select --install
	brew install ninja cmake gettext curl lua luv lpeg
	pushd neovim
		git checkout stable
		make CMAKE_BUILD_TYPE=RelWithDebInfo
		sudo make install
		cmake -S . -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$HOME/.local -G Ninja
		cmake --build build
		cmake --install build
	popd
	rm -rf neovim
fi
echo "Neovim installed"



# pyenv
[[ -f $(which pyenv) ]] || brew install pyenv
echo "Pyenv installed"
PY_VERSIONS=(
    3.11.0
    3.12.0
)
for ver in ${PY_VERSIONS[@]}; do
    INSTALLED=$(pyenv versions | grep ${ver})
    if [[ ! ${INSTALLED} ]]; then
        echo "Installing Python ${ver}"
        pyenv install ${ver}
    else
        pyenv global 3.12.0
        pyenv init - | source
        python -m pip install --upgrade pip pipx poetry uv
        uv tool install ruff@latest
        echo "Python ${ver} installed"
    fi
done


# NPM
[[ -f $(which npm) ]] || brew install node
echo "Node.js and NPM installed"

# Language servers
NODE_LSPS=(
    pyright
    bash-language-server
    yaml-language-server
)
for lsp in ${NODE_LSPS[@]}; do
    INSTALLED=$(npm list -g | grep ${lsp})
    if [[ ! ${INSTALLED} ]]; then
        echo "Installing LSP ${ver}"
        npm install -g ${lsp}
    else
        echo "LSP ${lsp} installed"
    fi
done
# rust-analyzer
[[ -f $(which rust-analyzer) ]] || brew install rust-analyzer
echo "rust-analyzer installed"

# wezterm
[[ -f $(which wezterm) ]] || brew install --cask wezterm
echo "wezterm installed"
