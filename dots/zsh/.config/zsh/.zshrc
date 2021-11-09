ZSH_THEME="cypher"

# completion
autoload -Uz compinit
zstyle ':completion:*' menu select
compinit

# add pipx autocomplete
autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"

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

# Global variables
export TERM="xterm-kitty"
export TERMINFO="$HOME/.terminfo"
export EDITOR="nvim"
export BROWSER="firefox"
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"

# export MANPAGER="nvim +Man!;"
export MANWIDTH=999;

# Aliases
alias lh="ls -ld .*"
alias td="todo.sh"
alias nv="nvim"

# Configs
alias termcfg="nvim ~/.config/kitty/kitty.conf"
alias zshcfg="nvim ~/.config/zsh/.zshrc"
alias tmuxcfg="nvim ~/.tmux.conf"
alias bcfg="nvim ~/.config/bspwm/bspwmrc"
alias scfg="nvim ~/.config/sxhkd/sxhkdrc"
alias pcfg="nvim ~/.config/polybar/config"
# alias nvcfg="nvim ~/dotfiles/nvim/.config/nvim/"

alias showpath="echo $PATH | tr ':' '\n'"
alias vimgolf="docker run --rm -it -e "key=867337c104fb5b765b5ef4ade2a535e0" hettomei/vimgolf"

export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

