#!/usr/bin/env lua
-- extras/starship/generate_starship.lua
-- Generates Starship prompt palette files from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")

local function generate_starship_palette(name, palette)
  local display_name = Utils.format_display_name(name)
  local t = palette.terminal

  local is_desert = name:match("^desert")
  local p = palette.palette
  local primary = is_desert and (p and p.secondary[500] or palette.theme.secondary)
    or (p and p.primary[500] or palette.theme.primary)

  local palette_key = "oasis_" .. name
  local lines = {
    "# " .. display_name .. " – Starship palette",
    "# https://github.com/uhs-robert/oasis.nvim",
    "",
    'palette = "' .. palette_key .. '"',
    "",
    "[palettes." .. palette_key .. "]",
    "# Accent",
    "primary       = '" .. primary .. "'",
    "strong_primary = '" .. palette.theme.strong_primary .. "'",
    "",
    "# ANSI colors (0-7)",
    "black         = '" .. t.color0 .. "'",
    "red           = '" .. t.color1 .. "'",
    "green         = '" .. t.color2 .. "'",
    "blue          = '" .. t.color4 .. "'",
    "purple        = '" .. t.color5 .. "'",
    "cyan          = '" .. t.color6 .. "'",
    "white         = '" .. t.color7 .. "'",
    "",
    "# Bright ANSI colors (8-15)",
    "bright_black  = '" .. t.color8 .. "'",
    "bright_red    = '" .. t.color9 .. "'",
    "bright_green  = '" .. t.color10 .. "'",
    "bright_yellow = '" .. t.color11 .. "'",
    "bright_blue   = '" .. t.color12 .. "'",
    "bright_purple = '" .. t.color13 .. "'",
    "bright_cyan   = '" .. t.color14 .. "'",
    "bright_white  = '" .. t.color15 .. "'",
    "",
  }

  return table.concat(lines, "\n")
end

local function main()
  print("\n=== Oasis Starship Palette Generator ===\n")

  local palette_names = Utils.get_palette_names()

  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
    local output_path, variant_name = Utils.build_variant_path("extras/starship", "toml", name, mode, intensity)

    local theme = generate_starship_palette(variant_name, palette)
    File.write(output_path, theme)
    print(string.format("✓ Generated: %s", output_path))
  end)

  print(string.format("\n=== Summary ==="))
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

main()
