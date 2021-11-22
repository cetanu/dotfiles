# Rust CLI replacements
alias ls="exa"
alias ll="exa -l"
alias cat="bat"
alias grep="rg"

alias vim="nvim"
alias p="cd ~/Documents"
alias vrc="nvim ~/.config/nvim/init.lua"
alias vfi="nvim ~/.config/fish/config.fish"
alias gitcf="git commit --amend; git push -f"
alias gitp="git checkout master; git pull"
alias gitr="git reset --hard HEAD"
alias gits="git status"

# Docker
alias dkill="docker ps -qa | xargs docker kill"
alias drm="docker ps -qa | xargs docker rm"
alias drmi="docker images -qa | xargs docker rmi -f"
alias dkara="dkill; drm; drmi"

set TMUX_CONFIG "$HOME/.config/tmux/.tmux.conf"
alias tn="tmux kill-server; tmux -u -f $TMUX_CONFIG new"
alias ta="tmux -u -f $TMUX_CONFIG attach"
alias tt="nvim $TMUX_CONFIG"

status is-login; and pyenv init --path | source
pyenv init - | source 1>/dev/null

set PATH "$HOME/.cargo/bin:$PATH"
set PATH "$HOME/.local/bin:$PATH"
set PATH "$HOME/.poetry/bin:$PATH"

if test -e "$HOME/.config/cloudtoken/bashrc_additions"
    source "$HOME/.config/cloudtoken/bashrc_additions"
end

set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
starship init fish | source
