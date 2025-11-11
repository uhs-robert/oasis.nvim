# Vimium-C Setup

[Vimium C](https://github.com/gdh1995/vimium-c) is a browser extension that provides keyboard shortcuts for navigation and control, similar to Vim.

You can find the extension on [Firefox Add-Ons](https://addons.mozilla.org/en-US/firefox/addon/vimium-c/) or the [Chrome Web Store](https://chrome.google.com/webstore/detail/vimium-c-all-by-keyboard/hfjbhrkmgjlhflpefkoekicnfiajkfjh).

This setup allows you to generate custom CSS themes for Vimium C using Oasis color palettes.

> [!NOTE]
> A generator is necessary because there are just too many light/dark combinations to account for all of them ahead of time.
>
> If you're interested in creating your own custom vimium-c theme then you may use my [vimium-c theme generator](https://github.com/uhs-robert/vimium-c-theme-generator) instead

## Requirements

- **Lua** (tested with Lua 5.4) you should already have this if you're using NeoVim

## Usage

Navigate to this directory (`extras/vimium-c`) before running the script.

### Interactive Mode (Recommended)

```bash
lua generate_vimiumc.lua
```

You'll be prompted to select:

1. A day theme (light themes shown first)
2. A night theme (dark themes shown first)

> [!TIP]
> Each selection includes a final option to "Use a dark/light theme instead" to bypass the day/night recommendations.

### CLI Mode

```bash
lua generate_vimiumc.lua --day day --night lagoon
```

**Options:**

- `-d, --day THEME` - Day theme (e.g., `day`)
- `-n, --night THEME` - Night theme (e.g., `lagoon`)
- `-l, --list` - List all available themes
- `-h, --help` - Show help

## Output

Generated CSS files are saved to `output/vimiumc-{night}-{day}.css`

Example: `vimiumc-lagoon-day.css`

## Importing into Vimium-C

1. Generate your theme using the steps above
2. Copy the entire CSS content from the generated file
3. Open Vimium-C settings in your browser:
   - **Firefox**: `about:addons` → Vimium C → Preferences
   - **Chrome/Edge**: `chrome://extensions/` → Vimium C → Options
4. Paste the CSS into the `Custom CSS for Vimium C UI` section
5. Save settings

> [!TIP]
> The extension will automatically parse and apply all sections

## Customizing the CSS Template

The generator uses [vimium-c.css.erb](./vimium-c.css.erb) as a template. You can edit this file to customize the final CSS output.

The script replaces placeholders like `{{day_bg_core}}` and `{{night_primary}}` with the corresponding hex codes from the selected Oasis palettes.

### Tips and Tricks

1. Use the [Vimium-C Wiki](https://github.com/gdh1995/vimium-c/wiki/Style-the-UI-of-Vimium-C-using-custom-CSS) to learn how CSS is applied in sections
2. You may view the html and elements of `vimium-c` by running commands from the settings page of the extension and using your browser's inspect window

## Adding New Themes

The generator automatically discovers all color palettes available in the main Oasis plugin directory: `lua/oasis/color_palettes/`.

To add a new theme, simply create a new palette file in that directory.

Follow the structure of the existing palette files (e.g., `lua/oasis/color_palettes/oasis_lagoon.lua`).
