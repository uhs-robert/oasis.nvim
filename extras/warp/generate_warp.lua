#!/usr/bin/env lua
-- extras/warp/generate_warp.lua
-- Generates Warp terminal themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")

--- Generate a Warp theme YAML string from an Oasis palette
--- @param variant_name string Internal variant name (e.g., "lagoon_dark", "lagoon_light_3")
--- @param palette table Extracted palette table
--- @return string yaml YAML content for the Warp theme
local function generate_warp_theme(variant_name, palette)
  local display_name = Utils.format_display_name(variant_name)
  local is_light = palette.light_mode or false

  local lines = {
    string.format("# extras/warp/oasis_%s.yaml", variant_name),
    string.format("# name: %s", display_name),
    "# author: uhs-robert",
    "",
    string.format("name: %s", display_name),
    string.format("accent: '%s'", palette.theme.accent),
    string.format("cursor: '%s'", is_light and palette.syntax.statement or palette.terminal.yellow),
    string.format("background: '%s'", palette.bg.core),
    string.format("foreground: '%s'", palette.fg.core),
    string.format("details: %s", is_light and "lighter" or "darker"),
    "terminal_colors:",
    "  normal:",
    string.format("    black: '%s'", palette.terminal.color0),
    string.format("    red: '%s'", palette.terminal.color1),
    string.format("    green: '%s'", palette.terminal.color2),
    string.format("    yellow: '%s'", palette.terminal.color3),
    string.format("    blue: '%s'", palette.terminal.color4),
    string.format("    magenta: '%s'", palette.terminal.color5),
    string.format("    cyan: '%s'", palette.terminal.color6),
    string.format("    white: '%s'", palette.terminal.color7),
    "  bright:",
    string.format("    black: '%s'", palette.terminal.color8),
    string.format("    red: '%s'", palette.terminal.color9),
    string.format("    green: '%s'", palette.terminal.color10),
    string.format("    yellow: '%s'", palette.terminal.color11),
    string.format("    blue: '%s'", palette.terminal.color12),
    string.format("    magenta: '%s'", palette.terminal.color13),
    string.format("    cyan: '%s'", palette.terminal.color14),
    string.format("    white: '%s'", palette.terminal.color15),
  }

  return table.concat(lines, "\n")
end

local function main()
  print("\n=== Oasis Warp Theme Generator ===\n")

  local palette_names = Utils.get_palette_names()

  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
    -- Build output path using shared utility
    local output_path, variant_name = Utils.build_variant_path("extras/warp", "yaml", name, mode, intensity)

    -- Generate and write theme
    local theme = generate_warp_theme(variant_name, palette)
    File.write(output_path, theme)
    print(string.format("✓ Generated: %s", output_path))
  end)

  print("\n=== Summary ===")
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
