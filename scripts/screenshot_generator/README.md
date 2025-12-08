# Screenshot Generator

Automated screenshot generation for Oasis themes using Lua, Kitty, and hyprshot.

This tool captures dashboard and code screenshots for all theme variants. It is a modular Lua application wrapped in shell script to ensure cleanup.

## Usage

Run the generator from the project root:

```lua
lua ./scripts/screenshot_generator/generate_screenshots.lua
```

> [!WARNING]
> This script needs to kill your tmux-server in order to reload Oasis flavor.
>
> You have been warned. Save your work before running this script.

## Requirements

- **Dependencies**: `lua`, `hyprshot`, `kitty`, `tmux`.
- **Window Manager**: Hyprland must be running for `hyprshot`.
- **Kitty Config**: Remote control must be enabled in `~/.config/kitty/kitty.conf`:
  `allow_remote_control yes`
- **tmux Config**: A config must exist at `~/.tmux.conf` and contain a flavor setting, e.g., `set -g @oasis_flavor "lagoon"`.

## How It Works

The script iterates through all dynamically discovered theme variants. For each one, it:

1. Kills any running tmux server.
2. Updates `~/.tmux.conf` with the variant flavor.
3. Launches Kitty, opens Neovim, and applies the colorscheme.
4. Captures "dashboard" and "code" screenshots with `hyprshot`.
5. Closes Kitty and cleans up.

Your original tmux flavor is restored automatically upon completion or exit.

## Configuration

All configuration is centralized in `scripts/screenshot_generator/config.lua`. Here you can adjust paths, output directories, and theme-specific settings like `LIGHT_INTENSITY`.

```lua
-- scripts/screenshot_generator/config.lua
local Config = {
 LIGHT_INTENSITY = 3,
 SHOWCASE_LIGHT_INTENSITY_THEMES = {
  lagoon = { 1, 2, 3, 4, 5 },
 },
    -- Other settings include paths and directories...
}
```

Screenshots are saved to `assets/screenshots/`.

## Development & Debugging

### Testing a Single Variant

To test with a specific variant, edit `scripts/screenshot_generator/config.lua`:

```lua
-- Comment out the automatic generation
-- Config.VARIANTS = Config.generate_variants()
-- Add your test list
Config.VARIANTS = {"sol_dark", "sol_light_3"}
```

### Debugging

To prevent the Kitty window from closing after a run:

1. Comment out the `self:close_terminal()` call in `scripts/screenshot_generator/lib/screenshot_workflow.lua`.
2. Run the script with a single test variant.
3. The Kitty window will remain open for inspection.
4. Remember to manually kill the leftover kitty process: `pkill -f "kitty.*oasis-screenshot"`.

### Adjusting Timings

If screenshots are captured too early, increase `System.sleep()` values in the `lib/` modules, particularly `kitty_controller.lua` and `screenshot_workflow.lua`.

### Troubleshooting

- **Kitty remote control fails**: Verify `allow_remote_control yes` in `kitty.conf` and check for sockets in `/tmp/kitty-oasis-screenshot-*`.
- **hyprshot fails**: Ensure Hyprland is running and test `hyprshot` manually.
- **tmux fails**: Check that `~/.tmux.conf` exists and contains the `@oasis_flavor` line.

## Architecture

The script's logic is contained in a few key files:

- `run_with_cleanup.sh`: The entry point, acts as a wrapper for exit handling.
- `generate_screenshots.lua`: The main Lua orchestrator.
- `config.lua`: Centralized configuration.
- `lib/*.lua`: Modular helper libraries for controlling Kitty, tmux, etc.
