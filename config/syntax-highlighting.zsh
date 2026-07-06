# Imperial Command Terminal — Fast Syntax Highlighting
# Adeptus Mechanicus cogitator syntax — gold, brass, Martian red

typeset -gA FAST_HIGHLIGHT_STYLES

  # Commands — sacred gold
  FAST_HIGHLIGHT_STYLES[default]='fg=178'
  FAST_HIGHLIGHT_STYLES[command]='fg=220,bold'
  FAST_HIGHLIGHT_STYLES[builtin]='fg=178,bold'
  FAST_HIGHLIGHT_STYLES[function]='fg=178'
  FAST_HIGHLIGHT_STYLES[alias]='fg=214'
  FAST_HIGHLIGHT_STYLES[suffix-alias]='fg=214'
  FAST_HIGHLIGHT_STYLES[precommand]='fg=178,underline'

  # Paths — aged brass
  FAST_HIGHLIGHT_STYLES[path]='fg=130,underline'
  FAST_HIGHLIGHT_STYLES[path_prefix]='fg=130,underline'
  FAST_HIGHLIGHT_STYLES[path_approx]='fg=130,underline'
  FAST_HIGHLIGHT_STYLES[globbing]='fg=172'

  # Strings — parchment ivory
  FAST_HIGHLIGHT_STYLES[single-quoted-argument]='fg=187'
  FAST_HIGHLIGHT_STYLES[double-quoted-argument]='fg=187'
  FAST_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=187'

  # Operators — plasma coil blue
  FAST_HIGHLIGHT_STYLES[operator]='fg=111'
  FAST_HIGHLIGHT_STYLES[redirection]='fg=111'
  FAST_HIGHLIGHT_STYLES[command-substitution]='fg=111'
  FAST_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=111'
  FAST_HIGHLIGHT_STYLES[process-substitution]='fg=111'
  FAST_HIGHLIGHT_STYLES[arithmetic-expansion]='fg=111'

  # Errors — Martian blood red
  FAST_HIGHLIGHT_STYLES[unknown-token]='fg=196,bold'
  FAST_HIGHLIGHT_STYLES[reserved-word]='fg=160,bold'

  # Comments — incense smoke
  FAST_HIGHLIGHT_STYLES[comment]='fg=238,italic'

  # Sudo — heresy warning
  FAST_HIGHLIGHT_STYLES[sudo]='fg=220,bg=52,bold'

  # Options and flags — Mechanicus red accent
  FAST_HIGHLIGHT_STYLES[single-hyphen-option]='fg=167'
  FAST_HIGHLIGHT_STYLES[double-hyphen-option]='fg=167'

  # Variables — plasma glow
  FAST_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=111'
  FAST_HIGHLIGHT_STYLES[variable]='fg=111'

  # Brackets — cog tiers
  FAST_HIGHLIGHT_STYLES[bracket-level-1]='fg=220'
  FAST_HIGHLIGHT_STYLES[bracket-level-2]='fg=130'
  FAST_HIGHLIGHT_STYLES[bracket-level-3]='fg=167'

  # Cursor
  FAST_HIGHLIGHT_STYLES[cursor-matchingbracket]='standout'
