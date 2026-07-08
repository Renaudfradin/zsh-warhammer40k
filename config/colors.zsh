# Imperial Command Terminal — Color Loader
# Keeps the public entry point stable while splitting palette data and tool integrations.

_imperial_colors_dir="${${(%):-%N}:A:h}"

[[ -f "${_imperial_colors_dir}/colors-theme.zsh" ]] && source "${_imperial_colors_dir}/colors-theme.zsh"
[[ -f "${_imperial_colors_dir}/colors-integrations.zsh" ]] && source "${_imperial_colors_dir}/colors-integrations.zsh"

unset _imperial_colors_dir
