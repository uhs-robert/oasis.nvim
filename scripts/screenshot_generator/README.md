# Screenshot Generator

Automated screenshot generation for all 18 Oasis theme variants using VHS (Video to High-quality Screenshot).

## Overview

This tool automates the process of capturing screenshots for all Oasis theme variants:

- **Dashboard screenshots**: Neovim with snacks.nvim dashboard
- **Code screenshots**: Example JavaScript file with syntax highlighting

## Requirements

### Dependencies

1. **VHS** - Terminal recorder and screenshot tool

   ```bash
   # Install from https://github.com/charmbracelet/vhs
   # macOS
   brew install vhs

   # Linux (various package managers)
   # See: https://github.com/charmbracelet/vhs#installation
   ```

2. **tmux** - Terminal multiplexer

### Configuration

The script expects:

- **tmux config** at `~/dotfiles/tmux/.tmux.conf` so you may need to update the script to match your tmux home directory.
- Config should contain a line like: `set -g @oasis_flavor "lagoon"`
- **tmux-oasis theme** installed and configured

## Usage

Run the generator from the project root:

```bash
./scripts/screenshot_generator/generate_screenshots.rb
```

### What It Does

1. **Backs up** your current tmux config
2. **For each variant**:
   - Updates tmux config to use that variant
   - Generates VHS tape file from template
   - Records dashboard screenshot with VHS (1266x1389)
   - Records code screenshot with VHS (1266x1389)
   - Saves full-size screenshots to `assets/screenshots/`
3. **Restores** your original tmux config
4. **Reports** success/failure summary

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

**Note**: These are full-size terminal screenshots (1266x1389). Cropped versions for social media are created separately in `assets/socials/` following the instructions in `assets/socials/README.md`.

## Customization

### Templates

VHS tape templates are located in this directory:

- `tape-dashboard.tape.template` - Dashboard screenshot configuration
- `tape-code.tape.template` - Code screenshot configuration

Templates use ERB syntax with `<%= variant %>` placeholders.

### Configuration

Edit constants in `generate_screenshots.rb`:

```ruby
TMUX_CONFIG = File.expand_path('~/dotfiles/tmux/.tmux.conf')
```

To change terminal dimensions, edit the VHS tape templates:

- `tape-dashboard.tape.template`: `Set Width` and `Set Height`
- `tape-code.tape.template`: `Set Width` and `Set Height`

### Troubleshooting

**VHS recordings fail**:

- Ensure tmux-oasis theme is properly installed
- Check that VHS can access your terminal emulator
- Try running a single tape manually: `vhs /tmp/test.tape`
- Verify terminal dimensions (1266x1389) work with your setup

**tmux config not found**:

- Update `TMUX_CONFIG` path in the script
- Ensure your tmux config has the `@oasis_flavor` setting

## Architecture

```
screenshot_generator/
├── generate_screenshots.rb      # Main orchestration script
├── tape-dashboard.tape.template # VHS template for dashboard
├── tape-code.tape.template      # VHS template for code
└── README.md                    # This file
```

## Development

### Testing Single Variant

To test with one variant before running all 18:

```ruby
# Edit generate_screenshots.rb
VARIANTS = %w[lagoon]  # Test with just one variant
```

Then run normally: `./scripts/screenshot_generator/generate_screenshots.rb`

### Adding New Screenshot Types

1. Create new template: `tape-newtype.tape.template`
2. Add call in `generate_variant_screenshots()` method
3. Define crop dimensions if needed
4. Update this README

## Notes

- Each variant takes ~10-15 seconds to process (VHS recording + cropping)
- **Total runtime**: ~5-8 minutes for all 18 variants
- Screenshots are overwritten if they already exist
- Original tmux config is always restored, even on error
