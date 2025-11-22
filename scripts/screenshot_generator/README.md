# Screenshot Generator

Automated screenshot generation for all 18 Oasis theme variants using Kitty terminal and hyprshot.

## Overview

This tool automates the process of capturing high-quality screenshots for all Oasis theme variants:

- **Dashboard screenshots**: Neovim with snacks.nvim dashboard
- **Code screenshots**: Example JavaScript file with syntax highlighting

The generator uses real terminal rendering in Kitty for authentic, high-quality screenshots that match what users actually see.

## Requirements

### Dependencies

1. **hyprshot** - Hyprland screenshot tool

   ```bash
   # Install from https://github.com/Gustash/Hyprshot
   # Arch Linux
   yay -S hyprshot

   # Or build from source
   ```

2. **kitty** - GPU-based terminal emulator with remote control support

   ```bash
   # Most distributions
   sudo pacman -S kitty  # Arch
   sudo apt install kitty  # Ubuntu/Debian
   ```

3. **tmux** - Terminal multiplexer

   ```bash
   # Most distributions
   sudo pacman -S tmux  # Arch
   sudo apt install tmux  # Ubuntu/Debian
   ```

### Configuration

1. **Kitty remote control** must be enabled in `~/.config/kitty/kitty.conf`:

   ```conf
   allow_remote_control yes
   # or for socket-only mode:
   # allow_remote_control socket-only
   ```

2. **tmux config** at `~/dotfiles/tmux/.tmux.conf` (update script path if different):
   - Config should contain a line like: `set -g @oasis_flavor "lagoon"`
   - **tmux-oasis theme** must be installed and configured

3. **Hyprland** window manager running (required for hyprshot)

## Usage

Run the generator from the project root:

```bash
./scripts/screenshot_generator/generate_screenshots.rb
```

### What It Does

1. **Backs up** your current tmux config
2. **For each variant**:
   - Kills any existing tmux server
   - Updates tmux config to use that variant
   - Launches Kitty terminal with tmux
   - Opens Neovim with the variant colorscheme
   - Captures dashboard screenshot using hyprshot
   - Opens example code file (navigates to line 19)
   - Captures code screenshot using hyprshot
   - Closes Kitty terminal
   - Saves screenshots to `assets/screenshots/`
3. **Restores** your original tmux config
4. **Reports** success/failure summary

### How It Works

The script uses Kitty's remote control API to automate terminal interactions:

- Launches Kitty with a unique instance name and socket
- Uses `kitten @ send-text` to type commands and navigate Neovim
- Uses `hyprctl` to focus the Kitty window before capture
- Uses `hyprshot -m window -m active` to capture the focused window non-interactively
- Window sizing is handled automatically by Hyprland

### Output

Screenshots are saved in `assets/screenshots/`:

```
night-dashboard.png
night-code.png
midnight-dashboard.png
midnight-code.png
...
dust-dashboard.png
dust-code.png
```

**Note**: These are full-size terminal screenshots. Window sizing is determined by Hyprland based on your monitor and workspace rules. Cropped versions for social media are created separately in `assets/socials/` following the instructions in `assets/socials/README.md`.

## Customization

### Configuration

Edit constants at the top of `generate_screenshots.rb`:

```ruby
TMUX_CONFIG = File.expand_path('~/dotfiles/tmux/.tmux.conf')  # Path to your tmux config
PROJECT_ROOT = File.expand_path('../..', __dir__)              # Oasis project root
OUTPUT_DIR = File.join(PROJECT_ROOT, 'assets/screenshots')     # Final screenshot location
TEMP_DIR = '/tmp/oasis-screenshots'                             # Temporary storage during capture
```

**Note**: Kitty sockets are created at `/tmp/kitty-<instance_name>` and automatically cleaned up.

### Adjusting Timing

If screenshots are capturing before UI elements fully load, adjust sleep times:

```ruby
# In send_keys (line 232)
sleep 0.5  # Increase if commands need more processing time

# In launch_kitty (line 203, 218)
sleep 0.5  # Increase if Kitty socket creation is slow

# In open_nvim_dashboard (line 239)
sleep 1  # Increase if Neovim/dashboard takes longer to render

# In open_code_file (line 246)
sleep 0.5  # Increase if file loading or syntax highlighting is slow

# In capture_screenshot (line 263)
sleep 0.5  # Increase if window focusing needs more time
```

