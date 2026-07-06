# Imperial Command Terminal — Tool Integration
# bat, eza, fzf, zoxide, ripgrep, fd, thefuck

# ── Platform binary detection (Linux package naming) ─────────────────────────

if command -v bat &>/dev/null; then
  export IMPERIAL_BAT="bat"
elif command -v batcat &>/dev/null; then
  export IMPERIAL_BAT="batcat"
  alias bat='batcat'
fi

if command -v fd &>/dev/null; then
  export IMPERIAL_FD="fd"
elif command -v fdfind &>/dev/null; then
  export IMPERIAL_FD="fdfind"
  alias fd='fdfind'
fi

# ── bat — Holy Scripture Viewer ──────────────────────────────────────────────

if [[ -n "${IMPERIAL_BAT:-}" ]]; then
  export BAT_THEME="ansi"
  export BAT_STYLE="numbers,changes,header"
  alias cat="${IMPERIAL_BAT}"
  alias sanctify="${IMPERIAL_BAT}"

  # man pages via bat
  if [[ -n "${IMPERIAL_BAT}" ]]; then
    export MANPAGER="sh -c 'col -bx | ${IMPERIAL_BAT} -l man -p \"man %s\" --paging=always'"
  fi
fi

# ── eza — Reliquary Archive Browser ──────────────────────────────────────────

if command -v eza &>/dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -la --icons --group-directories-first --git'
  alias la='eza -a --icons --group-directories-first'
  alias lt='eza -T --icons --level=2'
  alias tree='eza -T --icons'
  alias reliquary='eza -la --icons --group-directories-first --git'
fi

# ── ripgrep — Auspex Scanner ─────────────────────────────────────────────────

if command -v rg &>/dev/null; then
  export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"
  alias auspex='rg'
  alias purge-scan='rg --hidden --glob "!node_modules" --glob "!.git"'
fi

# ── fd — Deep Auspex Sweep ───────────────────────────────────────────────────

if [[ -n "${IMPERIAL_FD:-}" ]]; then
  alias seek="${IMPERIAL_FD}"
  export FZF_DEFAULT_COMMAND="${IMPERIAL_FD} --type f --hidden --follow --exclude .git"
  export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
fi

# ── fzf — Imperial Cogitator Search ──────────────────────────────────────────

if command -v fzf &>/dev/null; then
  export FZF_DEFAULT_OPTS="
    --height 40%
    --layout=reverse
    --border=rounded
    --color=bg+:#1a1a1a,bg:#0b0b0b,spinner:#e8a020,hl:#a61d24
    --color=fg:#d8d0b0,header:#ffd700,info:#8f6b32,pointer:#ffd700
    --color=marker:#66b6ff,fg+:#d8d0b0,prompt:#9b111e,hl+:#cc2200
    --color=border:#8f6b32,label:#bfa35f,query:#d8d0b0
  "

  export FZF_CTRL_T_OPTS="--preview 'if [[ -d {} ]]; then eza -T --level=1 --icons {}; elif [[ -f {} ]]; then ${IMPERIAL_BAT:-cat} --color=always {}; fi'"

  export FZF_ALT_C_OPTS="--preview 'eza -T --level=1 --icons {}'"

  # Ctrl+R history
  fzf_history() {
    local selected
    selected=$(fc -rl 1 | fzf --query="${LBUFFER}" --preview 'echo {}' --preview-window=down:3:hidden:wrap --bind '?:toggle-preview')
    local ret=$?
    if [[ -n "${selected}" ]]; then
      if [[ -n "${LBUFFER}" ]]; then
        LBUFFER="${LBUFFER}${selected}"
      else
        LBUFFER="${selected}"
      fi
      zle redisplay
    fi
    return $ret
  }
  zle -N fzf_history
  bindkey '^R' fzf_history

  # Ctrl+T file search
  if [[ -n "${IMPERIAL_FD:-}" ]]; then
    fzf_file() {
      local selected
      selected=$(${IMPERIAL_FD} --type f --hidden --follow --exclude .git 2>/dev/null | fzf --preview "${IMPERIAL_BAT:-cat} --color=always {}")
      if [[ -n "${selected}" ]]; then
        LBUFFER="${LBUFFER}${selected}"
        zle redisplay
      fi
    }
    zle -N fzf_file
    bindkey '^T' fzf_file
  fi

  # Alt+C directory jump
  fzf_cd() {
    local dir
    dir=$(FZF_DEFAULT_COMMAND="${IMPERIAL_FD:-find . -type d}" fzf --preview 'eza -T --level=1 --icons {}')
    if [[ -n "${dir}" ]]; then
      cd "${dir}" || return
      zle reset-prompt
    fi
  }
  zle -N fzf_cd
  bindkey '\ec' fzf_cd
fi

# ── zoxide — Warp Navigation ─────────────────────────────────────────────────
# Initialized in .zshrc after modules load

# ── thefuck — Rite of Repair ─────────────────────────────────────────────────

if command -v thefuck &>/dev/null; then
  export THEFUCK_PRIORITY='sudo, man, cd, git, docker, kubectl'
  export THEFUCK_REQUIRE_CONFIRMATION='true'
fi

# ── htop/btop — Cogitator Monitor ────────────────────────────────────────────

if command -v btop &>/dev/null; then
  alias cogitator='btop'
elif command -v htop &>/dev/null; then
  alias cogitator='htop'
elif command -v top &>/dev/null; then
  alias cogitator='top'
fi
