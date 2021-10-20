ZSH_THEME="cypher"

# completion
autoload -Uz compinit
zstyle ':completion:*' menu select
compinit

autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# updates
DISABLE_UPDATE_PROMPT=true

# plugins
plugins=(git docker docker-compose)

# User configuration
export HISTFILE="$XDG_CONFIG_HOME/zsh/.zsh_history"
export ZSH="/home/ken/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
ZSH_THEME_TERM_TITLE_IDLE="zsh"

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
export PATH=$HOME/bin:$PATH
export PATH=$PATH:/usr/local/go/bin

export MANPAGER="nvim +Man!;"
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
alias nvcfg="nvim ~/dotfiles/nvim/.config/nvim/"

alias showpath="echo $PATH | tr ':' '\n'"

# Debian
alias updatable="sudo apt list --upgradeable"
alias autoupdate="sudo apt update && sudo apt full-upgrade && sudo apt autoremove;"

alias vimgolf="docker run --rm -it -e "key=867337c104fb5b765b5ef4ade2a535e0" hettomei/vimgolf"
