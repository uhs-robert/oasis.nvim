# Starship

Oasis palette files for [Starship](https://starship.rs) terminal shell prompt.

## Setup

### Option A – palette block only (to embed in your custom setup)

Add the palette to your existing `~/.config/starship.toml`:

1. Copy the `[palettes.oasis_<variant>]` block from the theme file into your config.
2. Set `palette = "oasis_<variant>"` at the top of your config.

**Example** (`~/.config/starship.toml`):

```toml
"$schema" = 'https://starship.rs/config-schema.json'
palette = "oasis_lagoon_dark"

[palettes.oasis_lagoon_dark]
black         = '#101825'
white         = '#FFF7D7'
# ... rest of the palette block
```

### Option B – use the bundled format (to use our prebuilt custom setup)

The `starship.toml` in this directory also provides an opinionated prompt layout built around Oasis colors. Feel free to use it if you like:

1. Copy `starship.toml` to `~/.config/starship.toml` (or merge it into your existing config).
2. Copy the palette block from `themes/dark/oasis_<variant>.toml` into your config.

## Available themes

Themes are organized under `themes/`:

```text
themes/
  dark/
  light/
    1/            # lightest
    2/
    3/
    4/
    5/            # darkest light variant
```

Each file is named `oasis_<variant>_<mode>.toml` (e.g., `oasis_lagoon_dark.toml`).
