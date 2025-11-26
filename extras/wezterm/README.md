# Wezterm Setup

1. Create `~/.config/wezterm/colors` if it doesn't exist.
2. Place the generated `oasis_<theme_name>.toml` file into the `colors` directory.
3. In your `wezterm.lua` configuration file, apply the theme using `color_scheme = "Oasis Lagoon` (for example).

### Example `wezterm.lua` configuration

```lua
return {
  -- ...your existing config
  color_scheme = "Oasis Lagoon"
}
```

### Example Using Your OS Theme

```lua
local wezterm = require "wezterm"

function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Oasis Lagoon"
  else
    return "Oasis Dawn"
  end
end

return {
  -- ...your existing config
  color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
}
```

