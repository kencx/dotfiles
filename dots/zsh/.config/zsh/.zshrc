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
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

export TERM="screen-256color"
export EDITOR="nvim"
export BROWSER="firefox"
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LESSHISTFILE=-
# export MOZ_DISABLE_RDD_SANDBOX=1

# direnv
eval "$(direnv hook zsh)"
export DIRENV_LOG_FORMAT=

# rbenv
if ! [[ $(type -p rbenv) ]]; then
    eval "$(rbenv init - zsh)"
fi

# zoxide
export _ZO_DATA_DIR="$HOME/syncthing/sync/backups"
export _ZO_EXCLUDE_DIR="$HOME/.env"
eval "$(zoxide init zsh)"

# prompt
if [[ -e "/usr/share/zsh/functions/Prompts/prompt_pure_setup" ]]; then
    # pure
    autoload -U promptinit; promptinit
    prompt pure
else
    # default
    PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '
fi

# pfetch
export PF_INFO="ascii title os kernel shell wm editor pkgs uptime"
export PF_SEP=""
export PF_ASCII="arch"

# fzf
export FZF_DEFAULT_OPTS="--cycle --reverse --border=top --margin=1 --padding=0 --ansi --height=90%"

# ssh-agent
eval $(keychain --eval --quiet id_ed25519 id_github id_vps)
[ -f $HOME/.keychain/$HOST-sh ] && . $HOME/.keychain/$HOST-sh 2>/dev/null

# bind shift=tab to backwards menu
bindkey "\e[Z" reverse-menu-complete

# plugins
source "$ZDOTDIR/plugins/jq-zsh-plugin/jq.plugin.zsh"
source "$ZDOTDIR/plugins/sudo.plugin.zsh"
source "$ZDOTDIR/plugins/forgit/forgit.plugin.zsh"

if [ -f "$ZDOTDIR/plugins/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh" ]; then
    source "$ZDOTDIR/plugins/zsh-fzf-history-search/zsh-fzf-history-search.plugin.zsh"
else
    # enable incremental history search
    bindkey '^R' history-incremental-pattern-search-backward
fi

source "$ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

ZVM_VI_SURROUND_BINDKEY="s-prefix"
ZVM_CURSOR_STYLE_ENABLED=false
ZVM_NORMAL_MODE_CURSOR=ZVM_CURSOR_BLOCK
ZVM_INSERT_MODE_CURSOR=ZVM_CURSOR_BEAM
# ZVM_VI_HIGHLIGHT_FOREGROUND=
# ZVM_VI_HIGHLIGHT_BACKGROUND=

# https://github.com/jeffreytse/zsh-vi-mode/issues/19
# redefine zsh-vi-mode yank and paste to allow copy and paste from clipboard
zvm_vi_yank () {
	zvm_yank
	printf %s "${CUTBUFFER}" | xclip -sel c
	zvm_exit_visual_mode
}

_zvm_vi_put_after () {
    CUTBUFFER=$(xclip -out -selection clipboard)
    zvm_vi_put_after
    zvm_highlight clear
}

_zvm_vi_put_before () {
    CUTBUFFER=$(xclip -out -selection clipboard)
    zvm_vi_put_before
    zvm_highlight clear
}

# unbind all history search bindings and rebind to fzf-history-search
function zvm_after_init() {
  bindkey '^r' fzf_history_search
  bindkey -r '^S'
  bindkey -r '^P'
  bindkey -r '^N'
}

function zvm_after_lazy_keybindings {
  zvm_define_widget _zvm_vi_put_after
  zvm_define_widget _zvm_vi_put_before

  zvm_bindkey vicmd 'p' _zvm_vi_put_after
  zvm_bindkey vicmd 'P' _zvm_vi_put_before
}

# aliases
[ -f $ZDOTDIR/.zsh_alias ] && source $ZDOTDIR/.zsh_alias

# completions
[ -f $ZDOTDIR/.zsh_completions ] && source $ZDOTDIR/.zsh_completions

# xorg
if [[ -z "${DISPLAY}" ]] && [[ "${XDG_VTNR}" -eq 1 ]]; then
   exec startx
fi
