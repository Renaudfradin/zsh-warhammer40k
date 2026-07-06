# Imperial Command Terminal — Key Bindings
# Fix duplicate character input (e.g. "(" becoming "((")

# Ensure punctuation keys use plain self-insert (no auto-pair widgets)
for _imperial_key in '(' ')' '[' ']' '{' '}' '"' "'"; do
  bindkey -M emacs "${_imperial_key}" self-insert
  bindkey -M viins "${_imperial_key}" self-insert
done
unset _imperial_key

# Prevent git commit message completion from inserting extra characters
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:git-commit:*' verbose yes
