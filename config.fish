# Rust CLI replacements
alias ls="exa"
alias ll="exa -l"
alias cat="bat"
alias grep="rg"
alias dig="dog"

alias vim="nvim"
alias p="cd ~/Documents"
alias gitcf="git commit --amend; git push -f"
alias gitp="git checkout master; git pull"
alias gitr="git reset --hard HEAD"
alias gits="git status"
alias pr="cat ~/pr.md | pbcopy"

# Docker
alias dkill="docker ps -qa | xargs docker kill"
alias drm="docker ps -qa | xargs docker rm"
alias drmi="docker images -qa | xargs docker rmi -f"
alias dkara="dkill; drm; drmi"

# Wireshark
alias wireshark="/Applications/Wireshark.app/Contents/MacOS/Wireshark"

set EDITOR "/opt/homebrew/bin/nvim"
set PATH "$HOME/.cargo/bin:$PATH"
set PATH "$HOME/.local/bin:$PATH"
set PATH "$HOME/.poetry/bin:$PATH"
set PATH "$HOME/go/bin:$PATH"
set PATH "/opt/homebrew/bin:$PATH"

status is-login; and pyenv init --path | source
pyenv init - | source 1>/dev/null

if test -e "$HOME/.config/cloudtoken/bashrc_additions"
    source "$HOME/.config/cloudtoken/bashrc_additions"
end

set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
starship init fish | source


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/Users/vsyrakis/.opam/opam-init/init.fish' && source '/Users/vsyrakis/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
