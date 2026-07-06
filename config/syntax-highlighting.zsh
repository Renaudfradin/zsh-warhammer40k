# Imperial Command Terminal — Fast Syntax Highlighting
# Styles must be set before fast-syntax-highlighting plugin is sourced

typeset -gA FAST_HIGHLIGHT_STYLES

  # Commands — gold
  FAST_HIGHLIGHT_STYLES[default]='fg=179'
  FAST_HIGHLIGHT_STYLES[command]='fg=179,bold'
  FAST_HIGHLIGHT_STYLES[builtin]='fg=179'
  FAST_HIGHLIGHT_STYLES[function]='fg=179'
  FAST_HIGHLIGHT_STYLES[alias]='fg=179'
  FAST_HIGHLIGHT_STYLES[suffix-alias]='fg=179'
  FAST_HIGHLIGHT_STYLES[precommand]='fg=179,underline'

  # Paths — brass
  FAST_HIGHLIGHT_STYLES[path]='fg=136,underline'
  FAST_HIGHLIGHT_STYLES[path_prefix]='fg=136,underline'
  FAST_HIGHLIGHT_STYLES[path_approx]='fg=136,underline'
  FAST_HIGHLIGHT_STYLES[globbing]='fg=136'

  # Strings — ivory
  FAST_HIGHLIGHT_STYLES[single-quoted-argument]='fg=187'
  FAST_HIGHLIGHT_STYLES[double-quoted-argument]='fg=187'
  FAST_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=187'

  # Operators — plasma blue
  FAST_HIGHLIGHT_STYLES[operator]='fg=111'
  FAST_HIGHLIGHT_STYLES[redirection]='fg=111'
  FAST_HIGHLIGHT_STYLES[command-substitution]='fg=111'
  FAST_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=111'
  FAST_HIGHLIGHT_STYLES[process-substitution]='fg=111'
  FAST_HIGHLIGHT_STYLES[arithmetic-expansion]='fg=111'

  # Errors — red
  FAST_HIGHLIGHT_STYLES[unknown-token]='fg=124,bold'
  FAST_HIGHLIGHT_STYLES[reserved-word]='fg=124'

  # Comments — gray
  FAST_HIGHLIGHT_STYLES[comment]='fg=238'

  # Sudo — dark red background
  FAST_HIGHLIGHT_STYLES[precommand]='fg=179,underline'
  FAST_HIGHLIGHT_STYLES[sudo]='fg=124,bg=52'

  # Options and flags
  FAST_HIGHLIGHT_STYLES[single-hyphen-option]='fg=136'
  FAST_HIGHLIGHT_STYLES[double-hyphen-option]='fg=136'

  # Variables
  FAST_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=111'
  FAST_HIGHLIGHT_STYLES[variable]='fg=111'

  # Brackets
  FAST_HIGHLIGHT_STYLES[bracket-level-1]='fg=179'
  FAST_HIGHLIGHT_STYLES[bracket-level-2]='fg=136'
  FAST_HIGHLIGHT_STYLES[bracket-level-3]='fg=111'

  # Cursor
  FAST_HIGHLIGHT_STYLES[cursor-matchingbracket]='standout'
