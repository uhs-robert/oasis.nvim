#!/usr/bin/env lua
-- extras/generate_themes.lua
-- Generates Kitty and Ghostty terminal themes from Oasis color palettes

local function get_palette_files()
  local handle = io.popen("ls lua/oasis/color_palettes/oasis_*.lua 2>/dev/null")
  local result = handle:read("*a")
  handle:close()

  local files = {}
  for file in result:gmatch("[^\n]+") do
    local name = file:match("oasis_(%w+)%.lua")
    if name then
      table.insert(files, name)
    end
  end

  table.sort(files)
  return files
end

local function load_palette(name)
  -- Add project root to package path
  package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"

  local palette_name = "oasis_" .. name
  local ok, palette = pcall(require, "oasis.color_palettes." .. palette_name)

  if not ok then
    return nil, "Failed to load palette: " .. palette
  end

  return palette
end

local function get_display_name(name)
  -- Capitalize first letter
  return name:gsub("^%l", string.upper)
end

local function generate_kitty_config(name, palette)
  local display_name = get_display_name(name)
  local is_light = palette.light_mode or false
  local term = palette.terminal

  -- Determine selection color (use visual.orange for dark, visual.light_blue for light)
  local visual_color = is_light and "#D1C085" or "#5A3824"

  -- Special case handling for some themes based on their primary color
  if name == "canyon" then
    visual_color = "#5A3824"
  elseif name == "lagoon" or name == "mirage" or name == "midnight" then
    visual_color = is_light and "#9BC1E6" or "#335668"
  elseif name:match("dawn") or name:match("dusk") or name:match("dust") or name == "day" then
    visual_color = palette.bg.surface
  end

  -- Cursor color (typically color3 or color11)
  local cursor_color = term.color3

  -- Tab colors
  local active_tab_fg = palette.bg.core
  local active_tab_bg = cursor_color
  local inactive_tab_fg = term.color8
  local inactive_tab_bg = is_light and palette.fg.core or "#1A1A1A"

  local config = string.format([[# extras/kitty/oasis_%s.conf
## name: Oasis %s

# Palette
color0                   %s
color8                   %s

color1                   %s
color9                   %s

color2                   %s
color10                  %s

color3                   %s
color11                  %s

color4                   %s
color12                  %s

color5                   %s
color13                  %s

color6                   %s
color14                  %s

color7                   %s
color15                  %s

# Core
foreground               %s
background               %s

# Selection
selection_background     %s
selection_foreground     %s

# Cursor
cursor                   %s
cursor_text_color        %s

# Borders (panes)
active_border_color      %s
inactive_border_color    %s

# Tabs
active_tab_foreground    %s
active_tab_background    %s
inactive_tab_foreground  %s
inactive_tab_background  %s
]],
    name, display_name,
    term.color0, term.color8,
    term.color1, term.color9,
    term.color2, term.color10,
    term.color3, term.color11,
    term.color4, term.color12,
    term.color5, term.color13,
    term.color6, term.color14,
    term.color7, term.color15,
    palette.fg.core, palette.bg.core,
    visual_color, palette.fg.core,
    cursor_color, palette.bg.core,
    term.color1, term.color8,
    active_tab_fg, active_tab_bg,
    inactive_tab_fg, inactive_tab_bg
  )

  return config
end

local function generate_ghostty_config(name, palette)
  local is_light = palette.light_mode or false
  local term = palette.terminal

  -- Cursor color (typically color3 or color11)
  local cursor_color = term.color3

  -- Determine selection color (use visual.orange for dark, visual.light_blue for light)
  local visual_color = is_light and "#D1C085" or "#5A3824"

  -- Special case handling
  if name == "canyon" then
    visual_color = "#5A3824"
  elseif name == "lagoon" or name == "mirage" or name == "midnight" then
    visual_color = is_light and "#9BC1E6" or "#335668"
  elseif name:match("dawn") or name:match("dusk") or name:match("dust") or name == "day" then
    visual_color = palette.bg.surface
  end

  local config = string.format([[palette = 0=%s
palette = 8=%s

palette = 1=%s
palette = 9=%s

palette = 2=%s
palette = 10=%s

palette = 3=%s
palette = 11=%s

palette = 4=%s
palette = 12=%s

palette = 5=%s
palette = 13=%s

palette = 6=%s
palette = 14=%s

palette = 7=%s
palette = 15=%s

foreground = %s
background = %s

selection-background = %s
selection-foreground = %s

cursor-color = %s
cursor-text = %s
]],
    term.color0, term.color8,
    term.color1, term.color9,
    term.color2, term.color10,
    term.color3, term.color11,
    term.color4, term.color12,
    term.color5, term.color13,
    term.color6, term.color14,
    term.color7, term.color15,
    palette.fg.core, palette.bg.core,
    visual_color, palette.fg.core,
    cursor_color, palette.bg.core
  )

  return config
end

local function write_file(path, content)
  local file = io.open(path, "w")
  if not file then
    return false, "Could not open file for writing: " .. path
  end

  file:write(content)
  file:close()
  return true
end

local function main(args)
  local generate_kitty = true
  local generate_ghostty = true

  -- Parse arguments
  if args[1] == "kitty" then
    generate_ghostty = false
  elseif args[1] == "ghostty" then
    generate_kitty = false
  elseif args[1] == "--help" or args[1] == "-h" then
    print([[
Oasis Terminal Theme Generator

Usage:
  lua extras/generate_themes.lua [kitty|ghostty|--all]

Options:
  kitty      Generate only Kitty themes
  ghostty    Generate only Ghostty themes
  --all      Generate both (default)
  -h, --help Show this help

Examples:
  lua extras/generate_themes.lua          # Generate all
  lua extras/generate_themes.lua kitty    # Only Kitty
  lua extras/generate_themes.lua ghostty  # Only Ghostty
]])
    return
  end

  print("\n=== Oasis Terminal Theme Generator ===\n")

  local palette_names = get_palette_files()

  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local success_count = 0
  local error_count = 0

  for _, name in ipairs(palette_names) do
    local palette, err = load_palette(name)

    if not palette then
      print(string.format("✗ Failed to load %s: %s", name, err))
      error_count = error_count + 1
    else
      local display_name = get_display_name(name)

      -- Generate Kitty config
      if generate_kitty then
        local kitty_config = generate_kitty_config(name, palette)
        local kitty_path = string.format("extras/kitty/oasis_%s.conf", name)
        local ok, write_err = write_file(kitty_path, kitty_config)

        if ok then
          print(string.format("✓ Generated Kitty: %s", kitty_path))
          success_count = success_count + 1
        else
          print(string.format("✗ Failed to write Kitty config: %s", write_err))
          error_count = error_count + 1
        end
      end

      -- Generate Ghostty config
      if generate_ghostty then
        local ghostty_config = generate_ghostty_config(name, palette)
        local ghostty_path = string.format("extras/ghostty/oasis_%s", name)
        local ok, write_err = write_file(ghostty_path, ghostty_config)

        if ok then
          print(string.format("✓ Generated Ghostty: %s", ghostty_path))
          success_count = success_count + 1
        else
          print(string.format("✗ Failed to write Ghostty config: %s", write_err))
          error_count = error_count + 1
        end
      end
    end
  end

  print(string.format("\n=== Summary ==="))
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main(arg)
