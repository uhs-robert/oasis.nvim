# Lua Palette Output

1. Run `lua extras/lua-theme/generate_luatheme.lua` to build theme files (or use the pre-generated ones in `extras/lua-theme/themes`).
2. Copy the desired file from `extras/lua-theme/themes/dark/oasis_<palette>.lua` or `extras/lua-theme/themes/light/<1-5>/oasis_<palette>.lua` into your project, or add that path to `package.path`.
3. Require it like a normal Lua module to get a single flat table of colors.

### Example

```lua
-- Assuming themes/dark/oasis_lagoon.lua is on package.path
local colors = require("oasis_lagoon")

print(colors.bg_core)      -- "#101825"
print(colors.theme_primary) -- "#1CA0FD"
print(colors.error)         -- diag fg for errors
print(colors.color1)        -- terminal red
```

### Keys

- Backgrounds: `bg_shadow`, `bg_core`, `bg_crust`, `bg_mantle`, `bg_surface`
- Foregrounds: `fg_core`, `fg_strong`, `fg_muted`, `fg_dim`, `fg_inlay`
- Accents: `theme_primary`, `theme_secondary`, `theme_accent`
- Status (diagnostic fg): `error`, `warning`, `info`, `hint`, `ok`
- Theme variants: `theme_primary_strong`, `theme_primary_light`, `theme_secondary_strong`, `theme_label`, `theme_cursor`
- UI: `ui_border`, `ui_title`, `ui_dir`, `ui_cursor_line`, `ui_nontext`, `ui_visual_bg`, `ui_search_bg`, `ui_search_fg`, `ui_match_bg`, `ui_match_fg`, `ui_float_bg`, `ui_float_fg`, `ui_float_title`, `ui_float_border`, `ui_picker_bg`, `ui_picker_fg`, `ui_picker_title`, `ui_picker_border` (palettes without a dedicated picker reuse their float colors)
- Diagnostic backgrounds: `error_bg`, `warning_bg`, `info_bg`, `hint_bg` (no `ok_bg`; its background is "none" in the source palette)
- Terminal: `black`..`bright_white`, `color0`..`color15`
