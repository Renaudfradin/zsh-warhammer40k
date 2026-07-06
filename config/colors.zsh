# Imperial Command Terminal — Color Palette
# Adeptus Mechanicus / Imperium of Man visual identity

# Canonical hex values
export IMPERIAL_BG="#0b0b0b"
export IMPERIAL_FG="#d8d0b0"
export IMPERIAL_GOLD="#bfa35f"
export IMPERIAL_RED="#a61d24"
export IMPERIAL_BRASS="#8f6b32"
export IMPERIAL_PLASMA="#66b6ff"
export IMPERIAL_GRAY="#4f4f4f"
export IMPERIAL_IVORY="#d8d0b0"
export IMPERIAL_DARK_RED="#6b1010"
export IMPERIAL_CHARCOAL="#1a1a1a"
export IMPERIAL_GUNMETAL="#2a2a2a"

# ANSI 256-color approximations for terminal output
export IMPERIAL_BG_256=233
export IMPERIAL_FG_256=187
export IMPERIAL_GOLD_256=179
export IMPERIAL_RED_256=124
export IMPERIAL_BRASS_256=136
export IMPERIAL_PLASMA_256=111
export IMPERIAL_GRAY_256=238

# ZSH prompt color helpers (%F for foreground, %K for background)
export IMPERIAL_PROMPT_GOLD="%F{179}"
export IMPERIAL_PROMPT_BRASS="%F{136}"
export IMPERIAL_PROMPT_IVORY="%F{187}"
export IMPERIAL_PROMPT_RED="%F{124}"
export IMPERIAL_PROMPT_PLASMA="%F{111}"
export IMPERIAL_PROMPT_GRAY="%F{238}"
export IMPERIAL_PROMPT_RESET="%f%k"

# LS_COLORS — grimdark directory listings
export LS_COLORS="\
di=38;5;136:\
ln=38;5;111:\
so=38;5;124:\
pi=38;5;179:\
ex=38;5;179:\
bd=38;5;136:\
cd=38;5;136:\
or=38;5;124:\
mi=38;5;124:\
su=38;5;124:\
sg=38;5;179:\
tw=38;5;136:\
ow=38;5;136:\
st=38;5;179:\
*.tar=38;5;136:\
*.tgz=38;5;136:\
*.zip=38;5;136:\
*.gz=38;5;136:\
*.bz2=38;5;136:\
*.xz=38;5;136:\
*.7z=38;5;136:\
*.jpg=38;5;187:\
*.png=38;5;187:\
*.gif=38;5;187:\
*.mp4=38;5;187:\
*.mov=38;5;187:\
*.sh=38;5;179:\
*.zsh=38;5;179:\
*.py=38;5;111:\
*.rs=38;5;179:\
*.js=38;5;187:\
*.ts=38;5;187:\
*.go=38;5;111:\
*.md=38;5;187:\
*.json=38;5;187:\
*.yaml=38;5;136:\
*.yml=38;5;136:\
"

# EZA_COLORS (if eza is installed)
export EZA_COLORS="\
da=1;38;5;136:\
di=38;5;136:\
ex=38;5;179:\
fi=38;5;187:\
ln=38;5;111:\
or=38;5;124:\
pi=38;5;179:\
so=38;5;124:\
su=38;5;124:\
sg=38;5;179:\
tw=38;5;136:\
ow=38;5;136:\
st=38;5;179:\
"
