# Tridactyl Setup

[Tridactyl](https://github.com/tridactyl/tridactyl) is a browser extension that provides Vim-like keybindings for Firefox.

You can find the extension on [Firefox Add-Ons](https://addons.mozilla.org/en-US/firefox/addon/tridactyl-vim/) OR use the beta from github (recommended) [Github Beta](https://github.com/tridactyl/tridactyl)

## Installation

1. Choose a theme from `themes/` based on your preferred mode and palette:
   - `themes/dark/` — Dark variants
   - `themes/light/1/` — Lightest
   - `themes/light/2/` — Light
   - `themes/light/3/` — Medium
   - `themes/light/4/` — Warm
   - `themes/light/5/` — Warmest
2. Copy the theme files you'd like to use
3. Paste the file(s) to your `~/.config/tridactyl/themes/` directory
4. In Firefox, run the following Tridactyl command (use your theme name):

   ```vim
   :colors oasis_lagoon_dark
   ```

5. To make it permanent, add it to your `tridactylrc`:

   ```vim
   colors oasis_lagoon_dark
   ```

## Theme Structure

```text
themes/
├── dark/
│   ├── oasis_lagoon_dark.css
│   ├── oasis_desert_dark.css
│   └── ...
└── light/
    ├── 1/
    │   ├── oasis_lagoon_light_1.css
    │   └── ...
    ├── 2/
    ├── 3/
    ├── 4/
    └── 5/
```

Each palette has:

- 1 dark variant
- 5 light variants (intensity 1–5: Lightest → Warmest)
