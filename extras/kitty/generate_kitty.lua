#!/usr/bin/env lua
-- extras/kitty/generate_kitty.lua
-- Generates Kitty terminal themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")

local function generate_kitty_theme(name, palette)
  local display_name = Utils.format_display_name(name)
  local is_light = palette.light_mode or false

  local lines = {
    "# extras/kitty/oasis_" .. name .. ".conf",
    "## name: " .. display_name,
    "## author: uhs-robert",
    "",
    "# Palette",
  }

  -- Terminal palette colors (0-15)
  for i = 0, 7 do
    lines[#lines + 1] = string.format("%-24s %s", "color" .. i, palette.terminal["color" .. i])
    lines[#lines + 1] = string.format("%-24s %s", "color" .. (i + 8), palette.terminal["color" .. (i + 8)])
    lines[#lines + 1] = ""
  end

  -- Static content
  local static = {
    "# Core",
    string.format("%-24s %s", "foreground", palette.fg.core),
    string.format("%-24s %s", "background", palette.bg.core),
    "",
    "# Selection",
    string.format("%-24s %s", "selection_background", palette.ui.search.bg),
    string.format("%-24s %s", "selection_foreground", palette.ui.search.fg),
    "",
    "# Cursor",
    string.format("%-24s %s", "cursor", is_light and palette.syntax.statement or palette.theme.cursor),
    string.format("%-24s %s", "cursor_text_color", palette.bg.core),
    "",
    "# Borders (panes)",
    string.format("%-24s %s", "active_border_color", palette.ui.border),
    string.format("%-24s %s", "inactive_border_color", palette.ui.float.border.bg),
    "",
    "# Tabs",
    string.format("%-24s %s", "active_tab_foreground", palette.bg.core),
    string.format("%-24s %s", "active_tab_background", palette.theme.primary),
    string.format("%-24s %s", "inactive_tab_foreground", palette.theme.primary),
    string.format("%-24s %s", "inactive_tab_background", palette.bg.mantle),
    "",
  }

  for _, line in ipairs(static) do
    lines[#lines + 1] = line
  end

  return table.concat(lines, "\n")
end

local function main()
  print("\n=== Oasis Kitty Theme Generator ===\n")

  local palette_names = Utils.get_palette_names()

  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
    -- Build output path using shared utility
    local output_path, variant_name = Utils.build_variant_path("extras/kitty", "conf", name, mode, intensity)

    -- Generate and write theme
    local theme = generate_kitty_theme(variant_name, palette)
    File.write(output_path, theme)
    print(string.format("✓ Generated: %s", output_path))
  end)

  print(string.format("\n=== Summary ==="))
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
