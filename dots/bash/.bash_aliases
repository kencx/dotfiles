alias dc="docker compose"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dps="docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Networks}}\t{{.Status}}'"
alias dl="docker logs -f"

alias duh="sudo du -h --one-file-system --max-depth=1 --threshold=100K | sort -h"
