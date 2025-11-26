# Konsole Setup

1. Create `~/.local/share/konsole/` if it doesn't exist
2. Copy theme files (`.colorscheme`) into `~/.local/share/konsole/`
3. Apply the theme in Konsole:
   - Go to **Settings** → **Manage Profiles** → then click **New**
   - Check **Default Profile**
   - Open the **Appearance** tab and select your theme.
   - Click **Apply**, then **OK**.

### Example

```bash
# Copy theme files
mkdir -p ~/.local/share/konsole
cp extras/konsole/*.colorscheme ~/.local/share/konsole/

# Themes will appear in Konsole settings as:
# - Oasis Lagoon
# - Oasis Desert
# - etc.
```
