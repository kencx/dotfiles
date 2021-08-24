ZSH_THEME="cypher"

autoload -Uz compinit
zstyle ':completion:*' menu select
compinit


# plugins
plugins=(git docker docker-compose)


# User configuration
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
zstyle ':vcs_info:git:*' formats '%F{yellow}(%b)%r%f'
zstyle ':vcs_info:*' enable git


# Global variables
export TERMINAL="alacritty"
export EDITOR="nvim"
export BROWSER="google-chrome"
export PATH=$HOME/bin:$HOME/scripts:$PATH

export MANPAGER="nvim +Man!;"
export MANWIDTH=999;

# Aliases

alias lh="ls -ld .*"

# Configs
alias termconfig="nvim ~/.config/alacritty/alacritty.yml"
alias zshconfig="nvim ~/.config/zsh/.zshrc"
alias tmuxconfig="nvim ~/.tmux.conf"
alias bconfig="nvim ~/.config/bspwm/bspwmrc"
alias sconfig="nvim ~/.config/sxhkd/sxhkdrc"

alias showpath="echo $PATH | tr ':' '\n'"

# Debian
alias updatable="sudo apt list --upgradeable"
alias autoupdate="sudo apt update && sudo apt full-upgrade && sudo apt autoremove;"
