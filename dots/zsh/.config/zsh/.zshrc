ZSH_THEME="cypher"

# completion
autoload -Uz compinit; compinit
zstyle ':completion:*' menu select

# updates
DISABLE_UPDATE_PROMPT=true

# add pipx autocomplete
autoload -U bashcompinit; bashcompinit
eval "$(register-python-argcomplete pipx)"

# zoxide
export _ZO_DATA_DIR="$HOME/syncthing/sync/env"
export _ZO_EXCLUDE_DIR="$HOME/syncthing/sync/env/*"
eval "$(zoxide init zsh)"

# fzf
export FZF_DEFAULT_OPTS="--cycle --reverse --border=rounded --margin=1 --padding=1 --ansi --height=90%"

# plugins
plugins=(
    git
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

# User configuration
export HISTFILE="$HOME/.config/zsh/.zsh_history"
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
ZSH_THEME_TERM_TITLE_IDLE="zsh"

export HISTSIZE=10000
export SAVEHIST=10000
export HISTORY_IGNORE="(ls*|cd*|z*|clear|omz reload)"

export TERM="xterm-kitty"
export TERMINFO="$HOME/.terminfo"
export EDITOR="nvim"
export BROWSER="firefox"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export PATH="$HOME/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/go/bin"

# aliases
[ -f $HOME/.config/zsh/.zsh_alias ] && source $HOME/.config/zsh/.zsh_alias

# starship
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"
