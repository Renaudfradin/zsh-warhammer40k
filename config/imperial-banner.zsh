# Imperial Command Terminal — Banner & Ritual Spinner
# Sourced after functions.zsh defines helpers

# Toggle banner: export IMPERIAL_BANNER=0 to disable
# Toggle spinner: export IMPERIAL_RITUAL_SPINNER=0 to disable

# Aliases for functions (must be defined after functions.zsh)
alias gloire='omnissiah'

# Re-display full awakening ritual on demand
alias banner='unset IMPERIAL_BANNER_SHOWN; imperial_welcome_banner'
alias eveil='unset IMPERIAL_BANNER_SHOWN; imperial_welcome_banner'
