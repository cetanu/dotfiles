# Rust CLI replacements
alias ls="lsd --long --human-readable --group-dirs first --gitsort --git --blocks permission,size,date,git,name --date relative --size short --permission octal"
alias lst="lsd --long --human-readable --group-dirs first --gitsort --git --blocks permission,size,date,git,name --date relative --size short --permission octal --tree --depth 2"
alias cat="bat"
alias grep="rg"

alias vim="nvim"
alias p="cd ~/Documents"
alias gitcf="git commit --amend; git push -f"
alias gitp="git checkout master; git pull"
alias gitr="git reset --hard HEAD"
alias gits="git status"
git config --global user.name "Vasilios Syrakis"
git config --global user.email "syrakis@pm.me"

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
set PATH "$HOME/.local/share/bob/nvim-bin:$PATH"
set PATH "$HOME/.pulumi/bin:$PATH"
set PATH "$HOME/.local/go/bin:$PATH"
set PATH "$HOME/go/bin:$PATH"
set PATH "$HOME/.local/share/zerobrew/prefix/bin:$PATH"
set PATH "$HOME/.local/share/zerobrew/prefix/Cellar/node/26.4.0/bin:$PATH"
set PATH "/opt/homebrew/bin:$PATH"
set PATH "/home/linuxbrew/.linuxbrew/bin:$PATH"

set -Ux EDITOR "nvim"
fnm env --use-on-cd --shell fish | source

export PULUMI_CONFIG_PASSPHRASE_FILE="$HOME/.pulumi/passphrase"

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

# Ghostty Font & Stream Mode
function ghostty-font -a size
    test -n "$size"; or set size 16
    sed -i --follow-symlinks "s/^font-size = .*/font-size = $size/" ~/.config/ghostty/config
    pkill -SIGUSR2 -u (id -u) ghostty 2>/dev/null; or true
end
alias stream="ghostty-font 22"
alias unstream="ghostty-font 16"

# Fix pkg-config not finding libudev.pc for compiling cosmic-comp
set -gx PKG_CONFIG_PATH /usr/lib/x86_64-linux-gnu/pkgconfig:/usr/lib/pkgconfig:/usr/share/pkgconfig $PKG_CONFIG_PATH

# Keep mise activation after local PATH changes so managed tools win.
mise activate fish | source

keymenu shell fish | source
