# Developer Tools

This directory contains developer-only scripts and tools for maintaining the Oasis theme.

## Theme Generator

The `generate_themes.lua` script automatically generates Kitty and Ghostty terminal themes by reading color definitions from the Lua palette files in `lua/oasis/color_palettes/`.

### Usage

```bash
# From project root:

# Generate all themes (Kitty + Ghostty)
lua .dev/generate_themes.lua

# Generate only Kitty themes
lua .dev/generate_themes.lua kitty

# Generate only Ghostty themes
lua .dev/generate_themes.lua ghostty

# Show help
lua .dev/generate_themes.lua --help
```

## When to Regenerate

Run the generator when:

- You modify colors in `lua/oasis/palette.lua` (terminal colors, visual colors, etc.)
- You update any palette file in `lua/oasis/color_palettes/`
- You add a new palette variant
- Terminal themes are out of sync with the Neovim colorscheme

## How It Works

The generator:

1. Discovers all palette files in `lua/oasis/color_palettes/oasis_*.lua`
2. Loads each palette using Lua's `require()` function
3. Extracts colors:
   - **ANSI colors (0-15)**: From `palette.terminal` (dark) or `palette.light_terminal` (light)
   - **Core colors**: `palette.bg.core` and `palette.fg.core`
   - **Selection**: Derived from `palette.bg.surface` or visual colors
   - **Cursor**: Uses `terminal.color3`
   - **Borders**: Uses `terminal.color1` (active) and `terminal.color8` (inactive)
   - **Tabs**: Derived from cursor color and core colors
4. Generates config files using string templates
5. Writes files to `extras/kitty/` and `extras/ghostty/` directories

## Example Output

```
=== Oasis Terminal Theme Generator ===

Found 18 palette(s)

✓ Generated Kitty: extras/kitty/oasis_abyss.conf
✓ Generated Ghostty: extras/ghostty/oasis_abyss
✓ Generated Kitty: extras/kitty/oasis_lagoon.conf
✓ Generated Ghostty: extras/ghostty/oasis_lagoon
...

=== Summary ===
Success: 36
Errors: 0
```

## Comparison with Vimium-C Generator

Unlike the Vimium-C generator (Ruby-based with JSON mappings), the Kitty/Ghostty generator:

- Uses pure Lua (no dependencies)
- Reads palettes directly from source files (no JSON duplication)
- Generates single-theme configs (not day/night combinations)
- Fully automated discovery of palette variants

## Troubleshooting

### "Failed to load palette" error

- Ensure you're running the script from the project root directory
- Check that the palette file exists in `lua/oasis/color_palettes/`
- Verify the palette file returns a valid table

### Colors don't match Neovim theme

- Regenerate themes after any palette changes
- Check that `terminal` or `light_terminal` colors in `palette.lua` are correct
- Verify `bg.core` and `fg.core` values in the specific palette file
