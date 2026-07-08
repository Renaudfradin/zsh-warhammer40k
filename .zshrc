# Imperial Command Terminal — Main ZSH Configuration
# Adeptus Mechanicus cogitator console for the faithful

# Resolve repo root (works with symlinked ~/.zshrc)
if [[ -n "${ZSH_IMPERIAL_ROOT:-}" ]]; then
  IMPERIAL_ROOT="$ZSH_IMPERIAL_ROOT"
elif [[ -L "${HOME}/.zshrc" ]]; then
  IMPERIAL_ROOT="$(cd "$(dirname "$(readlink "${HOME}/.zshrc")")" && pwd)"
elif [[ -f "${HOME}/.zshrc" ]]; then
  IMPERIAL_ROOT="$(cd "$(dirname "${HOME}/.zshrc")" && pwd)"
else
  IMPERIAL_ROOT="${HOME}/.config/imperial-zsh"
fi
export IMPERIAL_ROOT

# Local overrides and theme mode (gitignored)
[[ -f "${IMPERIAL_ROOT}/config/local.zsh" ]] && source "${IMPERIAL_ROOT}/config/local.zsh"

# Enable Powerlevel10k instant prompt (must be first)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh
export ZSH="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Imperial sudo prefix
export SUDO_PROMPT="☩ By decree of the Emperor, enter passphrase: "

# Plugins
plugins=(
  git
  docker
  kubectl
  tmux
  sudo
  zsh-autosuggestions
  # fzf: custom integration in config/tools.zsh (avoids duplicate key bindings)
)

# Load colors before OMZ for early styling
[[ -f "${IMPERIAL_ROOT}/config/colors.zsh" ]] && source "${IMPERIAL_ROOT}/config/colors.zsh"

# Oh My Zsh bootstrap
if [[ -f "${ZSH}/oh-my-zsh.sh" ]]; then
  source "${ZSH}/oh-my-zsh.sh"
else
  echo "${IMPERIAL_PROMPT_RED}⚠ Machine Spirit degraded: Oh My Zsh not found at ${ZSH}${IMPERIAL_PROMPT_RESET}"
  echo "Run ./install.sh to install the Imperial configuration."
fi

# Load fast-syntax-highlighting styles before plugin init
[[ -f "${IMPERIAL_ROOT}/config/syntax-highlighting.zsh" ]] && source "${IMPERIAL_ROOT}/config/syntax-highlighting.zsh"

# Load fast-syntax-highlighting after OMZ (must be after autosuggestions)
if [[ -f "${ZSH}/custom/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ]]; then
  source "${ZSH}/custom/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
elif [[ -f "${ZSH}/custom/plugins/fast-syntax-highlighting/fast-syntax-highlighting.sh" ]]; then
  source "${ZSH}/custom/plugins/fast-syntax-highlighting/fast-syntax-highlighting.sh"
fi

# Imperial config modules (deterministic order)
for _imperial_module in \
  history \
  tools \
  bindkeys \
  aliases \
  functions \
  imperial-banner; do
  _imperial_file="${IMPERIAL_ROOT}/config/${_imperial_module}.zsh"
  [[ -f "${_imperial_file}" ]] && source "${_imperial_file}"
done
unset _imperial_module _imperial_file

# Powerlevel10k configuration
[[ -f "${HOME}/.p10k.zsh" ]] && source "${HOME}/.p10k.zsh"

# Zoxide (must be near end)
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# The Fuck — ritual of repair
if command -v thefuck &>/dev/null; then
  eval "$(thefuck --alias by_the_throne)"
fi

# Welcome banner (once per session)
imperial_welcome_banner
