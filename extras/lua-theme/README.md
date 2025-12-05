# Lua Palette Output

1. Run `lua extras/lua-theme/generate_luatheme.lua` to build theme files (or use the pre-generated ones in `extras/lua-theme/themes`).
2. Copy the desired file from `extras/lua-theme/themes/dark/oasis_<palette>_dark.lua` or `extras/lua-theme/themes/light/<1-5>/oasis_<palette>_light_<intensity>.lua` into your project, or add that path to `package.path`.
3. Require it like a normal Lua module to get a single flat table of colors.

### Example

```lua
-- Assuming oasis_lagoon_dark.lua is on package.path
local colors = require("oasis_lagoon_dark")

print(colors.bg_core)      -- "#101825"
print(colors.theme_primary) -- "#1CA0FD"
print(colors.error)         -- diag fg for errors
print(colors.color1)        -- terminal red
```
