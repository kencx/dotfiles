alias sudo="sudo "
alias showpath="echo $PATH | tr ':' '\n'"

alias less="less -R"
alias diff="diff -u"

alias xclip="xclip -selection clipboard"
alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -o -selection clipboard"

alias ls='ls --color=auto'
alias la='ls -la --color=auto'
alias ll='ls -la --color=auto'
alias lah='ls -lah --color=auto'

alias dc="docker compose"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dps="docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Networks}}\t{{.Status}}'"
alias dl="docker logs -f"

function dce {
    docker exec -it $1 bash
}

alias gst='git status'
alias gap='git -c color.diff=true add --patch'
alias gc='git commit --verbose'
alias gp='git push'
alias gds='git diff --staged'

# delete branches
function gcbd {
    git branch |
        grep --invert-match '\*' |
        cut -c 3- |
        fzf --multi --preview="git log {} --" |
        xargs --no-run-if-empty git branch --delete --force
}

function gw {
    select=$(git worktree list | fzf | cut -d ' ' -f1)
    if [[ -n "$select" ]]; then
        cd "$select" || exit
    fi
}

alias syscat='systemctl cat'
alias sys='systemctl status'
alias sysstart='sudo systemctl start'
alias sysrestart='sudo systemctl restart'
alias sysstop='sudo systemctl stop'
alias sysdr='sudo systemctl daemon-reload'

alias adoc="ansible-doc"

function certcat {
    openssl x509 -text -noout -in "$1"
}

function cheat {
    curl "cheat.sh/$1"
}
