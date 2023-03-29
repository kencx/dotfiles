alias sudo="sudo "
alias showpath="echo $PATH | tr ':' '\n'"

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

alias syscat='systemctl cat'
alias sys='systemctl status'
alias sysstart='sudo systemctl start'
alias sysrestart='sudo systemctl restart'
alias sysstop='sudo systemctl stop'
alias sysdr='sudo systemctl daemon-reload'

function certcat {
    openssl x509 -text -noout -in "$1"
}
