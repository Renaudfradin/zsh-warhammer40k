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
  local ms_status="$1"
  case "${ms_status}" in
    ONLINE)   echo "${IMPERIAL_PROMPT_SACRED}" ;;
    DEGRADED) echo "${IMPERIAL_PROMPT_INCENSE}" ;;
    CRITICAL) echo "${IMPERIAL_PROMPT_WAX}" ;;
    *)        echo "${IMPERIAL_PROMPT_GRAY}" ;;
  esac
}

# ── Imperial Creed & Litanies ─────────────────────────────────────────────────

_imperial_random_line() {
  local file="$1"
  [[ -f "${file}" ]] || return 1
  local -a lines
  lines=("${(@f)$(grep -v '^[[:space:]]*$' "${file}")}")
  (( ${#lines[@]} > 0 )) || return 1
  echo "${lines[$(( RANDOM % ${#lines[@]} + 1 ))]}"
}

# Parse litanies.txt — blocks delimited by "=== Title ==="
_imperial_load_litanies() {
  local file="${IMPERIAL_ROOT}/assets/ascii/litanies.txt"
  local -a titles bodies
  titles=()
  bodies=()

  [[ -f "${file}" ]] || return 1

  local current_title="" current_body=""
  local line

  while IFS= read -r line; do
    if [[ "${line}" =~ '^===[[:space:]]*(.+)[[:space:]]*===$' ]]; then
      if [[ -n "${current_title}" ]]; then
        titles+=("${current_title}")
        bodies+=("${current_body}")
      fi
      current_title="${match[1]}"
      current_body=""
    elif [[ -n "${line}" ]]; then
      if [[ -n "${current_body}" ]]; then
        current_body+=$'\n'"${line}"
      else
        current_body="${line}"
      fi
    fi
  done < "${file}"

  if [[ -n "${current_title}" ]]; then
    titles+=("${current_title}")
    bodies+=("${current_body}")
  fi

  (( ${#titles[@]} > 0 )) || return 1

  typeset -ga IMPERIAL_LITANY_TITLES IMPERIAL_LITANY_BODIES
  IMPERIAL_LITANY_TITLES=("${titles[@]}")
  IMPERIAL_LITANY_BODIES=("${bodies[@]}")
}

_imperial_random_litany() {
  if (( ! ${+IMPERIAL_LITANY_TITLES} )) || (( ${#IMPERIAL_LITANY_TITLES[@]} == 0 )); then
    _imperial_load_litanies || return 1
  fi

  local idx=$(( RANDOM % ${#IMPERIAL_LITANY_TITLES[@]} + 1 ))
  REPLY_TITLE="${IMPERIAL_LITANY_TITLES[idx]}"
  REPLY_BODY="${IMPERIAL_LITANY_BODIES[idx]}"
}

imperial_creed() {
  local line
  line=$(_imperial_random_line "${IMPERIAL_ROOT}/assets/ascii/motd-quotes.txt")
  line="${line:-The Emperor protects.}"
  print -P "${IMPERIAL_PROMPT_IVORY}  ✦ ${line}${IMPERIAL_PROMPT_RESET}"
}

imperial_litany() {
  local title body line
  if ! _imperial_random_litany; then
    print -P ""
    print -P "${IMPERIAL_PROMPT_MECHANICUS}  ☩ LITANIE DE L'ESPRIT DE LA MACHINE ☩${IMPERIAL_PROMPT_RESET}"
    print -P ""
    print -P "${IMPERIAL_PROMPT_SACRED}  > Gloire à l'Omnimessie !${IMPERIAL_PROMPT_RESET}"
    print -P ""
    return
  fi

  title="${REPLY_TITLE}"
  body="${REPLY_BODY}"

  print -P ""
  print -P "${IMPERIAL_PROMPT_MECHANICUS}  ☩ ${title} ☩${IMPERIAL_PROMPT_RESET}"
  print -P "${IMPERIAL_PROMPT_BRASS}  ─────────────────────────────────${IMPERIAL_PROMPT_RESET}"
  print -P ""

  while IFS= read -r line; do
    [[ -z "${line}" ]] && continue
    if [[ "${line}" =~ '^[01 ]+$' ]]; then
      print -P "${IMPERIAL_PROMPT_PLASMA}  ${line}${IMPERIAL_PROMPT_RESET}"
    else
      print -P "${IMPERIAL_PROMPT_IVORY}  ${line}${IMPERIAL_PROMPT_RESET}"
    fi
  done <<< "${body}"

  print -P ""
}

omnissiah() {
  imperial_litany
  print -P "${IMPERIAL_PROMPT_WAX}  ☩${IMPERIAL_PROMPT_SACRED}  GLOIRE À L'OMNIMESSIE  ${IMPERIAL_PROMPT_WAX}☩${IMPERIAL_PROMPT_RESET}"
  print -P "${IMPERIAL_PROMPT_MECHANICUS}  ☩${IMPERIAL_PROMPT_GOLD}  GLORY TO THE OMNISSIAH  ${IMPERIAL_PROMPT_MECHANICUS}☩${IMPERIAL_PROMPT_RESET}"
  print -P "${IMPERIAL_PROMPT_GOLD}  ⚙ Gloire à la Machine. Gloire à l'Omnimessie. ⚙${IMPERIAL_PROMPT_RESET}"
  print -P ""
}

# ── Welcome Banner — Cogitator Awakening Ritual ───────────────────────────────

# Inner width between ║ borders (re-source safe — no readonly)
typeset -gi IMPERIAL_BOX_INNER_WIDTH=38

_imperial_visible_width() {
  local expanded stripped
  expanded="$(print -P -- "$1")"
  stripped="$(print -r -- "${expanded}" | command sed -E 's/\x1B\[[0-9;]*[[:alpha:]]//g')"
  print -r -- ${#stripped}
}

_imperial_box_line() {
  local content="$1" visible_len pad
  visible_len="$(_imperial_visible_width "${content}")"
  if (( visible_len > IMPERIAL_BOX_INNER_WIDTH )); then
    visible_len=$IMPERIAL_BOX_INNER_WIDTH
  fi
  pad=$(( IMPERIAL_BOX_INNER_WIDTH - visible_len ))
  print -P -- "${IMPERIAL_PROMPT_GOLD}║${content}${(l:pad:: :)}${IMPERIAL_PROMPT_GOLD}║${IMPERIAL_PROMPT_RESET}"
}

imperial_welcome_banner() {
  [[ -n "${IMPERIAL_BANNER_SHOWN:-}" ]] && return
  export IMPERIAL_BANNER_SHOWN=1

  if [[ "${IMPERIAL_BANNER:-1}" == "0" ]]; then
    return
  fi

  local spirit_status level status_color litany
  spirit_status=$(_machine_spirit_status)
  level=$(access_level)
  status_color=$(_machine_spirit_color "${spirit_status}")

  local vessel
  vessel="$(hostname -s 2>/dev/null || hostname)"
  vessel="${vessel:0:$(( IMPERIAL_BOX_INNER_WIDTH - 18 ))}"

  print -P ""
  print -P "${IMPERIAL_PROMPT_COG}     ⚙⚙⚙  COGITATEUR EN ÉVEIL  ⚙⚙⚙${IMPERIAL_PROMPT_RESET}"
  print -P ""
  print -P "${IMPERIAL_PROMPT_GOLD}╔${(l:$IMPERIAL_BOX_INNER_WIDTH::═:)}╗${IMPERIAL_PROMPT_RESET}"
  _imperial_box_line "${IMPERIAL_PROMPT_IVORY}   IMPERIAL COMMAND TERMINAL"
  _imperial_box_line "${IMPERIAL_PROMPT_MECHANICUS}   Adeptus Mechanicus · Mars"
  print -P "${IMPERIAL_PROMPT_GOLD}╠${(l:$IMPERIAL_BOX_INNER_WIDTH::═:)}╣${IMPERIAL_PROMPT_RESET}"
  _imperial_box_line "${IMPERIAL_PROMPT_BRASS} Machine Spirit : ${status_color}${spirit_status}"
  _imperial_box_line "${IMPERIAL_PROMPT_BRASS} Access Level   : ${IMPERIAL_PROMPT_SACRED}${level}"
  _imperial_box_line "${IMPERIAL_PROMPT_BRASS} Forge Vessel   : ${IMPERIAL_PROMPT_IVORY}${vessel}"
  print -P "${IMPERIAL_PROMPT_GOLD}╚${(l:$IMPERIAL_BOX_INNER_WIDTH::═:)}╝${IMPERIAL_PROMPT_RESET}"

  # Machine Spirit litany (random full litany)
  imperial_litany

  # Omnissiah glorification
  print -P "${IMPERIAL_PROMPT_WAX}  ☩${IMPERIAL_PROMPT_SACRED}  GLOIRE À L'OMNIMESSIE  ${IMPERIAL_PROMPT_WAX}☩${IMPERIAL_PROMPT_RESET}"
  print -P "${IMPERIAL_PROMPT_MECHANICUS}  ☩${IMPERIAL_PROMPT_GOLD}  GLORY TO THE OMNISSIAH  ${IMPERIAL_PROMPT_MECHANICUS}☩${IMPERIAL_PROMPT_RESET}"
  print -P ""

  # Sacred creed
  print -P "${IMPERIAL_PROMPT_BRASS}  ── Credo Imperialis ──${IMPERIAL_PROMPT_RESET}"
  imperial_creed
  print -P ""

  # Boot confirmation
  case "${spirit_status}" in
    ONLINE)
      print -P "${IMPERIAL_PROMPT_GOLD}  ⚙ Esprit de la Machine : ${IMPERIAL_PROMPT_IVORY}consacré et opérationnel.${IMPERIAL_PROMPT_RESET}"
      print -P "${IMPERIAL_PROMPT_GOLD}  ⚙ Machine Spirit     : ${IMPERIAL_PROMPT_IVORY}sanctified and ready.${IMPERIAL_PROMPT_RESET}"
      ;;
    DEGRADED)
      print -P "${IMPERIAL_PROMPT_INCENSE}  ⚠ Esprit de la Machine : ${IMPERIAL_PROMPT_IVORY}dégradé — rites de maintenance recommandés.${IMPERIAL_PROMPT_RESET}"
      ;;
    CRITICAL)
      print -P "${IMPERIAL_PROMPT_RED}  ☠ Esprit de la Machine : ${IMPERIAL_PROMPT_IVORY}critique — intervention du Mechanicus requise.${IMPERIAL_PROMPT_RESET}"
      ;;
  esac
  print -P ""
}

# ── Machine Spirit Diagnostics ──────────────────────────────────────────────────

machine_spirit() {
  local spirit_status level
  spirit_status=$(_machine_spirit_status)
  level=$(access_level)
  local status_color=$(_machine_spirit_color "${spirit_status}")

  echo "${IMPERIAL_PROMPT_GOLD}═══ MACHINE SPIRIT DIAGNOSTICS ═══${IMPERIAL_PROMPT_RESET}"
  echo "${IMPERIAL_PROMPT_BRASS}Status:${IMPERIAL_PROMPT_RESET}       ${status_color}${spirit_status}${IMPERIAL_PROMPT_RESET}"
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

# ── Ritual Feedback (unknown command / success) ─────────────────────────────────

_imperial_cmd_ran=0

command_not_found_handler() {
  print -P ""
  print -P "${IMPERIAL_PROMPT_RED}☠ Le rituel a échoué — incantation inconnue : ${IMPERIAL_PROMPT_IVORY}${1}${IMPERIAL_PROMPT_RESET}"
  print -P "${IMPERIAL_PROMPT_WAX}☠ Ritual failed — unknown incantation: ${IMPERIAL_PROMPT_IVORY}${1}${IMPERIAL_PROMPT_RESET}"
  print -P ""
  return 127
}

_imperial_ritual_feedback_precmd() {
  [[ "${IMPERIAL_RITUAL_FEEDBACK:-1}" == "0" ]] && return
  [[ "${_imperial_cmd_ran}" -eq 0 ]] && return
  _imperial_cmd_ran=0

  local exit_code=$?
  if (( exit_code == 0 )); then
    print -P "${IMPERIAL_PROMPT_GOLD}⚙ Le rituel est accompli. ${IMPERIAL_PROMPT_BRASS}Ritual complete.${IMPERIAL_PROMPT_RESET}"
  fi
}

# ── Ritual Spinner (slow precmd) ────────────────────────────────────────────────

_imperial_ritual_frames=(⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏)
_imperial_ritual_idx=0
_imperial_precmd_start=0

_imperial_preexec_timer() {
  _imperial_precmd_start=$EPOCHREALTIME
  _imperial_cmd_ran=1
}

_imperial_precmd_ritual() {
  _imperial_ritual_feedback_precmd

  if [[ -z "${_imperial_precmd_start}" ]]; then
    return
  fi
  if (( EPOCHREALTIME - _imperial_precmd_start > 0.3 )); then
    _imperial_ritual_idx=$(( (_imperial_ritual_idx + 1) % ${#_imperial_ritual_frames[@]} ))
    # Print on a new line — never use \r (corrupts ZLE and can double characters)
    print -P "${IMPERIAL_PROMPT_GOLD}⚙ ${_imperial_ritual_frames[_imperial_ritual_idx]} RITUAL IN PROGRESS${IMPERIAL_PROMPT_RESET}"
  fi
  _imperial_precmd_start=""
}

if [[ "${IMPERIAL_RITUAL_SPINNER:-1}" != "0" || "${IMPERIAL_RITUAL_FEEDBACK:-1}" != "0" ]]; then
  autoload -Uz add-zsh-hook
  add-zsh-hook preexec _imperial_preexec_timer
  add-zsh-hook precmd _imperial_precmd_ritual
fi
