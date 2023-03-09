# zsh history
HISTSIZE=5000
HISTFILE="$ZDOTDIR/.zsh_history"
SAVEHIST=5000
HISTDUP=erase
export HISTORY_IGNORE="(ls*|cd*|z*|clear)"

setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# enable vi-mode with Esc
bindkey -v

# env variables
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/go/bin"

export TERM="screen-256color"
export EDITOR="nvim"
export BROWSER="firefox"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LESSHISTFILE=-

# direnv
eval "$(direnv hook zsh)"
export DIRENV_LOG_FORMAT=

# zoxide
export _ZO_DATA_DIR="$HOME/syncthing/sync/backups"
export _ZO_EXCLUDE_DIR="$HOME/.env"
eval "$(zoxide init zsh)"

# pure prompt
fpath+=($HOME/dev/opensource/pure)
autoload -U promptinit; promptinit
prompt pure

# pfetch
export PF_INFO="ascii title os kernel shell wm editor pkgs uptime"
export PF_SEP=""
export PF_ASCII="arch"

# fzf
export FZF_DEFAULT_OPTS="--cycle --reverse --border=top --margin=1 --padding=0 --ansi --height=90%"

# ssh-agent
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)" >> /dev/null

# plugins
source "$ZDOTDIR/plugins/sudo.plugin.zsh"
source "$ZDOTDIR/plugins/history-substring-search.plugin.zsh"
source "$ZDOTDIR/plugins/forgit/forgit.plugin.zsh"
source "$ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

ZVM_CURSOR_STYLE_ENABLED=false
ZVM_NORMAL_MODE_CURSOR=ZVM_CURSOR_BLOCK
ZVM_INSERT_MODE_CURSOR=ZVM_CURSOR_BEAM
# ZVM_VI_HIGHLIGHT_FOREGROUND=
# ZVM_VI_HIGHLIGHT_BACKGROUND=

# aliases
[ -f $ZDOTDIR/.zsh_alias ] && source $ZDOTDIR/.zsh_alias

# completions
[ -f $ZDOTDIR/.zsh_completions ] && source $ZDOTDIR/.zsh_completions

# xorg
if [[ -z "${DISPLAY}" ]] && [[ "${XDG_VTNR}" -eq 1 ]]; then
   exec startx
fi
