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

### Dark Themes

- **Oasis Abyss** - `themes/oasis_abyss.xpi`
- **Oasis Cactus** - `themes/oasis_cactus.xpi`
- **Oasis Canyon** - `themes/oasis_canyon.xpi`
- **Oasis Desert** - `themes/oasis_desert.xpi`
- **Oasis Dune** - `themes/oasis_dune.xpi`
- **Oasis Lagoon** - `themes/oasis_lagoon.xpi`
- **Oasis Midnight** - `themes/oasis_midnight.xpi`
- **Oasis Mirage** - `themes/oasis_mirage.xpi`
- **Oasis Night** - `themes/oasis_night.xpi`
- **Oasis Rose** - `themes/oasis_rose.xpi`
- **Oasis Sol** - `themes/oasis_sol.xpi`
- **Oasis Starlight** - `themes/oasis_starlight.xpi`
- **Oasis Twilight** - `themes/oasis_twilight.xpi`

### Light Themes

- **Oasis Dawn** - `themes/oasis_dawn.xpi`
- **Oasis Dawnlight** - `themes/oasis_dawnlight.xpi`
- **Oasis Day** - `themes/oasis_day.xpi`
- **Oasis Dusk** - `themes/oasis_dusk.xpi`
- **Oasis Dust** - `themes/oasis_dust.xpi`

## Uninstallation

1. Go to **Tools** → **Add-ons and Themes**
2. Find the Oasis theme in the **Themes** section
3. Click **Remove** or **Disable**

## Development

To regenerate all themes:

```bash
lua extras/thunderbird/generate_thunderbird.lua
```
