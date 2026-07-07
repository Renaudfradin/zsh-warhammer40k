# Imperial Command Terminal

> *"The Machine Spirit awakens. Praise the Omnissiah."*

A premium ZSH configuration inspired by the **Imperium of Man** — designed to feel like the command console of a Tech-Priest from Mars or an Imperial Battleship.

```
     ⚙⚙⚙  COGITATEUR EN ÉVEIL  ⚙⚙⚙

╔══════════════════════════════════════╗
║   IMPERIAL COMMAND TERMINAL          ║
║   Adeptus Mechanicus · Mars          ║
╠══════════════════════════════════════╣
║ Machine Spirit : ONLINE              ║
║ Access Level   : MAGOS               ║
╚══════════════════════════════════════╝

  ☩ Litanie d'Éveil ☩
  ─────────────────────────────────
  Ô Esprit de la Machine, ouvre tes circuits sacrés.
  Que tes rouages s'animent sous la volonté de l'Omnimessie.
  ...
  ☩  GLOIRE À L'OMNIMESSIE  ☩
  ☩  GLORY TO THE OMNISSIAH  ☩

 ⚙ magos  ⚜ battlecruiser  ☩ ~/sector/mars-forge  ☩ 02 Jul 2026  ⌛ 14:09

 🛡 main ↑1  ⚡ py 3.12  ⬢ 22  🦀 1.78  🧬 ✚2 ~1  ☢ 87%  🛰 prod  🐳 default

╭─⚜ ~/sector/mars-forge/zsh-warhammer40k
╰─⚜
```

---

## Features

| Category | Details |
|----------|---------|
| **Shell** | ZSH + Oh My Zsh + Powerlevel10k |
| **Style** | Adeptus Mechanicus / Imperial Navy / Gothic industrial |
| **Plugins** | Autosuggestions, Fast Syntax Highlighting, FZF |
| **Tools** | bat, eza, fzf, zoxide, thefuck, ripgrep, fd, tmux |
| **Prompt** | Two-line Imperial status rail with git, languages, k8s, docker, cloud |
| **Theme** | Custom color palette, Nerd Font icons, transient prompt |
| **Startup** | Rituel d'éveil — litanies, prières à l'Omnissiah, Credo Imperialis |

### Visual Identity

| Color | Hex | Role |
|-------|-----|------|
| Background | `#0b0b0b` | Void black — cathedral darkness |
| Foreground | `#d8d0b0` | Parchment ivory |
| Gold | `#bfa35f` | Imperial gold — aquila & seals |
| Sacred Gold | `#ffd700` | Throne gold — litanies & prompt |
| Red | `#a61d24` | Blood red — alerts |
| Mechanicus Red | `#9b111e` | Tech-Priest robe crimson |
| Mars Red | `#8b0000` | Martian forge |
| Wax Seal | `#cc2200` | Purity seal red |
| Brass | `#8f6b32` | Cogitator trim |
| Incense | `#c68642` | Ritual amber |
| Cog Glow | `#e8a020` | Amber cogitator glow |
| Plasma Blue | `#66b6ff` | K8s, cloud, info |
| Gray | `#4f4f4f` | Gunmetal ash |

### Git Status Colors

| State | Color |
|-------|-------|
| Clean | Sacred Gold `#ffd700` |
| Modified | Martian Red `#a61d24` |
| Staged | Ivory `#d8d0b0` |
| Conflicts | Dark Red `#6b1010` |

### Rituel de démarrage

À chaque ouverture de terminal, le **rituel d'éveil du cogitateur** s'affiche :

1. **Bannière Adeptus Mechanicus** — statut de l'Esprit de la Machine, niveau d'accès
2. **Litane complète aléatoire** — parmi 8 litanie sacrées (Éveil, Mise à Feu, Réparation, Purification, Bolter, Tech-Prêtre, Cantique Binaire, Grande Litanie)
3. **GLOIRE À L'OMNIMESSIE** — invocation bilingue
4. **Credo Imperialis** — citation aléatoire du lore 40k
5. **Confirmation** — le terminal est consacré et prêt

