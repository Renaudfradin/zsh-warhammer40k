# Imperial Command Terminal — History & Search Configuration

HISTFILE="${HISTFILE:-${HOME}/.zsh_history}"
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# Autosuggestion styling — incense smoke
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=238"
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=64

# Word navigation (Ctrl+arrows only — plain arrows keep default ZSH behavior)
bindkey '^[[1;5C' forward-word    # Ctrl+Right
bindkey '^[[1;5D' backward-word   # Ctrl+Left

# FZF history search (Ctrl+R) — configured in tools.zsh if fzf available
