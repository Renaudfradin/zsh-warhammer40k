#!/usr/bin/env bash
# Imperial Command Terminal — Installation Script
# Cross-platform bootstrap for macOS and Linux

set -euo pipefail

# Colors for installer output
GOLD='\033[38;5;179m'
IVORY='\033[38;5;187m'
RED='\033[38;5;124m'
BRASS='\033[38;5;136m'
RESET='\033[0m'

info()  { echo -e "${GOLD}⚙${RESET} $*"; }
warn()  { echo -e "${BRASS}⚠${RESET} $*"; }
error() { echo -e "${RED}☠${RESET} $*" >&2; }
ritual() { echo -e "${GOLD}═══ $* ═══${RESET}"; }

# Resolve repo root (directory containing this script)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="${SCRIPT_DIR}"
ZSH_CUSTOM="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"

# ── Detect OS & Package Manager ───────────────────────────────────────────────

detect_platform() {
  case "$(uname -s)" in
    Darwin) PLATFORM="macos"; PKG_MGR="brew" ;;
    Linux)
      PLATFORM="linux"
      if command -v apt-get &>/dev/null; then
        PKG_MGR="apt"
      elif command -v dnf &>/dev/null; then
        PKG_MGR="dnf"
      elif command -v pacman &>/dev/null; then
        PKG_MGR="pacman"
      else
        PKG_MGR="unknown"
      fi
      ;;
    *) error "Unsupported platform: $(uname -s)"; exit 1 ;;
  esac
  info "Platform: ${PLATFORM} (${PKG_MGR})"
}

install_package() {
  local pkg="$1"
  if command -v "${pkg}" &>/dev/null || \
     command -v "batcat" &>/dev/null && [[ "${pkg}" == "bat" ]] || \
     command -v "fdfind" &>/dev/null && [[ "${pkg}" == "fd" ]]; then
    return 0
  fi

  info "Installing ${pkg}..."
  case "${PKG_MGR}" in
    brew)
      if ! command -v brew &>/dev/null; then
        warn "Homebrew not found. Install from https://brew.sh then re-run."
        return 1
      fi
      brew install "${pkg}" 2>/dev/null || warn "Could not install ${pkg} via brew"
      ;;
    apt)
      sudo apt-get update -qq
      case "${pkg}" in
        bat) sudo apt-get install -y bat ;;
        fd)  sudo apt-get install -y fd-find ;;
        *)   sudo apt-get install -y "${pkg}" 2>/dev/null || warn "Could not install ${pkg}" ;;
      esac
      ;;
    dnf)
      sudo dnf install -y "${pkg}" 2>/dev/null || warn "Could not install ${pkg}"
      ;;
    pacman)
      if [[ "${pkg}" == "thefuck" ]]; then
        warn "thefuck may require AUR on Arch: yay -S thefuck"
      else
        sudo pacman -S --noconfirm "${pkg}" 2>/dev/null || warn "Could not install ${pkg}"
      fi
      ;;
    *)
      warn "Unknown package manager — install ${pkg} manually"
      ;;
  esac
}

install_cli_tools() {
  ritual "INSTALLING AUSPEX TOOLS"

  local tools=(bat eza fzf zoxide thefuck ripgrep fd tmux)
  if [[ "${PLATFORM}" == "macos" ]]; then
    tools+=(htop)
  fi

  for tool in "${tools[@]}"; do
    install_package "${tool}" || true
  done

  # macOS: btop optional
  if [[ "${PLATFORM}" == "macos" ]] && command -v brew &>/dev/null; then
    brew install btop 2>/dev/null || true
  fi
}

# ── Oh My Zsh ─────────────────────────────────────────────────────────────────

