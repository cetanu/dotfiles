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

set PATH "$HOME/.local/share/bob/nvim-bin:$PATH"
set PATH "$HOME/.cargo/bin:$PATH"
set PATH "$HOME/.local/bin:$PATH"
set PATH "$HOME/.poetry/bin:$PATH"
set PATH "$HOME/go/bin:$PATH"
set PATH "/opt/homebrew/bin:$PATH"
set PATH "/home/linuxbrew/.linuxbrew/bin:$PATH"
set PATH "$HOME/.local/share/zerobrew/prefix/bin:$PATH"


set -Ux EDITOR "nvim"
fnm env --use-on-cd --shell fish | source

set -Ux PYENV_ROOT $HOME/.pyenv
test -d $PYENV_ROOT/bin; and fish_add_path $PYENV_ROOT/bin
status is-login; and pyenv init --path | source
pyenv init - | source 1>/dev/null

#eval (opam env --switch=default)

if test -e "$HOME/.config/cloudtoken/bashrc_additions"
    source "$HOME/.config/cloudtoken/bashrc_additions"
end


set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
starship init fish | source

# Zellij Integrations
alias z="zellij"
alias za="zellij attach"
alias zls="zellij list-sessions"

function zn
    if set -q ZELLIJ
        echo "Already inside a Zellij session!"
    else
        # Attach to session named after current directory, or create one if it doesn't exist
        set -l session_name (basename (pwd) | tr '.' '_')
        zellij attach -c $session_name
    end
end

# Stream Mode integration
function stream
    if set -q ZELLIJ
        echo "Already inside a Zellij session!"
        return 1
    end

    # 1. If running inside Alacritty, increase font size dynamically
    if set -q ALACRITTY_WINDOW_ID; or set -q ALACRITTY_SOCKET
        alacritty msg config "font.size=18" 2>/dev/null
    end

    # 2. Attach to or create a Zellij session in stream mode
    set -l session_name "stream"
    if test (count $argv) -gt 0
        set session_name $argv[1]
    end
    zellij --config ~/.config/zellij/config.kdl attach -c $session_name

    # 3. Restore Alacritty settings on exit
    if set -q ALACRITTY_WINDOW_ID; or set -q ALACRITTY_SOCKET
        alacritty msg config --reset 2>/dev/null
    end
end



