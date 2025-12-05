# Thunderbird Themes

Oasis color themes for Mozilla Thunderbird, packaged as WebExtension themes.

## Installation

1. Download your preferred `.xpi` theme file from the `themes/` directory
2. Open Thunderbird
3. Go to **Tools** → **Add-ons and Themes** (or press `Ctrl+Shift+A`)
4. Click the gear icon ⚙️ and select **Install Add-on From File...**
5. Navigate to and select the downloaded `.xpi` file
6. Click **Add** to install the theme
7. The theme will be applied automatically

## Available Themes

- Dark variants live in `themes/dark/` as `oasis_<palette>_dark.xpi`.
- Light variants are grouped under `themes/light/<1-5>/` as `oasis_<palette>_light_<intensity>.xpi`.
- Palettes: abyss, cactus, canyon, desert, dune, lagoon, midnight, mirage, night, rose, sol, starlight, twilight

## Uninstallation

1. Go to **Tools** → **Add-ons and Themes**
2. Find the Oasis theme in the **Themes** section
3. Click **Remove** or **Disable**

## Development

To regenerate all themes:

```bash
lua extras/thunderbird/generate_thunderbird.lua
```
