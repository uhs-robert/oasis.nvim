# Vimium Setup

[Vimium](https://github.com/philc/vimium) is a browser extension that provides keyboard shortcuts for navigation and control, similar to Vim.

You can find the extension on [Firefox Add-Ons](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff/) or the [Chrome Web Store](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb).

## Installation

1. Choose a theme from `themes/` (e.g., `oasis_lagoon.css`)
2. Open the CSS file and find the variant you want:
   - **DARK** - Dark mode
   - **LIGHT 1** - Lightest
   - **LIGHT 2** - Light
   - **LIGHT 3** - Medium
   - **LIGHT 4** - Warm
   - **LIGHT 5** - Warmest
3. Uncomment your chosen variant by deleting the `/*` line after `NOTE: -- DELETE LINE TO ENABLE THEME`
4. Copy the entire CSS content
5. Open Vimium settings:
   - **Firefox**: `about:addons` → Vimium → Preferences → Advanced Options
   - **Chrome/Edge**: `chrome://extensions/` → Vimium → Options → Advanced Options
6. Paste into `CSS for Vimium UI`
7. Save settings
8. Reload the page to verify theme works, you may need to reload browser for it to apply globally

## Theme Structure

```text
themes/
├── oasis_lagoon.css
├── oasis_desert.css
├── oasis_canyon.css
└── ...
```

Each CSS file contains:

- 1 DARK variant
- 5 LIGHT variants (intensity 1-5: Lightest → Warmest)

Simply uncomment the variant you prefer and comment out any others.
