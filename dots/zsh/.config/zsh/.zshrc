ZSH_THEME="cypher"

# completion
autoload -Uz compinit
zstyle ':completion:*' menu select
compinit

# add pipx autocomplete
autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"

export _ZO_DATA_DIR="$HOME/syncthing/sync/env"
export _ZO_EXCLUDE_DIR="$HOME/syncthing/sync/env/*"
eval "$(zoxide init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# updates
DISABLE_UPDATE_PROMPT=true

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

HISTSIZE=10000
SAVEHIST=10000

# export MANPAGER="nvim +Man!;"
export MANWIDTH=999;

export TERM="xterm-kitty"
export TERMINFO="$HOME/.terminfo"
export EDITOR="nvim"
export BROWSER="firefox"

export PATH="$HOME/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"

export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# aliases
[ -f $HOME/.config/zsh/.zsh_alias ] && source $HOME/.config/zsh/.zsh_alias


