# Imperial Command Terminal — Utility Functions

# ── Access Level ──────────────────────────────────────────────────────────────

access_level() {
  if [[ "${EUID}" -eq 0 ]]; then
    echo "PRIMARCH"
  elif groups 2>/dev/null | grep -qE '\b(sudo|wheel|admin)\b'; then
    echo "MAGOS"
  else
    echo "INITIATE"
  fi
}

# ── Machine Spirit Status ─────────────────────────────────────────────────────

_machine_spirit_status() {
  local load
  load=$(sysctl -n vm.loadavg 2>/dev/null | awk '{print $2}')
  if [[ -z "${load}" ]]; then
    load=$(awk '{print $1}' /proc/loadavg 2>/dev/null)
  fi

  # Battery check
  local battery_pct=""
  if command -v pmset &>/dev/null; then
    battery_pct=$(pmset -g batt 2>/dev/null | grep -oE '[0-9]+%' | tr -d '%' | head -1)
  elif [[ -f /sys/class/power_supply/BAT0/capacity ]]; then
    battery_pct=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
  fi

  if [[ -n "${battery_pct}" && "${battery_pct}" -lt 10 ]]; then
    echo "CRITICAL"
    return
  fi

  if [[ -n "${load}" ]]; then
    local load_int=${load%.*}
    if [[ "${load_int}" -ge 8 ]]; then
      echo "DEGRADED"
      return
    fi
  fi

  echo "ONLINE"
}

_machine_spirit_color() {
  local status="$1"
  case "${status}" in
    ONLINE)   echo "${IMPERIAL_PROMPT_GOLD}" ;;
    DEGRADED) echo "%F{214}" ;;
    CRITICAL) echo "${IMPERIAL_PROMPT_RED}" ;;
    *)        echo "${IMPERIAL_PROMPT_GRAY}" ;;
  esac
}

# ── Imperial Creed ────────────────────────────────────────────────────────────

