# Wezterm Setup

1. Create `~/.config/wezterm/colors/` if it doesn't exist.
2. Place the generated `oasis_<theme_name>.toml` file into the `colors` directory.
3. In your `wezterm.lua` configuration file, apply the theme using `color_scheme = "Oasis Lagoon Dark"` or `color_scheme = "Oasis Lagoon Light 3"` (for example).

### Basic Example `wezterm.lua` configuration

```lua
return {
  -- ...your existing config
  color_scheme = "Oasis Lagoon" -- or "Oasis Lagoon Light 3"
}
```

### Advanced Example Using Your OS Theme

```lua
local wezterm = require "wezterm"
local config = wezterm.config_builder()

--- Generates an Oasis theme name based on appearance and preferences.
--- @param appearance string: The appearance mode from wezterm.gui.get_appearance() (e.g., "Dark", "Light")
--- @param name string|nil: Theme variant name (default: "Lagoon")
--- @param light_intensity string|number|nil: Light mode intensity level 1-5 (default: "3")
--- @return string: The formatted Oasis theme name (e.g., "Oasis Lagoon Dark" or "Oasis Lagoon Light 3")
local function get_oasis_theme(appearance, name, light_intensity)
 -- Defaults
 name = name or "Lagoon"
 light_intensity = light_intensity or 3

 -- Check if dark mode is requested
 if appearance:find("Dark") then
  return "Oasis " .. name .. " Dark"
 else
  return "Oasis " .. name .. " Light " .. light_intensity
 end
end

config.color_scheme = get_oasis_theme(wezterm.gui.get_appearance(), "Lagoon", 3) -- Change Lagoon with your preferred theme

return config
```
