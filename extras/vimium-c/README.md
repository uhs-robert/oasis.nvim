# Vimium-C Setup

Generate custom Vimium-C CSS themes using Oasis color palettes (or whatever theme you want).

> [!NOTE]
> A generator is necessary because there are too many light/dark combinations to account for all of them ahead of time.

## Requirements

- **Ruby** (pre-installed on macOS and most Linux distributions)
  - Check: `ruby --version`
  - Install if needed: [rubyinstaller.org](https://rubyinstaller.org/) (Windows) or `brew install ruby` (macOS) or `sudo apt/dnf/pacman install ruby` (Linux)

## Usage

### Interactive Mode (Recommended)

```bash
ruby generate_theme.rb
```

You'll be prompted to select:

1. A day theme (light themes shown first)
2. A night theme (dark themes shown first)

> [!TIP]
> Each selection includes a final option to "Use a dark/light theme instead" to bypass the day/night recommendations.
> (e.g., use dark themes for both day and night or vice-versa).

### CLI Mode

```bash
ruby generate_theme.rb --day oasis_day --night oasis_lagoon
```

**Options:**

- `-d, --day THEME` - Day theme
- `-n, --night THEME` - Night theme
- `-l, --list` - List all available themes
- `-h, --help` - Show help

## Output

Generated CSS files are saved to `output/vimiumc-{night}-{day}.css`

Example: `vimiumc-lagoon-day.css`

## Importing into Vimium-C

1. Generate your theme using the steps above
2. Copy the entire CSS content from the generated file
3. Open Vimium-C settings in your browser:
   - **Chrome/Edge**: `chrome://extensions/` → Vimium C → Options
   - **Firefox**: `about:addons` → Vimium C → Preferences
4. Paste the CSS into the `Custom CSS for Vimium C UI` section
5. Save settings

> [!TIP]
> The extension will automatically parse and apply all sections (HUD, Vomnibar, Find Mode).

## Customizing the CSS Template

Feel free to [edit the template here](./vimium-c.css.erb), it's just CSS.

### Tips and Tricks

1. Use the [Vimium-C Wiki](https://github.com/gdh1995/vimium-c/wiki/Style-the-UI-of-Vimium-C-using-custom-CSS) to learn how CSS is applied in sections
2. You can view the html and elements of `vimium-c` by running commands from the settings page of the extension and using your browser's inspect window
3. Have fun!

## Adding New/My Own Themes

Yes, you can extend this script to add new themes.

You can even take it and use it yourself for your plugin (give me a shout out if you do, please and thank you).

1. Add a new `.json` theme file to [mappings](./mappings/) following the other files as a template (e.g., [oasis_lagoon](./mappings/oasis_lagoon.json))
2. Update the [index.json](./mappings/index.json) to include your new theme file, categorize it as light or dark
3. Run the generator and use your new theme!
