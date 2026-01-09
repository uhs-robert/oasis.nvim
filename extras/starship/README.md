# Starship Setup

1. Create `~/.config/starship/themes`
2. Download theme file into `themes` directory
3. Source the theme in your `~/.config/starship.toml`

### Example

```toml
# Import the Oasis theme palette
palette = "oasis_lagoon"

# Source the theme file
"$schema" = 'https://starship.rs/config-schema.json'

[palettes.oasis_lagoon]
# This will be populated by the theme file
# You can override specific colors here if desired

format = """
[┌───────────────────>](fg:accent)\
$os\
$directory\
$git_branch\
$git_status\
[└─>](fg:accent) """

# ... rest of your starship configuration
```

Or use a simpler import approach:

```bash
# Add to your shell rc file (.bashrc, .zshrc, etc.)
export STARSHIP_CONFIG=~/.config/starship/themes/oasis_lagoon.toml
```

> [!TIP]
> You can dynamically switch themes by changing the `palette` value in your config or by modifying the `STARSHIP_CONFIG` environment variable.
