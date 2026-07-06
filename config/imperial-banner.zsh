# Imperial Command Terminal — Banner & Ritual Spinner
# Sourced after functions.zsh defines helpers

# Banner display is triggered from .zshrc via imperial_welcome_banner
# Ritual spinner hooks are registered in functions.zsh

# Toggle banner: export IMPERIAL_BANNER=0 to disable
# Toggle spinner: export IMPERIAL_RITUAL_SPINNER=0 to disable

# Re-display banner on demand
alias banner='unset IMPERIAL_BANNER_SHOWN; imperial_welcome_banner'