imperial_creed() {
  local quotes_file="${IMPERIAL_ROOT}/assets/ascii/motd-quotes.txt"
  if [[ ! -f "${quotes_file}" ]]; then
    echo "${IMPERIAL_PROMPT_IVORY}\"The Emperor protects.\"${IMPERIAL_PROMPT_RESET}"
    return
  fi
  local -a lines
  lines=("${(@f)$(grep -v '^[[:space:]]*$' "${quotes_file}")}")
  if (( ${#lines[@]} == 0 )); then
    echo "${IMPERIAL_PROMPT_IVORY}\"The Emperor protects.\"${IMPERIAL_PROMPT_RESET}"
    return
  fi
  local line="${lines[$(( RANDOM % ${#lines[@]} + 1 ))]}"
  echo "${IMPERIAL_PROMPT_IVORY}\"${line}\"${IMPERIAL_PROMPT_RESET}"
}

# ── Welcome Banner ────────────────────────────────────────────────────────────

imperial_welcome_banner() {
  [[ -n "${IMPERIAL_BANNER_SHOWN:-}" ]] && return
  export IMPERIAL_BANNER_SHOWN=1

  if [[ "${IMPERIAL_BANNER:-1}" == "0" ]]; then
    return
  fi

  local status level status_color
  status=$(_machine_spirit_status)
  level=$(access_level)
  status_color=$(_machine_spirit_color "${status}")

  echo ""
  echo "${IMPERIAL_PROMPT_GOLD}╔══════════════════════════════════╗${IMPERIAL_PROMPT_RESET}"
  echo "${IMPERIAL_PROMPT_GOLD}║${IMPERIAL_PROMPT_IVORY} IMPERIAL COMMAND TERMINAL        ${IMPERIAL_PROMPT_GOLD}║${IMPERIAL_PROMPT_RESET}"
  echo "${IMPERIAL_PROMPT_GOLD}║${IMPERIAL_PROMPT_BRASS} Machine Spirit : ${status_color}${status}${IMPERIAL_PROMPT_GOLD}          ║${IMPERIAL_PROMPT_RESET}"
  echo "${IMPERIAL_PROMPT_GOLD}║${IMPERIAL_PROMPT_BRASS} Access Level   : ${IMPERIAL_PROMPT_GOLD}${level}${IMPERIAL_PROMPT_GOLD}             ║${IMPERIAL_PROMPT_RESET}"
  echo "${IMPERIAL_PROMPT_GOLD}╚══════════════════════════════════╝${IMPERIAL_PROMPT_RESET}"
  echo ""
  imperial_creed
  echo ""
}

# ── Machine Spirit Diagnostics ──────────────────────────────────────────────────

machine_spirit() {
  local status level
  status=$(_machine_spirit_status)
  level=$(access_level)
  local status_color=$(_machine_spirit_color "${status}")

  echo "${IMPERIAL_PROMPT_GOLD}═══ MACHINE SPIRIT DIAGNOSTICS ═══${IMPERIAL_PROMPT_RESET}"
  echo "${IMPERIAL_PROMPT_BRASS}Status:${IMPERIAL_PROMPT_RESET}       ${status_color}${status}${IMPERIAL_PROMPT_RESET}"
  echo "${IMPERIAL_PROMPT_BRASS}Clearance:${IMPERIAL_PROMPT_RESET}    ${IMPERIAL_PROMPT_GOLD}${level}${IMPERIAL_PROMPT_RESET}"
  echo "${IMPERIAL_PROMPT_BRASS}Sector:${IMPERIAL_PROMPT_RESET}       ${IMPERIAL_PROMPT_IVORY}$(pwd)${IMPERIAL_PROMPT_RESET}"
  echo "${IMPERIAL_PROMPT_BRASS}Host:${IMPERIAL_PROMPT_RESET}         ${IMPERIAL_PROMPT_IVORY}$(hostname)${IMPERIAL_PROMPT_RESET}"
  echo "${IMPERIAL_PROMPT_BRASS}Operator:${IMPERIAL_PROMPT_RESET}     ${IMPERIAL_PROMPT_IVORY}${USER}${IMPERIAL_PROMPT_RESET}"
  if command -v uptime &>/dev/null; then
    echo "${IMPERIAL_PROMPT_BRASS}Uptime:${IMPERIAL_PROMPT_RESET}       ${IMPERIAL_PROMPT_IVORY}$(uptime | sed 's/.*up //')${IMPERIAL_PROMPT_RESET}"
  fi
}

# ── Imperial Status Dossier ───────────────────────────────────────────────────

imperial_status() {
  machine_spirit
  echo ""
  echo "${IMPERIAL_PROMPT_GOLD}═══ COGITATOR DOSSIER ═══${IMPERIAL_PROMPT_RESET}"

  if [[ "$(uname)" == "Darwin" ]]; then
    echo "${IMPERIAL_PROMPT_BRASS}OS:${IMPERIAL_PROMPT_RESET}         ${IMPERIAL_PROMPT_IVORY}$(sw_vers -productName) $(sw_vers -productVersion)${IMPERIAL_PROMPT_RESET}"
  else
    echo "${IMPERIAL_PROMPT_BRASS}OS:${IMPERIAL_PROMPT_RESET}         ${IMPERIAL_PROMPT_IVORY}$(uname -s) $(uname -r)${IMPERIAL_PROMPT_RESET}"
  fi

  if command -v git &>/dev/null && git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "${IMPERIAL_PROMPT_BRASS}Archive:${IMPERIAL_PROMPT_RESET}    ${IMPERIAL_PROMPT_IVORY}$(git branch --show-current 2>/dev/null) ($(git rev-parse --short HEAD 2>/dev/null))${IMPERIAL_PROMPT_RESET}"
  fi

  if command -v kubectl &>/dev/null; then
    local ctx
    ctx=$(kubectl config current-context 2>/dev/null)
    [[ -n "${ctx}" ]] && echo "${IMPERIAL_PROMPT_BRASS}Fleet:${IMPERIAL_PROMPT_RESET}       ${IMPERIAL_PROMPT_PLASMA}${ctx}${IMPERIAL_PROMPT_RESET}"
  fi

  if command -v docker &>/dev/null; then
    local dctx
    dctx=$(docker context show 2>/dev/null)
    [[ -n "${dctx}" ]] && echo "${IMPERIAL_PROMPT_BRASS}Forge:${IMPERIAL_PROMPT_RESET}      ${IMPERIAL_PROMPT_PLASMA}${dctx}${IMPERIAL_PROMPT_RESET}"
  fi
}

# ── Sector Navigation ─────────────────────────────────────────────────────────

sector() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: sector <path>"
    return 1
  fi
  cd "$@" || return
  echo "${IMPERIAL_PROMPT_GOLD}⚙ Entering sector:${IMPERIAL_PROMPT_RESET} ${IMPERIAL_PROMPT_IVORY}$(pwd)${IMPERIAL_PROMPT_RESET}"
  if command -v eza &>/dev/null; then
    eza --icons --group-directories-first
  else
    ls -la
  fi
}

# ── Servo-Skull — HTTP Health Probe ───────────────────────────────────────────

servo_skull() {
  local url="${1:-http://localhost}"
  local code time_total

  if ! command -v curl &>/dev/null; then
    echo "${IMPERIAL_PROMPT_RED}Servo-skull offline: curl not installed${IMPERIAL_PROMPT_RESET}"
    return 1
  fi

  echo "${IMPERIAL_PROMPT_GOLD}☠ Servo-skull deploying to ${url}...${IMPERIAL_PROMPT_RESET}"

  local result
  result=$(curl -s -o /dev/null -w "%{http_code} %{time_total}" --max-time 10 "${url}" 2>/dev/null)
  code=$(echo "${result}" | awk '{print $1}')
  time_total=$(echo "${result}" | awk '{print $2}')

  if [[ "${code}" =~ ^2 ]]; then
    echo "${IMPERIAL_PROMPT_GOLD}✓ Vox-link established${IMPERIAL_PROMPT_RESET} — HTTP ${code} (${time_total}s)"
  elif [[ "${code}" =~ ^[345] ]]; then
    echo "${IMPERIAL_PROMPT_RED}⚠ Heretical response${IMPERIAL_PROMPT_RESET} — HTTP ${code} (${time_total}s)"
  else
    echo "${IMPERIAL_PROMPT_RED}✗ Servo-skull lost${IMPERIAL_PROMPT_RESET} — no response"
    return 1
  fi
}

# ── Rite of Repair (thefuck wrapper) ──────────────────────────────────────────

rite_of_repair() {
  if ! command -v thefuck &>/dev/null; then
    echo "${IMPERIAL_PROMPT_RED}The Rite requires thefuck to be installed.${IMPERIAL_PROMPT_RESET}"
    return 1
  fi
  echo "${IMPERIAL_PROMPT_GOLD}⚙ Initiating Rite of Repair...${IMPERIAL_PROMPT_RESET}"
  BY_THE_THRONE
}

# ── Exterminatus — Guarded Destructive Operations ─────────────────────────────

exterminatus() {
  local target="${1:-git}"
  echo "${IMPERIAL_PROMPT_RED}☠ EXTERMINATUS PROTOCOL ENGAGED ☠${IMPERIAL_PROMPT_RESET}"
  echo "${IMPERIAL_PROMPT_IVORY}Target: ${target}${IMPERIAL_PROMPT_RESET}"
  echo -n "${IMPERIAL_PROMPT_GOLD}Type FOR_THE_EMPEROR to confirm: ${IMPERIAL_PROMPT_RESET}"
  read -r confirm
  if [[ "${confirm}" != "FOR_THE_EMPEROR" ]]; then
    echo "${IMPERIAL_PROMPT_BRASS}Exterminatus aborted. The Emperor's mercy prevails.${IMPERIAL_PROMPT_RESET}"
    return 1
  fi

  case "${target}" in
    git)
      git clean -fd
      echo "${IMPERIAL_PROMPT_GOLD}Sector purged of untracked corruption.${IMPERIAL_PROMPT_RESET}"
      ;;
    docker)
      docker system prune -af
      echo "${IMPERIAL_PROMPT_GOLD}Forge contamination eliminated.${IMPERIAL_PROMPT_RESET}"
      ;;
    *)
      echo "${IMPERIAL_PROMPT_RED}Unknown target. Supported: git, docker${IMPERIAL_PROMPT_RESET}"
      return 1
      ;;
  esac
}

# ── Ritual Spinner (slow precmd) ────────────────────────────────────────────────

_imperial_ritual_frames=(⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏)
_imperial_ritual_idx=0
_imperial_precmd_start=0

_imperial_preexec_timer() {
  _imperial_precmd_start=$EPOCHREALTIME
}

_imperial_precmd_ritual() {
  if [[ -z "${_imperial_precmd_start}" ]]; then
    return
  fi
  if (( EPOCHREALTIME - _imperial_precmd_start > 0.3 )); then
    _imperial_ritual_idx=$(( (_imperial_ritual_idx + 1) % ${#_imperial_ritual_frames[@]} ))
    print -Pn "${IMPERIAL_PROMPT_GOLD}⚙ ${_imperial_ritual_frames[_imperial_ritual_idx]} RITUAL IN PROGRESS${IMPERIAL_PROMPT_RESET}\r"
  fi
}

if [[ "${IMPERIAL_RITUAL_SPINNER:-1}" != "0" ]]; then
  autoload -Uz add-zsh-hook
  add-zsh-hook preexec _imperial_preexec_timer
  add-zsh-hook precmd _imperial_precmd_ritual
fi
