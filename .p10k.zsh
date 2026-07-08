# Imperial Command Terminal — Powerlevel10k Configuration
# Generated for Adeptus Mechanicus cogitator consoles
# Font: MesloLGS NF or JetBrainsMono Nerd Font

'builtin' 'source' "${IMPERIAL_ROOT:-$HOME}/config/colors.zsh" 2>/dev/null || true

() {
  emulate -L zsh -o extended_glob

  typeset -g POWERLEVEL9K_MODE=nerdfont-complete
  typeset -g POWERLEVEL9K_ICON_PADDING=moderate

  # Instant prompt
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

  # Two-line prompt
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX=''

  # Transient prompt
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always

  local theme_mode="${IMPERIAL_THEME_MODE:-imperial}"
  case "${theme_mode:l}" in
    chaos|warp|ruin|heretic)
      # Prompt char — Warp sigil
      typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_CONTENT_EXPANSION='⛧'
      typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_CONTENT_EXPANSION='☣'
      typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='⛧'
      typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_FOREGROUND=201
      typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_FOREGROUND=196
      typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_FOREGROUND=201
      ;;
    *)
      # Prompt char — Holy Aquila
      typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_CONTENT_EXPANSION='⚜'
      typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_CONTENT_EXPANSION='☩'
      typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='⚜'
      typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_FOREGROUND=220
      typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_FOREGROUND=196
      typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_FOREGROUND=220
      ;;
  esac
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_{LEFT,RIGHT}_WHITESPACE=''

  # Segment separators
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''

  # ── Line 1: Status Rail (left) ──────────────────────────────────────────────

  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    os_icon
    user
    host
    dir
    date
    time
    status
  )

  # ── Line 1: Status Rail (right) ─────────────────────────────────────────────

  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    load
    ram
    disk_usage
  )

  case "${theme_mode:l}" in
    chaos|warp|ruin|heretic)
      # OS icon — Warp corruption
      typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=201
      typeset -g POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION='☣'

      # User — heretek magenta
      typeset -g POWERLEVEL9K_USER_FOREGROUND=225
      typeset -g POWERLEVEL9K_USER_ICON='☣'
      typeset -g POWERLEVEL9K_USER_DEFAULT_FOREGROUND=225
      typeset -g POWERLEVEL9K_USER_ROOT_FOREGROUND=196
      typeset -g POWERLEVEL9K_USER_ROOT_ICON='⛧'
      typeset -g POWERLEVEL9K_USER_TEMPLATE='%n'

      # Host — warp sigil
      typeset -g POWERLEVEL9K_HOST_FOREGROUND=171
      typeset -g POWERLEVEL9K_HOST_ICON='⛧'
      typeset -g POWERLEVEL9K_HOST_TEMPLATE='%m'

      # Directory — tainted parchment
      typeset -g POWERLEVEL9K_DIR_FOREGROUND=225
      typeset -g POWERLEVEL9K_DIR_ICON='☣'
      typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=171
      typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=201
      typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
      typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
      typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
      typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=60

      # Date & Time — warp bruised brass
      typeset -g POWERLEVEL9K_DATE_FOREGROUND=213
      typeset -g POWERLEVEL9K_DATE_ICON='☣'
      typeset -g POWERLEVEL9K_TIME_FOREGROUND=225
      typeset -g POWERLEVEL9K_TIME_ICON='⌛'
      typeset -g POWERLEVEL9K_TIME_FORMAT='%H:%M'
      ;;
    *)
      # OS icon — Cog Mechanicum
      typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=214
      typeset -g POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION='⚙'

      # User — Tech-Priest gold
      typeset -g POWERLEVEL9K_USER_FOREGROUND=220
      typeset -g POWERLEVEL9K_USER_ICON='⚙'
      typeset -g POWERLEVEL9K_USER_DEFAULT_FOREGROUND=220
      typeset -g POWERLEVEL9K_USER_ROOT_FOREGROUND=196
      typeset -g POWERLEVEL9K_USER_ROOT_ICON='☩'
      typeset -g POWERLEVEL9K_USER_TEMPLATE='%n'

      # Host — brass forge vessel
      typeset -g POWERLEVEL9K_HOST_FOREGROUND=130
      typeset -g POWERLEVEL9K_HOST_ICON='⚜'
      typeset -g POWERLEVEL9K_HOST_TEMPLATE='%m'

      # Directory (Sector) — parchment with brass anchor
      typeset -g POWERLEVEL9K_DIR_FOREGROUND=187
      typeset -g POWERLEVEL9K_DIR_ICON='☩'
      typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=130
      typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=220
      typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
      typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
      typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
      typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=60

      # Date & Time — incense brass
      typeset -g POWERLEVEL9K_DATE_FOREGROUND=172
      typeset -g POWERLEVEL9K_DATE_ICON='☩'
      typeset -g POWERLEVEL9K_TIME_FOREGROUND=187
      typeset -g POWERLEVEL9K_TIME_ICON='⌛'
      typeset -g POWERLEVEL9K_TIME_FORMAT='%H:%M'
      ;;
  esac

  # Status (exit code) — skull of failure
  typeset -g POWERLEVEL9K_STATUS_OK=false
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE=false
  typeset -g POWERLEVEL9K_STATUS_ERROR=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=196
  typeset -g POWERLEVEL9K_STATUS_ERROR_ICON='☠'
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL=true
  typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=false

  # Load — cogitator strain
  typeset -g POWERLEVEL9K_LOAD_FOREGROUND=220
  typeset -g POWERLEVEL9K_LOAD_NORMAL_FOREGROUND=220
  typeset -g POWERLEVEL9K_LOAD_WARNING_FOREGROUND=214
  typeset -g POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND=196
  typeset -g POWERLEVEL9K_LOAD_ICON='⚡'

  # RAM
  typeset -g POWERLEVEL9K_RAM_FOREGROUND=130
  typeset -g POWERLEVEL9K_RAM_ICON='🧠'

  # Disk
  typeset -g POWERLEVEL9K_DISK_USAGE_NORMAL_FOREGROUND=130
  typeset -g POWERLEVEL9K_DISK_USAGE_WARNING_FOREGROUND=172
  typeset -g POWERLEVEL9K_DISK_USAGE_CRITICAL_FOREGROUND=196
  typeset -g POWERLEVEL9K_DISK_USAGE_ICON='💾'

  # ── Line 2: Operations Rail ─────────────────────────────────────────────────

  typeset -g POWERLEVEL9K_PROMPT_ON_NEWLINE=true

  # We'll use a custom two-line setup via POWERLEVEL9K prompt elements on newline
  # p10k uses POWERLEVEL9K prompt with newline - configure second line via custom

  # For line 2, we add elements after newline in left prompt
  # Powerlevel10k supports this via POWERLEVEL9K_PROMPT_ELEMENTS with newline

  # Reconfigure for two-line with newline separator
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    os_icon
    user
    host
    dir
    date
    time
    newline
    vcs
    python
    nodenv
    rust_version
    battery
    command_execution_time
    kubecontext
    docker_context
    aws
    azure
    gcloud
    context
    status
    background_jobs
    prompt_char
  )

  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    load
    ram
    disk_usage
    tmux
  )

  # ── Git (VCS) ───────────────────────────────────────────────────────────────

  case "${theme_mode:l}" in
    chaos|warp|ruin|heretic)
      typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=225
      typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=196
      typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=201
      typeset -g POWERLEVEL9K_VCS_CONFLICTED_FOREGROUND=52
      typeset -g POWERLEVEL9K_VCS_CONFLICTED_BACKGROUND=52
      typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=213

      typeset -g POWERLEVEL9K_VCS_BRANCH_ICON='🜁'
      typeset -g POWERLEVEL9K_VCS_COMMIT_ICON='📜'
      typeset -g POWERLEVEL9K_VCS_ICON='🜏'
      typeset -g POWERLEVEL9K_VCS_STAGED_ICON='✚'
      typeset -g POWERLEVEL9K_VCS_UNSTAGED_ICON='!'
      typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
      typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='⇣'
      typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='⇡'

      # Staged = warped parchment
      typeset -g POWERLEVEL9K_VCS_STAGED_FOREGROUND=225
      typeset -g POWERLEVEL9K_VCS_UNSTAGED_FOREGROUND=196
      ;;
    *)
      typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=220
      typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=160
      typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=167
      typeset -g POWERLEVEL9K_VCS_CONFLICTED_FOREGROUND=52
      typeset -g POWERLEVEL9K_VCS_CONFLICTED_BACKGROUND=52
      typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=172

      typeset -g POWERLEVEL9K_VCS_BRANCH_ICON='🛡'
      typeset -g POWERLEVEL9K_VCS_COMMIT_ICON='📜'
      typeset -g POWERLEVEL9K_VCS_ICON='🧬'
      typeset -g POWERLEVEL9K_VCS_STAGED_ICON='✚'
      typeset -g POWERLEVEL9K_VCS_UNSTAGED_ICON='!'
      typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
      typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='⇣'
      typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='⇡'

      # Staged = ivory purity seal
      typeset -g POWERLEVEL9K_VCS_STAGED_FOREGROUND=187
      typeset -g POWERLEVEL9K_VCS_UNSTAGED_FOREGROUND=160
      ;;
  esac

  function prompt_vcs_instant_prompt() {
    POWERLEVEL9K_VCS_INSTANT_PROMPT=quiet
    prompt_vcs
  }

  typeset -g POWERLEVEL9K_VCS_MAX_INDEX_SIZE=1
  typeset -g POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN='~'

  # Python — plasma arc
  typeset -g POWERLEVEL9K_PYTHON_FOREGROUND=111
  typeset -g POWERLEVEL9K_PYTHON_ICON='⚡'
  typeset -g POWERLEVEL9K_PYTHON_SHOW_VERSION=true

  # Node
  typeset -g POWERLEVEL9K_NODENV_FOREGROUND=187
  typeset -g POWERLEVEL9K_NODENV_ICON='⬢'
  typeset -g POWERLEVEL9K_NODEENV_FOREGROUND=187
  typeset -g POWERLEVEL9K_NODEENV_ICON='⬢'
  typeset -g POWERLEVEL9K_NODE_VERSION_FOREGROUND=187
  typeset -g POWERLEVEL9K_NODE_VERSION_ICON='⬢'

  # Rust — forge metal
  typeset -g POWERLEVEL9K_RUST_VERSION_FOREGROUND=178
  typeset -g POWERLEVEL9K_RUST_VERSION_ICON='🦀'

  # Battery — radium reserves
  typeset -g POWERLEVEL9K_BATTERY_LOW_THRESHOLD=20
  typeset -g POWERLEVEL9K_BATTERY_LOW_FOREGROUND=196
  typeset -g POWERLEVEL9K_BATTERY_CHARGING_FOREGROUND=220
  typeset -g POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND=172
  typeset -g POWERLEVEL9K_BATTERY_ICON='☢'

  # Command execution time
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=172
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_ICON='⌛'

  # Kubernetes
  typeset -g POWERLEVEL9K_KUBECONTEXT_FOREGROUND=111
  typeset -g POWERLEVEL9K_KUBECONTEXT_ICON='🛰'
  typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx'

  # Docker
  typeset -g POWERLEVEL9K_DOCKER_CONTEXT_FOREGROUND=111
  typeset -g POWERLEVEL9K_DOCKER_CONTEXT_ICON='🐳'
  typeset -g POWERLEVEL9K_DOCKER_MACHINE_FOREGROUND=111
  typeset -g POWERLEVEL9K_DOCKER_MACHINE_ICON='🐳'

  # Cloud profiles
  typeset -g POWERLEVEL9K_AWS_FOREGROUND=111
  typeset -g POWERLEVEL9K_AWS_ICON='☁'
  typeset -g POWERLEVEL9K_AWS_SHOW_ON_COMMAND='aws|awless|terraform|pulumi|terragrunt'
  typeset -g POWERLEVEL9K_AZURE_FOREGROUND=111
  typeset -g POWERLEVEL9K_AZURE_ICON='☁'
  typeset -g POWERLEVEL9K_GCLOUD_FOREGROUND=111
  typeset -g POWERLEVEL9K_GCLOUD_ICON='☁'
  typeset -g POWERLEVEL9K_GCLOUD_SHOW_ON_COMMAND='gcloud|gsutil|bq|gke-gcloud-auth-plugin'

  # Root context warning — heresy detected
  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_FOREGROUND=220
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=196
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND=52
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_ICON='☩'
  typeset -g POWERLEVEL9K_CONTEXT_ICON='🦅'

  # Background jobs
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=214
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_ICON='⚙'

  # Tmux
  typeset -g POWERLEVEL9K_TMUX_FOREGROUND=220
  typeset -g POWERLEVEL9K_TMUX_ICON='🛰'
  typeset -g POWERLEVEL9K_TMUX_VISUAL_IDENTIFIER_EXPANSION='🛰'
  typeset -g POWERLEVEL9K_TMUX_CONTENT_EXPANSION='${P9K_TMUX_SESSION_NAME}'

  # Instant prompt colors
  typeset -g POWERLEVEL9K_INSTANT_PROMPT_COMMAND_LINES=1

  # No wizard on first run — we ship preconfigured
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  (( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
  'builtin' 'unset' 'p10k_config_opts'
}

(( ! ${+functions[p10k]} )) || p10k reload
