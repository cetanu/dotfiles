#!/bin/bash

# Homebrew
if [[ ! -f $(which brew) ]]; then
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | sudo bash
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew update
fi
echo "Homebrew installed"

# yazi & general tools
brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick font-symbols-only-nerd-font luarocks tree-sitter tree-sitter-cli lazygit llvm gopls tectonic chafa

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
    git-cliff
    dua-cli
    fd-find
    hyperfine
    oha
    starship
    git-interactive-rebase-tool
    wezterm
    diskonaut
    bob-nvim
    envio
    fnm
    csvlens
    gitlogue
    ducker
    flamelens
    jwt-ui
    jless
)
for pkg in ${RUST_PKGS[@]}; do
    INSTALLED=$(cargo install --list | grep ${pkg})
    if [[ ! ${INSTALLED} ]]; then
        cargo install ${pkg}
    fi
done
echo "Rust utils installed"

# Neovim
# TODO: maybe not necessary with bob-nvim
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

# Install pyenv build dependencies
if [[ $(uname -s) == "Linux" ]]; then
    if [[ -f /etc/debian_version ]]; then
        sudo apt-get update
        sudo apt-get install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
    fi
elif [[ $(uname -s) == "Darwin" ]]; then
    brew install openssl readline sqlite3 xz zlib tcl-tk
fi

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
        python -m pip install pynvim salt-lsp
        uv tool install ruff@latest
        uv tool install tiptop
        echo "Python ${ver} installed"
    fi
done


# NPM
[[ -f $(which npm) ]] || brew install node
echo "Node.js and NPM installed"

# Language servers
NODE_LSPS=(
    bash-language-server
    yaml-language-server
    awk-language-server
    dockerfile-language-server-nodejs
    vscode-langservers-extracted
    typescript-language-server
    typescript
    @mermaid-js/mermaid-cli
    neovim
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

# lua ls
[[ -f $(which lua-language-server) ]] || brew install lua-language-server

# rust-analyzer
[[ -f $(which rust-analyzer) ]] || brew install rust-analyzer
echo "rust-analyzer installed"

# wezterm
[[ -f $(which wezterm) ]] || brew install --cask wezterm
echo "wezterm installed"

# zellij
[[ -f $(which zellij) ]] || brew install zellij
echo "zellij installed"
