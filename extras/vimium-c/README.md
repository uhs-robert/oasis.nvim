# Vimium-C Setup

[Vimium C](https://github.com/gdh1995/vimium-c) is a browser extension that provides keyboard shortcuts for navigation and control, similar to Vim.

You can find the extension on [Firefox Add-Ons](https://addons.mozilla.org/en-US/firefox/addon/vimium-c/) or the [Chrome Web Store](https://chrome.google.com/webstore/detail/vimium-c-all-by-keyboard/hfjbhrkmgjlhflpefkoekicnfiajkfjh).

## Installation

1. Choose a theme from `themes/{1-5}/` (number indicates light mode intensity)
2. Copy the entire CSS content from the file
3. Open Vimium-C settings:
   - **Firefox**: `about:addons` → Vimium C → Preferences
   - **Chrome/Edge**: `chrome://extensions/` → Vimium C → Options
4. Paste into `Custom CSS for Vimium C UI`
5. Save settings

Each theme includes dual-mode CSS that automatically switches between light and dark based on your browser's theme preference.

## Theme Structure

```
themes/
├── 1/        Light intensity 1 (brightest)
├── 2/
├── 3/        Light intensity 3 (default)
├── 4/
└── 5/        Light intensity 5 (darkest)
```