Commandes pour rejouer le rituel :

```bash
banner      # Rituel complet
eveil       # Idem (alias FR)
omnissiah   # Litane + glorification
litany      # Litane seule
priere      # Litane seule (alias FR)
gloire      # Gloire à l'Omnissiah
creed       # Citation Imperialis
```

Désactiver le rituel : `export IMPERIAL_BANNER=0` dans `config/local.zsh`

---

## Requirements

- **ZSH** 5.8 or newer
- **git** and **curl**
- A [Nerd Font](#fonts) (required for icons)
- macOS or Linux

---

## Quick Install

```bash
git clone https://github.com/yourusername/zsh-warhammer40k.git
cd zsh-warhammer40k
./install.sh
```

Then install a Nerd Font, configure your terminal, and restart:

```bash
exec zsh
```

The installer will:

1. Install CLI tools (bat, eza, fzf, zoxide, thefuck, ripgrep, fd, tmux)
2. Install Oh My Zsh (if missing)
3. Clone Powerlevel10k and ZSH plugins
4. Symlink `~/.zshrc` and `~/.p10k.zsh` to this repo
5. Set up tmux theme reference

---

## Fonts

Icons require a **Nerd Font**. Without one, you will see empty squares or missing glyphs.

### Recommended

| Font | Notes |
|------|-------|
| **MesloLGS NF** | Official Powerlevel10k font — best compatibility |
| **JetBrainsMono Nerd Font** | Excellent readability, full Nerd Font glyphs |

### Install

**macOS (Homebrew):**

```bash
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
```

**Linux:**

Download from [Nerd Fonts](https://www.nerdfonts.com/font-downloads) and install to `~/.local/share/fonts/`, then run `fc-cache -fv`.

**MesloLGS NF direct:**

[Powerlevel10k font guide](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k)

Set the font in your terminal emulator (size 13–14 recommended).

---

## Terminal Configuration

Apply these settings in your terminal for the full grimdark experience.

### Ghostty (Recommended)

Add to `~/.config/ghostty/config`:

```ini
# Imperial Command Terminal
font-family = MesloLGS Nerd Font
font-size = 14
font-feature = calt
font-feature = liga

background = #0b0b0b
foreground = #d8d0b0
cursor-color = #bfa35f
cursor-style = block
selection-background = #2a2a2a
selection-foreground = #d8d0b0

palette = 0=#0b0b0b
palette = 1=#a61d24
palette = 2=#8f6b32
palette = 3=#bfa35f
palette = 4=#66b6ff
palette = 5=#bfa35f
palette = 6=#8f6b32
palette = 7=#d8d0b0
palette = 8=#4f4f4f
palette = 9=#a61d24
palette = 10=#8f6b32
palette = 11=#bfa35f
palette = 12=#66b6ff
palette = 13=#bfa35f
palette = 14=#8f6b32
palette = 15=#d8d0b0
```

### WezTerm

Add to `~/.wezterm.lua`:

```lua
return {
  font = wezterm.font('MesloLGS NF'),
  font_size = 14,
  color_scheme = 'Imperial',
  colors = {
    foreground = '#d8d0b0',
    background = '#0b0b0b',
    cursor_bg = '#bfa35f',
    cursor_fg = '#0b0b0b',
    cursor_border = '#bfa35f',
    selection_fg = '#d8d0b0',
    selection_bg = '#2a2a2a',
    ansi = {
      '#0b0b0b', '#a61d24', '#8f6b32', '#bfa35f',
      '#66b6ff', '#bfa35f', '#8f6b32', '#d8d0b0',
    },
    brights = {
      '#4f4f4f', '#a61d24', '#8f6b32', '#bfa35f',
      '#66b6ff', '#bfa35f', '#8f6b32', '#d8d0b0',
    },
  },
  default_cursor_style = 'BlinkingBlock',
}
```

### Kitty

Add to `~/.config/kitty/kitty.conf`:

```ini
# Imperial Command Terminal
font_family MesloLGS Nerd Font
font_size 14.0
bold_font auto
italic_font auto

foreground #d8d0b0
background #0b0b0b
cursor #bfa35f
cursor_shape block
selection_foreground #d8d0b0
selection_background #2a2a2a

color0  #0b0b0b
color1  #a61d24
color2  #8f6b32
color3  #bfa35f
color4  #66b6ff
color5  #bfa35f
color6  #8f6b32
color7  #d8d0b0
color8  #4f4f4f
color9  #a61d24
color10 #8f6b32
color11 #bfa35f
color12 #66b6ff
color13 #bfa35f
color14 #8f6b32
color15 #d8d0b0
```

---

## Project Structure

```
zsh-warhammer40k/
├── .zshrc                       # Main entry point
├── .p10k.zsh                    # Powerlevel10k Imperial theme
├── install.sh                   # Cross-platform installer
├── config/
│   ├── colors.zsh               # Color palette
│   ├── imperial-banner.zsh      # Banner controls
│   ├── aliases.zsh              # Themed aliases
│   ├── functions.zsh            # Utility functions
│   ├── tools.zsh                # bat, eza, fzf, zoxide, etc.
│   ├── history.zsh              # History & search bindings
│   └── syntax-highlighting.zsh  # Fast-syntax-highlighting colors
├── assets/ascii/
│   ├── terminal-mockup.txt      # ASCII preview
│   ├── terminal-mockup.txt      # ASCII preview
│   ├── motd-quotes.txt          # Imperial quotes (Credo)
│   └── litanies.txt             # Machine Spirit prayers (FR/EN)
└── tmux/
    └── imperial.tmux.conf       # Matching tmux theme
```

---

## Prompt Layout

### Line 1 — Status Rail

| Segment | Icon | Description |
|---------|------|-------------|
| OS | ⚙ | Cog Mechanicum |
| User | ⚙ | Current operator |
| Host | ⚜ | Vessel designation |
| Directory | 📂 | Current sector |
| Date | ☀ | Imperial calendar |
| Time | ⌛ | Local chronometer |
| Load / RAM / Disk | ⚡ 🧠 💾 | Machine vitals (right) |

### Line 2 — Operations Rail

| Segment | Icon | Description |
|---------|------|-------------|
| Git | 🛡 🧬 | Branch, status, changes |
| Python | ⚡ | Active Python version |
| Node | ⬢ | Node.js version |
| Rust | 🦀 | Rust toolchain |
| Battery | ☢ | Power reserves |
| Execution Time | ⌛ | Last command duration |
| Kubernetes | 🛰 | Fleet context |
| Docker | 🐳 | Forge context |
| Cloud | ☁ | AWS / Azure / GCP profile |
| Prompt | ⚜ | Holy Aquila (replaces `$`) |

---

## Commands & Aliases

### Functions

| Command | Description |
|---------|-------------|
| `machine_spirit` | Machine Spirit diagnostics |
| `imperial_status` | Full cogitator dossier |
| `access_level` | Show clearance (INITIATE / MAGOS / PRIMARCH) |
| `creed` | Random Imperial quote (Credo) |
| `litany` / `priere` | Machine Spirit litany (random prayer) |
| `omnissiah` / `gloire` | Litany + Glory to the Omnissiah |
| `servo_skull <url>` | HTTP health probe |
| `rite_of_repair` | Themed `thefuck` wrapper |
| `sector <path>` | Navigate and list directory |
| `exterminatus [git\|docker]` | Guarded destructive purge |
| `banner` / `eveil` | Re-display full awakening ritual |

### Themed Aliases

| Alias | Command | Flavor |
|-------|---------|--------|
| `cogitator` | htop/btop | Machine monitoring |
| `vox` | ping | Vox transmission |
| `auspex` | rg | Scanner sweep |
| `seek` | fd | Deep search |
| `sanctify` | bat | Scripture viewer |
| `reliquary` | eza -la | Sacred archives |
| `warp` | z | Zoxide jump |
| `chronicle` | history | Command chronicle |
| `litany` | imperial_litany | Machine Spirit prayer |
| `by_the_throne` | thefuck | Rite of repair |

### Key Bindings

| Key | Action |
|-----|--------|
| `Ctrl+R` | FZF history search |
| `Ctrl+T` | FZF file finder |
| `Alt+C` | FZF directory jump |

---

## Customization

### Disable Welcome Banner

```bash
export IMPERIAL_BANNER=0
```

Add to `config/local.zsh` (gitignored).

### Disable Ritual Spinner

```bash
export IMPERIAL_RITUAL_SPINNER=0
```

### Change Prompt Character

Edit `.p10k.zsh`:

```zsh
# Options: ⚜ ☩ ⚙ ❯ 🦅
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_VIINS_CONTENT_EXPANSION='⚜'
```

### Local Overrides

Create `config/local.zsh` for machine-specific settings. This file is gitignored.

```bash
# config/local.zsh
export IMPERIAL_BANNER=0
alias myproject='cd ~/projects/myproject'
```

### Access Levels

| User | Level |
|------|-------|
| Regular user | INITIATE |
| sudo / wheel / admin group | MAGOS |
| root | PRIMARCH |

---

## Tmux

The installer creates `~/.tmux.conf` if none exists. To add manually:

```bash
echo "source-file /path/to/zsh-warhammer40k/tmux/imperial.tmux.conf" >> ~/.tmux.conf
```

Start a sanctum session:

```bash
tmux new -s sanctum
```

---

## Troubleshooting

### Icons show as squares or question marks

Install a Nerd Font and set it as your terminal's default font. Restart the terminal after installing.

### Powerlevel10k configuration wizard appears

The wizard should not appear with the shipped config. If it does, choose **No** to keep the Imperial theme, or run:

```bash
p10k configure
```

### Oh My Zsh not found

```bash
./install.sh
```

Or install manually from [ohmyz.sh](https://ohmyz.sh).

### `bat` or `fd` not found on Debian/Ubuntu

The config auto-aliases `batcat` → `bat` and `fdfind` → `fd`. Re-run `./install.sh` or:

```bash
sudo apt install bat fd-find
```

### Slow shell startup

Disable the welcome banner and ritual spinner:

```bash
export IMPERIAL_BANNER=0
export IMPERIAL_RITUAL_SPINNER=0
```

### `(` or other characters appear doubled

Usually caused by one of these:

1. **Terminal auto-pair brackets** (Ghostty, WezTerm, Cursor) + shell input — disable "auto close brackets" in your terminal settings
2. **Duplicate fzf key bindings** — fixed in config (OMZ fzf plugin removed, custom fzf in `tools.zsh` only)
3. **Ritual spinner `\r` overwrite** — fixed in `functions.zsh`

After updating, run `reload`. If the issue persists, check your terminal:

```bash
# Ghostty: disable in ~/.config/ghostty/config
# cursor-option-as-alt = false

# Test in clean zsh (no config)
zsh -f
# Type ( — if no doubling, the issue is in config or terminal
```

### Reload configuration

```bash
reload
# or
source ~/.zshrc
```

---

## Uninstall

```bash
# Restore backup
mv ~/.zshrc.pre-imperial.bak ~/.zshrc 2>/dev/null
mv ~/.p10k.zsh.pre-imperial.bak ~/.p10k.zsh 2>/dev/null

# Or remove symlinks
rm ~/.zshrc ~/.p10k.zsh
```

---

## Credits

Built for devotees of the Omnissiah and servants of the Golden Throne.

- [Oh My Zsh](https://ohmyz.sh)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting)
- Warhammer 40,000 © Games Workshop

*"In the grim darkness of the far future, there is only war."*