install_oh_my_zsh() {
  if [[ -d "${HOME}/.oh-my-zsh" ]]; then
    info "Oh My Zsh already installed"
    return 0
  fi

  ritual "INSTALLING OH MY ZSH"
  if ! command -v zsh &>/dev/null; then
    error "ZSH is required. Install zsh first."
    exit 1
  fi

  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# ── OMZ Plugins & Theme ───────────────────────────────────────────────────────

clone_if_missing() {
  local url="$1"
  local dest="$2"
  local name
  name="$(basename "${dest}")"

  if [[ -d "${dest}" ]]; then
    info "${name} already installed"
  else
    info "Cloning ${name}..."
    git clone --depth=1 "${url}" "${dest}"
  fi
}

install_plugins() {
  ritual "INSTALLING MACHINE SPIRIT PLUGINS"

  mkdir -p "${ZSH_CUSTOM}/themes" "${ZSH_CUSTOM}/plugins"

  clone_if_missing \
    "https://github.com/romkatv/powerlevel10k.git" \
    "${ZSH_CUSTOM}/themes/powerlevel10k"

  clone_if_missing \
    "https://github.com/zsh-users/zsh-autosuggestions.git" \
    "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"

  clone_if_missing \
    "https://github.com/zdharma-continuum/fast-syntax-highlighting.git" \
    "${ZSH_CUSTOM}/plugins/fast-syntax-highlighting"

  clone_if_missing \
    "https://github.com/zsh-users/zsh-history-substring-search.git" \
    "${ZSH_CUSTOM}/plugins/zsh-history-substring-search"
}

# ── Nerd Font ─────────────────────────────────────────────────────────────────

install_font_hint() {
  ritual "SACRED FONTS"
  echo -e "${IVORY}Install a Nerd Font for proper icon rendering:${RESET}"
  echo ""
  echo "  Recommended: MesloLGS NF (Powerlevel10k official)"
  echo "    https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k"
  echo ""
  echo "  Alternative: JetBrainsMono Nerd Font"
  echo "    https://www.nerdfonts.com/font-downloads"
  echo ""
  if [[ "${PLATFORM}" == "macos" ]] && command -v brew &>/dev/null; then
    echo "  Quick install:"
    echo "    brew tap homebrew/cask-fonts"
    echo "    brew install --cask font-meslo-lg-nerd-font"
    echo ""
  fi
}

# ── Symlinks ──────────────────────────────────────────────────────────────────

link_config() {
  ritual "CONSECRATING CONFIGURATION"

  local timestamp
  timestamp=$(date +%Y%m%d_%H%M%S)

  # Backup existing configs
  for f in .zshrc .p10k.zsh; do
    if [[ -f "${HOME}/${f}" && ! -L "${HOME}/${f}" ]]; then
      cp "${HOME}/${f}" "${HOME}/${f}.pre-imperial.bak"
      warn "Backed up ${HOME}/${f} → ${HOME}/${f}.pre-imperial.bak"
    elif [[ -L "${HOME}/${f}" ]]; then
      local current_target
      current_target="$(readlink "${HOME}/${f}")"
      if [[ "${current_target}" != "${REPO_ROOT}/${f}" ]]; then
        mv "${HOME}/${f}" "${HOME}/${f}.pre-imperial.${timestamp}.bak"
        warn "Moved old symlink ${HOME}/${f}"
      fi
    fi
  done

  # Create symlinks
  ln -sfn "${REPO_ROOT}/.zshrc" "${HOME}/.zshrc"
  ln -sfn "${REPO_ROOT}/.p10k.zsh" "${HOME}/.p10k.zsh"
  info "Linked ~/.zshrc → ${REPO_ROOT}/.zshrc"
  info "Linked ~/.p10k.zsh → ${REPO_ROOT}/.p10k.zsh"

  # Optional: tmux config reference
  if [[ ! -f "${HOME}/.tmux.conf" ]]; then
    cat > "${HOME}/.tmux.conf" <<EOF
# Imperial Command Terminal — Tmux
source-file ${REPO_ROOT}/tmux/imperial.tmux.conf
EOF
    info "Created ~/.tmux.conf with Imperial theme"
  else
    warn "~/.tmux.conf exists — add manually:"
    echo "  source-file ${REPO_ROOT}/tmux/imperial.tmux.conf"
  fi

  # Export repo root for zshrc resolution
  if ! grep -q "ZSH_IMPERIAL_ROOT" "${HOME}/.zshenv" 2>/dev/null; then
    echo "export ZSH_IMPERIAL_ROOT=\"${REPO_ROOT}\"" >> "${HOME}/.zshenv"
    info "Set ZSH_IMPERIAL_ROOT in ~/.zshenv"
  fi
}

# ── Set Default Shell ─────────────────────────────────────────────────────────

set_default_shell() {
  if [[ "${SHELL:-}" != *"zsh"* ]]; then
  warn "Your default shell is not zsh (${SHELL:-unknown})"
    echo "  To set zsh as default: chsh -s \$(which zsh)"
  fi
}

# ── Post-Install ──────────────────────────────────────────────────────────────

post_install() {
  ritual "INSTALLATION COMPLETE"
  echo ""
  echo -e "${GOLD}╔══════════════════════════════════╗${RESET}"
  echo -e "${GOLD}║${IVORY} IMPERIAL COMMAND TERMINAL        ${GOLD}║${RESET}"
  echo -e "${GOLD}║${IVORY} Machine Spirit : ONLINE          ${GOLD}║${RESET}"
  echo -e "${GOLD}║${IVORY} Installation   : COMPLETE        ${GOLD}║${RESET}"
  echo -e "${GOLD}╚══════════════════════════════════╝${RESET}"
  echo ""
  echo "Next steps:"
  echo "  1. Install a Nerd Font (see above)"
  echo "  2. Configure your terminal (see README.md)"
  echo "  3. Restart your terminal or run: exec zsh"
  echo ""
  echo "Useful commands:"
  echo "  machine_spirit    — System diagnostics"
  echo "  imperial_status   — Full cogitator dossier"
  echo "  creed             — Random Imperial quote"
  echo "  banner            — Re-display welcome banner"
  echo "  reload            — Reload configuration"
  echo ""
}

# ── Main ──────────────────────────────────────────────────────────────────────

main() {
  ritual "IMPERIAL COMMAND TERMINAL INSTALLER"
  echo ""

  detect_platform
  install_cli_tools
  install_oh_my_zsh
  install_plugins
  link_config
  install_font_hint
  set_default_shell
  post_install
}

main "$@"
