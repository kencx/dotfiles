ZSH_THEME="cypher"

autoload -Uz compinit
zstyle ':completion:*' menu select
compinit


# plugins
plugins=(git docker docker-compose)


# User configuration
export HISTFILE="$XDG_CONFIG_HOME/zsh/.zsh_history"
export ZSH="/home/ken/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Prompts
PROMPT='%F{yellow}%1~%f :: '

# Git Right Prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{yellow}(%b) %r%f'
zstyle ':vcs_info:*' enable git


# Global variables
export TERMINAL="kitty"
export EDITOR="nvim"
export BROWSER="firefox"
export PATH=$HOME/bin:$HOME/bin:$PATH:/usr/local/go/bin

export MANPAGER="nvim +Man!;"
export MANWIDTH=999;

# Aliases
alias lh="ls -ld .*"
alias td="todo.sh"

# Configs
alias termconfig="nvim ~/.config/kitty/kitty.conf"
alias zshconfig="nvim ~/.config/zsh/.zshrc"
alias tmuxconfig="nvim ~/.tmux.conf"
alias bconfig="nvim ~/.config/bspwm/bspwmrc"
alias sconfig="nvim ~/.config/sxhkd/sxhkdrc"
alias pconfig="nvim ~/.config/polybar/config"

alias showpath="echo $PATH | tr ':' '\n'"

# Debian
alias updatable="sudo apt list --upgradeable"
alias autoupdate="sudo apt update && sudo apt full-upgrade && sudo apt autoremove;"
