ZSH_THEME="cypher"
DISABLE_UPDATE_PROMPT=true

# plugins
plugins=(
    git
	aws
    ansible
    docker
    docker-compose
    sudo                # press esc twice to add sudo to current line
    systemd
    ufw
    tmux
    command-not-found   # provide suggested packages
    pip
    python
    vi-mode             # esc to enter vim mode
)

# zsh config
export HISTFILE="$HOME/.config/zsh/.zsh_history"
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
ZSH_THEME_TERM_TITLE_IDLE="zsh"

export HISTSIZE=10000
export SAVEHIST=10000
export HISTORY_IGNORE="(ls*|cd*|z*|clear|omz reload)"

export PATH="$HOME/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/go/bin"

# completion
autoload -Uz compinit; compinit
zstyle ':completion:*:ssh:*' menu select

# pipx autocomplete
autoload -U bashcompinit; bashcompinit
eval "$(register-python-argcomplete pipx)"

# qmk autocomplete
if [ -d "$HOME/dev/qmk" ]; then
    source "$HOME/dev/qmk/qmk_firmware/util/qmk_tab_complete.sh"
fi

# zoxide
export _ZO_DATA_DIR="$HOME/syncthing/sync/backups"
export _ZO_EXCLUDE_DIR="$HOME/Documents/.env"
eval "$(zoxide init zsh)"

# aliases
[ -f $HOME/.config/zsh/.zsh_alias ] && source $HOME/.config/zsh/.zsh_alias

# env variables
export TERM="screen-256color"
export EDITOR="nvim"
export BROWSER="firefox"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# starship
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# pfetch
export PF_INFO="ascii title os shell wm editor pkgs uptime"
export PF_SEP=""
export PF_ASCII="ubuntu"

# fzf
export FZF_DEFAULT_OPTS="--cycle --reverse --border=rounded --margin=1 --padding=1 --ansi --height=90%"

# llama
export LLAMA_VIM_KEYBINDINGS=true

