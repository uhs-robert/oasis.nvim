# ✨ What's New / 🚨 Breaking Changes

Check here for the latest news following an update to see if there are any breaking changes and to learn about new features.

## 🚨 [v5.0](https://github.com/uhs-robert/oasis.nvim/releases/tag/v5.0.0): Major Visual Overhaul, Redesign, and New Themes

### 🚨 BREAKING CHANGE: All themes updated, major style changes

This release is a major redesign of the palette system and theme pack. Many themes have been substantially reworked, including background ramps, semantic color relationships, and overall visual identity.

If you prefer the previous appearance, pin to the last v4.2 release:

```lua
{
  'uhs-robert/oasis.nvim',
  version = '4.2.0',
  config = function()
    require('oasis').setup({})
    vim.cmd.colorscheme('oasis')
  end,
}
```

## 🚨 [v4.1](https://github.com/uhs-robert/oasis.nvim/releases/tag/v4.1.0): Legacy Light Themes Removed

### 🚨 BREAKING CHANGE: Legacy Light Themes Removed

The standalone light themes **Dawn, Dawnlight, Day, Dusk, and Dust** have been removed in v4.1 (deprecated in v4.0).

- Use the dual-mode system with `light_style` + `light_intensity` instead.
- Closest matches: `night` with `light_intensity = 1..5` (1=brightest, 5=darkest).

### ✨ New Features

- Configurable plugin integration system.
- Expanded highlight coverage (additional Treesitter + LSP groups + mini ecosystem).
- Palette/highlight override system and LuaLS type definitions.
- New theme generators/formats: CSS, JSON, and Lua themes.
- New/expanded extras: bat themes, Warp, WezTerm/kitty updates, Yazi enhancements, tmux visual selection.

## 🚨 [v4.0](https://github.com/uhs-robert/oasis.nvim/releases/tag/v4.0.0): Dual Style Themes / Deprecated Themes

### ✨ Dual Style Themes

Each style now has **5 light theme variants**. See [README](./README.md) for screenshots.

- Config options updated with new `contrast` and `light_intensity` settings and `light/dark_style` updates.
- New API command `:OasisIntensity` to cycle intensity. Also available via lua for keymap.

### 🚨 BREAKING CHANGE: Deprecated Light Theme Migration

The following standalone **light themes have been deprecated** in favor of the dual-mode system:

| Theme     | Replacement           |
| --------- | --------------------- |
| Dawn      | `light_intensity = 1` |
| Dawnlight | `light_intensity = 2` |
| Day       | `light_intensity = 3` |
| Dusk      | `light_intensity = 4` |
| Dust      | `light_intensity = 5` |

**Deprecated themes will be completely removed on January 15th of 2026.**
