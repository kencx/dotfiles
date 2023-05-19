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
setopt hist_ignore_space

# env variables
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
# export PATH="$PATH:/usr/local/go/bin"
# export PATH="$PATH:$HOME/go/bin"

export TERM="screen-256color"
export EDITOR="nvim"
export BROWSER="firefox"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LESSHISTFILE=-
# export MOZ_DISABLE_RDD_SANDBOX=1

# direnv
eval "$(direnv hook zsh)"
export DIRENV_LOG_FORMAT=

# zoxide
export _ZO_DATA_DIR="$HOME/syncthing/sync/backups"
export _ZO_EXCLUDE_DIR="$HOME/.env"
eval "$(zoxide init zsh)"

# pure prompt
if [[ -d $HOME/dev/opensource/pure ]]; then
    fpath+=($HOME/dev/opensource/pure)
    autoload -U promptinit; promptinit
    prompt pure
else
    PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '
fi

# pfetch
export PF_INFO="ascii title os kernel shell wm editor pkgs uptime"
export PF_SEP=""
export PF_ASCII="arch"

# fzf
export FZF_DEFAULT_OPTS="--cycle --reverse --border=top --margin=1 --padding=0 --ansi --height=90%"

# ssh-agent
eval $(keychain --eval --quiet id_ed25519)
[ -f $HOME/.keychain/$HOST-sh ] && . $HOME/.keychain/$HOST-sh 2>/dev/null

# plugins
source "$ZDOTDIR/plugins/sudo.plugin.zsh"
source "$ZDOTDIR/plugins/history-substring-search.plugin.zsh"
source "$ZDOTDIR/plugins/forgit/forgit.plugin.zsh"
# source "$ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

ZVM_CURSOR_STYLE_ENABLED=false
ZVM_NORMAL_MODE_CURSOR=ZVM_CURSOR_BLOCK
ZVM_INSERT_MODE_CURSOR=ZVM_CURSOR_BEAM
# ZVM_VI_HIGHLIGHT_FOREGROUND=
# ZVM_VI_HIGHLIGHT_BACKGROUND=

# https://unix.stackexchange.com/questions/25765/pasting-from-clipboard-to-vi-enabled-zsh-or-bash-shell
function x11-clip-wrap-widgets() {
    local copy_or_paste=$1
    shift

    for widget in $@; do
        if [[ $copy_or_paste == "copy" ]]; then
            eval "
            function _x11-clip-wrapped-$widget() {
                zle .$widget
                xclip -in -selection clipboard <<<\$CUTBUFFER
            }
            "
        else
            eval "
            function _x11-clip-wrapped-$widget() {
                CUTBUFFER=\$(xclip -out -selection clipboard)
                zle .$widget
            }
            "
        fi

        zle -N $widget _x11-clip-wrapped-$widget
    done
}


local copy_widgets=(
    vi-yank vi-yank-eol vi-delete vi-backward-kill-word vi-change-whole-line
)
local paste_widgets=(
    vi-put-{before,after}
)

x11-clip-wrap-widgets copy $copy_widgets
x11-clip-wrap-widgets paste  $paste_widgets

# enable vi-mode with Esc
bindkey -v

# aliases
[ -f $ZDOTDIR/.zsh_alias ] && source $ZDOTDIR/.zsh_alias

# completions
[ -f $ZDOTDIR/.zsh_completions ] && source $ZDOTDIR/.zsh_completions

# xorg
if [[ -z "${DISPLAY}" ]] && [[ "${XDG_VTNR}" -eq 1 ]]; then
   exec startx
fi
