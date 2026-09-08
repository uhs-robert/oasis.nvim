# Thunderbird Themes

Oasis color themes for Mozilla Thunderbird, packaged as WebExtension themes.

## Installation

`.xpi` files are not committed to this repository. Download `oasis-thunderbird-themes.zip` from the latest GitHub release assets, or you can build them yourself:

```bash
lua extras/thunderbird/generate_thunderbird.lua
```

1. Download and extract `oasis-thunderbird-themes.zip` (or use `themes/` after building locally)
2. Open Thunderbird
3. Go to **Tools** → **Add-ons and Themes** (or press `Ctrl+Shift+A`)
4. Click the gear icon ⚙️ and select **Install Add-on From File...**
5. Navigate to and select your preferred `.xpi` file
6. Click **Add** to install the theme
7. The theme will be applied automatically

## Available Themes

- The release zip and a local build share the same layout, rooted at `themes/`.
- Dark variants live in `themes/dark/` as `oasis_<palette>_dark.xpi`.
- Light variants are grouped under `themes/light/<1-5>/` as `oasis_<palette>_light_<intensity>.xpi`.
- Palettes: abyss, cactus, canyon, desert, dune, lagoon, luna, midnight, mirage, moonlight, night, rose, scorpion, sol, starlight, twilight
- Per-theme sources (`manifest.json`, `styles.css`) live in `src/<subdir>/oasis_<variant>/` and are tracked for review; the built `.xpi` files are not.

## Uninstallation

1. Go to **Tools** → **Add-ons and Themes**
2. Find the Oasis theme in the **Themes** section
3. Click **Remove** or **Disable**