### Troubleshooting

**Kitty remote control not working**:

- Verify `allow_remote_control yes` in `~/.config/kitty/kitty.conf`
- Check that Kitty socket is being created: `ls /tmp/kitty-*`
- Test manually:

  ```bash
  # Launch kitty with socket
  kitty -o allow_remote_control=yes --listen-on unix:/tmp/kitty-test
  # In another terminal, verify connection
  kitten @ --to unix:/tmp/kitty-test ls
  ```

- If socket exists but kitty won't respond, tmux might be failing:

  ```bash
  # Test tmux config directly
  tmux -2 -f ~/dotfiles/tmux/.tmux.conf new-session
  # Check for errors in tmux config or missing tmux-oasis plugin
  ```

**hyprshot fails to capture**:

- Ensure Hyprland is running
- Check hyprshot is installed: `which hyprshot`
- Test manually: `hyprshot -m window -m active --silent`
- Verify window focusing works: `hyprctl dispatch focuswindow title:test`
- **Note**: hyprshot may return exit code 1 even on success; script validates by checking if screenshot file was created and has content

**tmux config not found or update fails**:

- Update `TMUX_CONFIG` path in the script
- Ensure your tmux config has a line matching: `set -g @oasis_flavor "variant"`
- Script uses regex to find and replace: `/set -g @oasis_flavor ["']?\w+["']?/`
- If you see "WARNING: tmux config was not modified", check your flavor line format
- Script verifies the change was applied and raises an error if not

**Screenshots are blank or incomplete**:

- Increase sleep timings in the script (especially `send_keys` delays)
- Check that Neovim launches successfully in tmux
- Verify the example file exists: `assets/example-scripts/index.js`
- Code screenshots navigate to line 19 and move to end of line for consistent framing
- Dashboard uses Neovim's default view (snacks.nvim dashboard or empty buffer)

## Architecture

```
screenshot_generator/
├── generate_screenshots.rb      # Main orchestration script
└── README.md                    # This file
```

The script orchestrates:

1. **Kitty instances** - Spawned with unique names and remote control sockets
2. **tmux sessions** - Launched inside Kitty with oasis theme variant (server killed between variants)
3. **Neovim automation** - Controlled via `kitten @ send-text` commands
4. **hyprshot** - Captures focused window to PNG files non-interactively

## Development

### Testing Single Variant

To test with one variant before running all 18:

```ruby
# Edit generate_screenshots.rb around line 15-34 (replace VARIANTS array)
VARIANTS = %w[lagoon]  # Test with just one variant
```

Or uncomment line 37:

```ruby
# VARIANTS = %w[canyon]
```

Then run normally: `./scripts/screenshot_generator/generate_screenshots.rb`

### Debugging

To see what's happening in real-time:

1. Comment out the `close_kitty(kitty_instance)` call in `generate_variant_screenshots()` (around line 180)
2. Run with a single variant (see "Testing Single Variant" above)
3. Watch the Kitty window as commands are executed via `kitten @ send-text`
4. Check `/tmp/oasis-screenshots/` for intermediate files
5. Manually clean up:

   ```bash
   # List kitty sockets
   ls /tmp/kitty-*
   # Kill leftover kitty instances
   pkill -f "kitty.*oasis-screenshot"
   # Clean up temp directory
   rm -rf /tmp/oasis-screenshots
   ```

## Notes

- Each variant takes ~5-10 seconds to process (tmux kill + Kitty launch + screenshots + cleanup)
- **Total runtime**: ~2-4 minutes for all 18 variants
- Screenshots are overwritten if they already exist
- Original tmux config is always restored, even on error
- Kitty windows and sockets are automatically cleaned up after each variant
- tmux server is killed between variants to ensure clean theme switching
- Window dimensions determined by Hyprland (no manual sizing needed)
- Uses `kitten @` (not `kitty @`) for remote control commands
