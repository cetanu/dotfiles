# Rust CLI replacements
alias ls="lsd --long --human-readable --group-dirs first --gitsort --git --blocks permission,size,date,git,name --date relative --size short --permission octal"
alias lst="lsd --long --human-readable --group-dirs first --gitsort --git --blocks permission,size,date,git,name --date relative --size short --permission octal --tree --depth 2"
alias cat="bat"
alias grep="rg"
alias dig="dog"

alias vim="nvim"
alias p="cd ~/Documents"
alias gitcf="git commit --amend; git push -f"
alias gitp="git checkout master; git pull"
alias gitr="git reset --hard HEAD"
alias gits="git status"

# Docker
alias dkill="docker ps -qa | xargs docker kill"
alias drm="docker ps -qa | xargs docker rm"
alias drmi="docker images -qa | xargs docker rmi -f"
alias dkara="dkill; drm; drmi"

# Wireshark
alias wireshark="/Applications/Wireshark.app/Contents/MacOS/Wireshark"

set PATH "$HOME/.cargo/bin:$PATH"
set PATH "$HOME/.local/bin:$PATH"
set PATH "$HOME/.poetry/bin:$PATH"
set PATH "$HOME/go/bin:$PATH"
set PATH "/opt/homebrew/bin:$PATH"

set -Ux EDITOR "nvim"
fnm env --use-on-cd --shell fish | source

status is-login; and pyenv init --path | source
pyenv init - | source 1>/dev/null

if test -e "$HOME/.config/cloudtoken/bashrc_additions"
    source "$HOME/.config/cloudtoken/bashrc_additions"
end

set -Ux PYENV_ROOT $HOME/.pyenv
test -d $PYENV_ROOT/bin; and fish_add_path $PYENV_ROOT/bin

set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
starship init fish | source
