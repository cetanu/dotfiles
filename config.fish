alias grep="rg"
alias vim="nvim"
alias p="cd ~/Documents"
alias dkill="docker ps -qa | xargs docker kill"
alias drm="docker ps -qa | xargs docker rm"
alias drmi="docker images -qa | xargs docker rmi -f"
alias dkara="dkill; drm; drmi"

fish_add_path --global "$HOME/.cargo/bin"
fish_add_path --global "$HOME/.local/bin"
fish_add_path --global "$HOME/.poetry/bin"
fish_add_path --global "$HOME/.local/share/bob/nvim-bin"
fish_add_path --global "$HOME/.pulumi/bin"
fish_add_path --global "$HOME/.local/go/bin"
fish_add_path --global "$HOME/go/bin"
fish_add_path --global "$HOME/.opencode/bin"
fish_add_path --global "$HOME/local/share/pi-node/node-v22.23.2-linux-x64/bin"
fish_add_path --global /opt/homebrew/bin
fish_add_path --global /home/linuxbrew/.linuxbrew/bin
fish_add_path --global /home/vsyrakis/.local/share/zerobrew/prefix/bin
fish_add_path --global /home/vsyrakis/.wash/bin
fish_add_path --global /opt/android-studio/bin

export PULUMI_CONFIG_PASSPHRASE_FILE="$HOME/.pulumi/passphrase"
if test -e "$HOME/.config/cloudtoken/bashrc_additions"
    source "$HOME/.config/cloudtoken/bashrc_additions"
end

# Ghostty Font & Stream Mode
function ghostty-font -a size
    test -n "$size"; or set size 16
    sed -i --follow-symlinks "s/^font-size = .*/font-size = $size/" ~/.config/ghostty/config
    pkill -SIGUSR2 -u (id -u) ghostty 2>/dev/null; or true
end
alias stream="ghostty-font 22"
alias unstream="ghostty-font 16"

mise activate fish | source
keymenu shell fish | source

set -Ux EDITOR "nvim"
