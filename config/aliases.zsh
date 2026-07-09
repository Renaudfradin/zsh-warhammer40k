# Imperial Command Terminal — Aliases
# Themed command aliases for the faithful

# ── Navigation ────────────────────────────────────────────────────────────────

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias warp='z'
alias astartes-drop='zi'

# ── Vox & Auspex ──────────────────────────────────────────────────────────────

alias vox='ping'
alias voxcast='ping -c 4'
alias chronicle='history'
alias chronicle-grep='history | grep'

# ── Git — Imperial Archive Protocols ──────────────────────────────────────────

alias gs='git status'
alias ga='git add .'
alias gaa='git add --all .'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph --decorate -20'
alias gla='git log --oneline --graph --decorate --all -30'
alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gsw='git switch'
alias gswc='git switch -c'
alias gst='git stash'
alias gstp='git stash pop'
alias gr='git remote -v'
alias gf='git fetch --all --prune'

# Imperial commit helper
alias gbless='git commit -m "By decree of the Machine Spirit:"'

# ── Docker & Kubernetes ───────────────────────────────────────────────────────

alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgn='kubectl get nodes'

# ── Safety-first destructive aliases ──────────────────────────────────────────
# Use functions in functions.zsh for guarded operations

alias purge='rm -i'
alias annihilate='rm -i'

# ── System dossier ────────────────────────────────────────────────────────────

alias dossier='imperial_status'
alias clearance='access_level'
alias creed='imperial_creed'
alias litany='imperial_litany'
alias priere='imperial_litany'
# Note: omnissiah and gloire are functions — aliases defined in imperial-banner.zsh

# ── tmux ──────────────────────────────────────────────────────────────────────

alias sanctum='tmux'
alias sanctum-attach='tmux attach -t'
alias sanctum-list='tmux list-sessions'

# ── Quick edits ───────────────────────────────────────────────────────────────

alias zshconfig='${EDITOR:-vim} "${IMPERIAL_ROOT}/.zshrc"'
alias p10kconfig='${EDITOR:-vim} "${HOME}/.p10k.zsh"'
alias reload='source "${HOME}/.zshrc" && echo "⚙ Machine Spirit re-initialized."'
