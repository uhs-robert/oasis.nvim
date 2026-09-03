# Windows Terminal Setup

Windows Terminal color schemes are stored as JSON objects inside the `"schemes"` array of your `settings.json`.

### Installation

1. Open Windows Terminal, then open the Command Palette (`Ctrl+Shift+P`) and run "Open JSON file" (or go to `Settings -> Open JSON file`).
2. Open the theme you want (example: `themes/dark/oasis_mirage_dark.json`) and copy its whole JSON object.
3. Paste it as a new entry into the top-level `"schemes"` array in `settings.json`:

```json
{
  "schemes": [
    {
      "name": "Oasis Mirage Dark",
      "background": "#111C22",
      "foreground": "#F5F5DC",
      "cursorColor": "#F0E68C",
      "selectionBackground": "#21333B",
      "black": "#111C22",
      "red": "#FF7979",
      "green": "#7FCF78",
      "yellow": "#F0E68C",
      "blue": "#81C0FF",
      "purple": "#C695FF",
      "cyan": "#69C3AA",
      "white": "#F5F5DC",
      "brightBlack": "#587270",
      "brightRed": "#FFA0A0",
      "brightGreen": "#A3E39A",
      "brightYellow": "#F8B471",
      "brightBlue": "#87CEEB",
      "brightPurple": "#D2ADFF",
      "brightCyan": "#8AD3BE",
      "brightWhite": "#FFFFF0"
    }
  ]
}
```

4. Save the file. Windows Terminal picks up changes automatically.

### Usage

The scheme's `name` field is what you reference as `colorScheme` in a profile, or under `"defaults"` to apply it everywhere:

```json
"profiles": {
  "defaults": {
    "colorScheme": "Oasis Mirage Dark"
  }
}
```

Or set it on a single profile instead of `"defaults"` to scope it to just that shell.

### Theme Structure

- **Dark themes**: `themes/dark/oasis_<variant>_dark.json`
- **Light themes**: `themes/light/<intensity>/oasis_<variant>_light_<intensity>.json`
  - Intensity levels: `1` (lightest) to `5` (darkest)
