# Windows Terminal Setup

1. Open Windows Terminal's `settings.json` (Settings > Open JSON file).
2. Copy the contents of your chosen theme file into the `"schemes"` array.
3. Set `"colorScheme"` in your profile to the scheme's `"name"` value.

### Example

```json
{
  "schemes": [
    {
      "name": "Oasis Lagoon Dark",
      "background": "#101825",
      "foreground": "#F5F5DC",
      "selectionBackground": "#22385C",
      "cursorColor": "#F0E68C",
      "black": "#101825",
      "red": "#FF7979",
      "green": "#7FCF78",
      "yellow": "#F0E68C",
      "blue": "#81C0FF",
      "purple": "#C695FF",
      "cyan": "#69C3AA",
      "white": "#F5F5DC",
      "brightBlack": "#3B6A87",
      "brightRed": "#FFA0A0",
      "brightGreen": "#A3E39A",
      "brightYellow": "#F8B471",
      "brightBlue": "#87CEEB",
      "brightPurple": "#D2ADFF",
      "brightCyan": "#8AD3BE",
      "brightWhite": "#FFFFF0"
    }
  ],
  "profiles": {
    "defaults": {
      "colorScheme": "Oasis Lagoon Dark"
    }
  }
}
```
