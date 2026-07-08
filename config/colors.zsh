# Imperial Command Terminal — Color Palette
# Adeptus Mechanicus / Imperium of Man — Grimdark Gothic Industrial

# ── Theme Mode ────────────────────────────────────────────────────────────────

export IMPERIAL_THEME_MODE="${IMPERIAL_THEME_MODE:-imperial}"
case "${IMPERIAL_THEME_MODE:l}" in
  chaos|warp|ruin|heretic)
    export IMPERIAL_THEME_MODE="chaos"
    ;;
  *)
    export IMPERIAL_THEME_MODE="imperial"
    ;;
esac

# ── Canonical hex values ──────────────────────────────────────────────────────

if [[ "${IMPERIAL_THEME_MODE}" == "chaos" ]]; then
  export IMPERIAL_BG="#160b1f"            # Warp black — velvet void
  export IMPERIAL_FG="#f0d7ff"            # Bone-lilac parchment
  export IMPERIAL_GOLD="#c56bff"          # Warp bloom — corrupted glow
  export IMPERIAL_RED="#ff4d8d"           # Slaanesh rose — danger
  export IMPERIAL_BRASS="#7b2cbf"         # Violet brass — daemonic trim
  export IMPERIAL_PLASMA="#ff7ad9"        # Pink warp flare
  export IMPERIAL_GRAY="#5d4d6b"          # Ashen void
  export IMPERIAL_IVORY="#f0d7ff"         # Twisted scripture
  export IMPERIAL_DARK_RED="#4d1029"     # Deep bruise — corruption
  export IMPERIAL_CHARCOAL="#221027"      # Rift shadow
  export IMPERIAL_GUNMETAL="#2f1a35"      # Heretek hull

  export IMPERIAL_MARS_RED="#8b004f"      # Bleeding warp stain
  export IMPERIAL_MECHANICUS="#b3007a"    # Heretek robe magenta
  export IMPERIAL_WAX_SEAL="#ff2d6f"      # Blasphemous wax
  export IMPERIAL_INCENSE="#ff9f1c"       # Incense gone feral
  export IMPERIAL_COG_GLOW="#ffcc66"      # Corrupted cogitator glow
  export IMPERIAL_SACRED="#ff66cc"        # False holiness
  export IMPERIAL_WARP="#7b2cbf"         # Warp purple
  export IMPERIAL_BLESSING="#3a6b54"      # Unclean but alive
else
  export IMPERIAL_BG="#0b0b0b"              # Void black — cathedral darkness
  export IMPERIAL_FG="#d8d0b0"              # Parchment ivory
  export IMPERIAL_GOLD="#bfa35f"            # Imperial gold — aquila & purity seals
  export IMPERIAL_RED="#a61d24"             # Blood red — Mars & heresy alerts
  export IMPERIAL_BRASS="#8f6b32"           # Aged brass — cogitator trim
  export IMPERIAL_PLASMA="#66b6ff"          # Plasma coil blue
  export IMPERIAL_GRAY="#4f4f4f"            # Gunmetal ash
  export IMPERIAL_IVORY="#d8d0b0"           # Sacred scripture
  export IMPERIAL_DARK_RED="#6b1010"        # Dried blood — conflicts
  export IMPERIAL_CHARCOAL="#1a1a1a"        # Forge shadow
  export IMPERIAL_GUNMETAL="#2a2a2a"        # Battleship hull

  # Mechanicus extended palette
  export IMPERIAL_MARS_RED="#8b0000"        # Martian forge crimson
  export IMPERIAL_MECHANICUS="#9b111e"      # Tech-Priest robe red
  export IMPERIAL_WAX_SEAL="#cc2200"        # Purity seal wax
  export IMPERIAL_INCENSE="#c68642"         # Incense & ritual amber
  export IMPERIAL_COG_GLOW="#e8a020"        # Cogitator amber glow
  export IMPERIAL_SACRED="#ffd700"          # Throne gold — litanies
  export IMPERIAL_WARP="#4a0e4e"            # Heresy purple (accents only)
  export IMPERIAL_BLESSING="#3d5c3a"        # Machine Spirit online green-dark
fi

if [[ "${IMPERIAL_THEME_MODE}" == "chaos" ]]; then
  export IMPERIAL_THEME_LABEL="CHAOS"
  export IMPERIAL_THEME_TITLE="CHAOS COMMAND TERMINAL"
  export IMPERIAL_THEME_SUBTITLE="Heretic Court · Eye of Terror"
  export IMPERIAL_THEME_VESSEL_LABEL="Warp Vessel"
  export IMPERIAL_THEME_STATUS_LABEL="Bound to the Warp"
  export IMPERIAL_THEME_CREED_LABEL="Litany of Ruin"
else
  export IMPERIAL_THEME_LABEL="IMPERIAL"
  export IMPERIAL_THEME_TITLE="IMPERIAL COMMAND TERMINAL"
  export IMPERIAL_THEME_SUBTITLE="Adeptus Mechanicus · Mars"
  export IMPERIAL_THEME_VESSEL_LABEL="Forge Vessel"
  export IMPERIAL_THEME_STATUS_LABEL="Machine Spirit"
  export IMPERIAL_THEME_CREED_LABEL="Credo Imperialis"
fi

# ── ANSI 256-color palette ────────────────────────────────────────────────────

