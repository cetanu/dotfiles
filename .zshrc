TMUX_CONFIG="~/.config/tmux/.tmux.conf"

# Rust CLI replacements
alias ls="exa"
alias cat="bat"
alias grep="rg"

# Docker
alias dkill="docker ps -qa | xargs docker kill"
alias drm="docker ps -qa | xargs docker rm"
alias drmi="docker images -qa | xargs docker rmi -f"
alias dkara="dkill; drm; drmi"

# Shortcuts
alias p="cd ~/projs"
alias vim="nvim"
alias tn="tmux -u -f $TMUX_CONFIG new"
alias ta="tmux -u -f $TMUX_CONFIG attach"
alias tt="nvim $TMUX_CONFIG"
alias vrc="nvim ~/.config/nvim/init.vim"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"

if [[ -f "${HOME}/.config/cloudtoken/bashrc_additions" ]]; then
    source "${HOME}/.config/cloudtoken/bashrc_additions"
fi

eval "$(starship init zsh)"
eval "$(pyenv init -)"
