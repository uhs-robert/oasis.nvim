# Btop Setup

1. Create `~/.config/btop/themes` (if it doesn't exist)
2. Copy your desired theme file into the `themes` directory
3. Set the theme in btop's options menu or configuration file

### Installation

```bash
# Create themes directory
mkdir -p ~/.config/btop/themes

# Copy a theme (example: lagoon)
cp oasis_lagoon.theme ~/.config/btop/themes/

# Or copy all themes
cp *.theme ~/.config/btop/themes/
```

### Usage

**Option 1: Via btop menu**

1. Launch btop
2. Press `Esc` to open the menu
3. Navigate to `Options` → `Color theme`
4. Select your Oasis theme (e.g., `oasis_lagoon`)

**Option 2: Via config file**
Edit `~/.config/btop/btop.conf`:

```conf
color_theme = "oasis_lagoon"
```
