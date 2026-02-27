#!/usr/bin/env lua
-- extras/foot/generate_foot.lua
-- Generates Foot terminal themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")

local function strip_color_hash(color)
  return color:gsub("^#", "")
end

local function generate_foot_theme(name, palette)
  local display_name = Utils.format_display_name(name)
  local is_light = palette.light_mode or false

  local lines = {
    "# extras/foot/oasis_" .. name .. ".ini",
    "# name: " .. display_name,
    "# author: uhs-robert",
    "",
    "[colors]",
    string.format("cursor=%s %s", strip_color_hash(palette.bg.core), strip_color_hash(is_light and palette.syntax.statement or palette.theme.cursor)),
    string.format("foreground=%s", strip_color_hash(palette.fg.core)),
    string.format("background=%s", strip_color_hash(palette.bg.core)),
    "",
    string.format("selection-foreground=%s", strip_color_hash(palette.fg.core)),
    string.format("selection-background=%s", strip_color_hash(palette.ui.visual.bg)),
    "",
    string.format("search-box-no-match=%s %s", strip_color_hash(palette.ui.search.fg), strip_color_hash(palette.ui.search.bg)),
    string.format("search-box-match=%s %s", strip_color_hash(palette.ui.match.fg), strip_color_hash(palette.ui.match.bg)),
    "",
    string.format("urls=%s", strip_color_hash(palette.ui.dir)),
    string.format("jump-labels=%s %s", strip_color_hash(palette.ui.match.fg), strip_color_hash(palette.ui.match.bg)),
    "",
  }

  for i = 0, 7 do
    lines[#lines + 1] = string.format("regular%d=%s", i, strip_color_hash(palette.terminal["color" .. i]))
  end

  lines[#lines + 1] = ""

  for i = 0, 7 do
    lines[#lines + 1] = string.format("bright%d=%s", i, strip_color_hash(palette.terminal["color" .. (i + 8)]))
  end

  lines[#lines + 1] = string.format("16=%s", strip_color_hash(palette.ui.lineNumber))
  lines[#lines + 1] = string.format("17=%s", strip_color_hash(palette.syntax.exception))

  return table.concat(lines, "\n")
end

local function main()
  print("\n=== Oasis Foot Theme Generator ===\n")

  local palette_names = Utils.get_palette_names()

  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
    -- Build output path using shared utility
    local output_path, variant_name = Utils.build_variant_path("extras/foot", "ini", name, mode, intensity)

    -- Generate and write theme
    local theme = generate_foot_theme(variant_name, palette)
    File.write(output_path, theme)
    print(string.format("✓ Generated: %s", output_path))
  end)

  print(string.format("\n=== Summary ==="))
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