export IMPERIAL_BG_256=232
export IMPERIAL_FG_256=187
export IMPERIAL_GOLD_256=178
export IMPERIAL_RED_256=160
export IMPERIAL_DARK_RED_256=52
export IMPERIAL_BRASS_256=130
export IMPERIAL_PLASMA_256=111
export IMPERIAL_GRAY_256=238
export IMPERIAL_MARS_256=124
export IMPERIAL_MECHANICUS_256=167
export IMPERIAL_INCENSE_256=172
export IMPERIAL_COG_GLOW_256=214
export IMPERIAL_SACRED_256=220
export IMPERIAL_WAX_256=196

# ── ZSH prompt color helpers ──────────────────────────────────────────────────

export IMPERIAL_PROMPT_GOLD="%F{178}"
export IMPERIAL_PROMPT_SACRED="%F{220}"
export IMPERIAL_PROMPT_BRASS="%F{130}"
export IMPERIAL_PROMPT_IVORY="%F{187}"
export IMPERIAL_PROMPT_RED="%F{160}"
export IMPERIAL_PROMPT_MARS="%F{124}"
export IMPERIAL_PROMPT_MECHANICUS="%F{167}"
export IMPERIAL_PROMPT_PLASMA="%F{111}"
export IMPERIAL_PROMPT_GRAY="%F{238}"
export IMPERIAL_PROMPT_INCENSE="%F{172}"
export IMPERIAL_PROMPT_COG="%F{214}"
export IMPERIAL_PROMPT_WAX="%F{196}"
export IMPERIAL_PROMPT_BG_MARS="%K{52}"
export IMPERIAL_PROMPT_BG_FORGE="%K{233}"
export IMPERIAL_PROMPT_RESET="%f%k"

# Terminal default colors (for apps that read these)
export IMPERIAL_TERM_BG="#0b0b0b"
export IMPERIAL_TERM_FG="#d8d0b0"

# ── LS_COLORS — grimdark reliquary listings ───────────────────────────────────

if [[ "${IMPERIAL_THEME_MODE}" == "chaos" ]]; then
  export LS_COLORS="\
di=38;5;171:\
ln=38;5;213:\
so=38;5;197:\
pi=38;5;201:\
ex=38;5;227:\
bd=38;5;161:\
cd=38;5;171:\
or=38;5;196:\
mi=38;5;197:\
su=38;5;197:\
sg=38;5;201:\
tw=38;5;171:\
ow=38;5;171:\
st=38;5;201:\
*.tar=38;5;171:\
*.tgz=38;5;171:\
*.zip=38;5;171:\
*.gz=38;5;171:\
*.bz2=38;5;171:\
*.xz=38;5;171:\
*.7z=38;5;171:\
*.jpg=38;5;225:\
*.png=38;5;225:\
*.gif=38;5;225:\
*.mp4=38;5;225:\
*.mov=38;5;225:\
*.sh=38;5;201:\
*.zsh=38;5;201:\
*.py=38;5;213:\
*.rs=38;5;201:\
*.js=38;5;225:\
*.ts=38;5;225:\
*.go=38;5;213:\
*.md=38;5;225:\
*.json=38;5;225:\
*.yaml=38;5;213:\
*.yml=38;5;213:\
*.toml=38;5;213:\
*.lock=38;5;238:\
"
else
  export LS_COLORS="\
di=38;5;130:\
ln=38;5;111:\
so=38;5;160:\
pi=38;5;178:\
ex=38;5;220:\
bd=38;5;124:\
cd=38;5;130:\
or=38;5;196:\
mi=38;5;160:\
su=38;5;196:\
sg=38;5;178:\
tw=38;5;130:\
ow=38;5;167:\
st=38;5;178:\
*.tar=38;5;130:\
*.tgz=38;5;130:\
*.zip=38;5;130:\
*.gz=38;5;130:\
*.bz2=38;5;130:\
*.xz=38;5;130:\
*.7z=38;5;130:\
*.jpg=38;5;187:\
*.png=38;5;187:\
*.gif=38;5;187:\
*.mp4=38;5;187:\
*.mov=38;5;187:\
*.sh=38;5;220:\
*.zsh=38;5;220:\
*.py=38;5;111:\
*.rs=38;5;178:\
*.js=38;5;187:\
*.ts=38;5;187:\
*.go=38;5;111:\
*.md=38;5;187:\
*.json=38;5;187:\
*.yaml=38;5;172:\
*.yml=38;5;172:\
*.toml=38;5;172:\
*.lock=38;5;238:\
"
fi

# ── EZA_COLORS ────────────────────────────────────────────────────────────────

if [[ "${IMPERIAL_THEME_MODE}" == "chaos" ]]; then
  export EZA_COLORS="\
da=1;38;5;161:\
di=38;5;171:\
ex=38;5;227:\
fi=38;5;225:\
ln=38;5;213:\
or=38;5;196:\
pi=38;5;201:\
so=38;5;197:\
su=38;5;197:\
sg=38;5;201:\
tw=38;5;171:\
ow=38;5;171:\
st=38;5;201:\
"
else
  export EZA_COLORS="\
da=1;38;5;124:\
di=38;5;130:\
ex=38;5;220:\
fi=38;5;187:\
ln=38;5;111:\
or=38;5;196:\
pi=38;5;178:\
so=38;5;160:\
su=38;5;196:\
sg=38;5;178:\
tw=38;5;130:\
ow=38;5;167:\
st=38;5;178:\
"
fi
