# Thunderbird Themes

Oasis color themes for Mozilla Thunderbird, packaged as WebExtension themes.

## Installation

`.xpi` files are not committed to this repository. Get one from the GitHub release assets, or build it yourself:

```bash
just extra thunderbird
```

1. Download your preferred `.xpi` theme file from the release assets (or `themes/` after building locally)
2. Open Thunderbird
3. Go to **Tools** → **Add-ons and Themes** (or press `Ctrl+Shift+A`)
4. Click the gear icon ⚙️ and select **Install Add-on From File...**
5. Navigate to and select the downloaded `.xpi` file
6. Click **Add** to install the theme
7. The theme will be applied automatically

## Available Themes

- Dark variants live in `themes/dark/` as `oasis_<palette>_dark.xpi`.
- Light variants are grouped under `themes/light/<1-5>/` as `oasis_<palette>_light_<intensity>.xpi`.
- Palettes: abyss, cactus, canyon, desert, dune, lagoon, luna, midnight, mirage, moonlight, night, rose, scorpion, sol, starlight, twilight
- Per-theme sources (`manifest.json`, `styles.css`) live in `src/<subdir>/oasis_<variant>/` and are tracked for review; the built `.xpi` files are not.

## Uninstallation

1. Go to **Tools** → **Add-ons and Themes**
2. Find the Oasis theme in the **Themes** section
3. Click **Remove** or **Disable**

## Development

To regenerate all themes:

```bash
lua extras/thunderbird/generate_thunderbird.lua
```
