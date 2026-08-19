# ✨ What's New / 🚨 Breaking Changes

Check here for the latest news following an update to see if there are any breaking changes and to learn about new features.

## ✨ [v6.1](https://github.com/uhs-robert/oasis.nvim/releases/tag/v6.1.0): New Integrations, Italics Usage, and Palette Retuning

### ✨ New Features

- **nless generator**: New `extras/nless` theme generator + README for `nless` (`less` pager) integration.
- **Foot terminal**: Foot now supports light/dark auto-switching.
- **Yazi**: New plugin highlight support, plus indicator padding config across all flavors.
- **Tridactyl**: Mode indicator colors, styled completions/command prompt prefix, dedicated status font and hint span colors.
- **Plugin support**: Added noice, sidekick, and trouble integrations.
- **Snacks picker**: Added time/date and diagnostic highlight support.
- **Lagoon**: Given its own themed identifier/type tier; primary swapped to sapphire.
- **Go**: `nil` now highlighted as a builtin constant; added dedicated Go query overrides.
- **Palette**: Added a `bg_crust` depth level across all dark themes (and exported across every extras generator).
- **Palette**: `fg.core`/`fg.strong` now pin to a single shared color (from terminal white/bright_white) across every theme, via a new `fg()` helper; `dim`/`muted`/`comment` remain theme-specific.
- **Example scripts**: Added multi-language demo files for screenshots/fixtures.

### 🎨 Design: Italics New Philosophy

Italics used to be used arbitrarily and stylistically to emphasize things; now it follows a semantic system instead.

Italics are reserved for **contextual informational that should recede into the background** (decorators/attributes) and **embedded/alt-syntax that should stand apart in the foreground** (regex) rather than used loosely for emphasis. The pairing rule for each: italic + darker shade to recede into background context; italic + lighter shade to pop forward as embedded-but-visible context.

- `@string.regexp` (regex): italicized, shade lightened so it still reads as foreground despite the italic.
- `@attribute`/`@attribute.builtin` (decorators, annotations): italicized to match the embedded-syntax rule instead of plain macro styling.
- `PreProc`/`Macro`: italic/bold dropped where it no longer matched the rule; PreProc made bold instead.
- `@type.builtin`: switched from italic to bold, it's a primary type reference.

### 🛠️ Fixes & Polish

- Large pass of palette retuning across regex, func/builtin_func, preproc/macro, punctuation, statement, teal/cyan, and terminal white shades.
- `@tag.*` highlight groups remapped for clearer contrast; missing captures added.
- Luna: corrected secondary color, marked dark palette as desert variant, dropped dead khaki branch.
- WhichKey now uses accent/secondary color; Yazi which-key mask uses `bg_crust`.
- Kitty selection colors now use visual highlight; DiffText light-mode override restored.
- tmux `@thm_green` now sources from `terminal.green` instead of `syntax.string`.
- qutebrowser insert statusbar now uses `bright_red`; dark-reader text color uses `theme.primary_light`.
- WCAG tool: unwrapped dark/light palette wrapper.
- Screenshot pipeline: fixed hyprctl dispatch syntax, CR-vs-LF terminal submission, and trailing-Enter suppression on cursor motion.
- All theme exports and screenshots regenerated to match the above retuning.

## 🚨 [v6.0](https://github.com/uhs-robert/oasis.nvim/releases/tag/v6.0.0): Moonlight Default, New Theme, and Extended Extras

### 🚨 BREAKING CHANGE: Default theme changed from `lagoon` to `moonlight`

The default colorscheme is now **Moonlight**. This makes the default palette more neutral and better aligns with Oasis’ Desert-inspired syntax model, especially the staple khaki statement/control colors.

If you prefer to keep Lagoon as your default, please set it as your style like so:

```lua
require('oasis').setup({
  style = "lagoon",
})
vim.cmd.colorscheme('oasis')
```

### ✨ New Features

- **New theme**: `moonlight`, the deep steel-blue desert night illuminated by pale moonlight.
- **VS Code theme support**: 96 total variants covering all 16 palettes × dark + 5 light intensities.
- **Starship prompt theme**: New Starship integration in `extras/starship/`.
- **Snacks picker integration**: Dedicated UI palette types for snacks.nvim picker.
- **Theme status color**: New `theme.status` property for status bar integrations.
- **Bold syntax styling**: Strategic bold accents on key syntax groups for improved visual hierarchy.
- **MatchParen**: Underline-only by default (background disabled) for less intrusive matching.
- **Light theme overhaul**: All 16 palettes regenerated with HSL-preserving background seeds, improved diagnostic colors, and tighter contrast targets.

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
