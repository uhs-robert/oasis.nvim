#!/usr/bin/env lua
-- extras/vimium/generate_vimium.lua
-- Generates Vimium browser extension themes from Oasis color palettes
-- Each theme file contains DARK + 5 LIGHT intensity variants for user selection

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")
local Directory = require("oasis.lib.directory")

--- Extract Vimium-specific colors from an Oasis palette
--- Maps the palette structure to CSS variable names used in the Vimium template
--- @param name string Palette name (used to detect desert theme for color swap)
--- @param palette OasisPalette The source palette to extract colors from
--- @return table<string, string> colors Table of color values keyed by CSS variable name
local function extract_vimium_colors(name, palette)
  -- For desert theme, swap primary and secondary
  local is_desert = name:match("desert") ~= nil
  local primary = is_desert and palette.theme.secondary or palette.theme.primary
  local secondary = is_desert and palette.theme.primary or palette.theme.secondary

  -- Map palette structure to Vimium color scheme
  return {
    fg_core = palette.fg.core,
    bg_core = palette.bg.core,
    bg_mantle = palette.bg.mantle,
    bg_surface = palette.bg.surface,
    float_border = palette.ui.float.border.fg,
    match = palette.ui.match.bg,
    strong_primary = palette.theme.strong_primary,
    primary = primary,
    light_primary = palette.theme.light_primary,
    secondary = secondary,
    accent = palette.theme.accent,
    comment = palette.syntax.comment,
  }
end

--- Generate complete Vimium CSS from dark and light palettes
--- Reads the CSS template and replaces all {{placeholder}} tokens with actual colors
--- @param name string Palette name (without oasis_ prefix)
--- @param dark_palette OasisPalette Dark mode palette
--- @param light_palettes table<number, OasisPalette> Light palettes indexed by intensity (1-5)
--- @return string css Complete CSS content with all color variants
local function generate_vimium_css(name, dark_palette, light_palettes)
  local display_name = Utils.format_display_name(name)
  local template = assert(File.read("./extras/vimium/vimium.css.erb"), "Missing vimium CSS template")

  -- Build replacements table
  local replacements = {
    ["{{theme_name}}"] = display_name,
  }

  -- Extract dark mode colors
  local dark_colors = extract_vimium_colors(name, dark_palette)
  for key, value in pairs(dark_colors) do
    replacements["{{" .. key .. "}}"] = value
  end

  -- Extract light mode colors for each intensity (1-5)
  for intensity = 1, 5 do
    local light_colors = extract_vimium_colors(name, light_palettes[intensity])
    for key, value in pairs(light_colors) do
      replacements["{{light" .. intensity .. "_" .. key .. "}}"] = value
    end
  end

  -- Apply all replacements
  local css = template
  for pattern, value in pairs(replacements) do
    local escaped_pattern = pattern:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$])", "%%%1")
    css = css:gsub(escaped_pattern, value)
  end

  return css
end

--- Display CLI help text
--- Shows usage information, available options, and output structure
local function show_help()
  print([[
Oasis Vimium Theme Generator

Usage:
  lua extras/vimium/generate_vimium.lua [options]

Options:
  -l, --list    List all available themes
  -h, --help    Show this help

Output Structure:
  themes/
  ├── oasis_lagoon.css
  ├── oasis_desert.css
  └── ...

Each CSS file contains:
  - 1 DARK variant
  - 5 LIGHT variants (intensity 1-5: Lightest → Warmest)

Users uncomment the variant they want to use in the CSS file.
]])
end

--- List all available Oasis themes
--- Prints a numbered list of palettes that can be generated
local function list_themes()
  local palette_names = Utils.get_palette_names()
  print("\n=== Available Oasis Themes ===\n")
  for i, name in ipairs(palette_names) do
    print(string.format("  %d. %s", i, Utils.capitalize(name)))
  end
  print(string.format("\nTotal: %d themes", #palette_names))
  print("Each theme file contains DARK + 5 LIGHT intensity variants\n")
end

--- Process a single palette and generate its CSS theme file
--- @param name string Palette name (without oasis_ prefix)
--- @param output_dir string Output directory path
--- @return boolean success Whether the palette was processed successfully
local function process_palette(name, output_dir)
  local ok, raw_palette = pcall(require, "oasis.color_palettes.oasis_" .. name)
  if not ok then
    print(string.format("✗ Failed to load palette: %s", name))
    return false
  end

  if not Utils.is_dual_mode_palette(raw_palette) then
    print(string.format("✗ Palette is not dual-mode: %s", name))
    return false
  end

  -- Generate all 5 light intensity palettes
  local light_palettes = {}
  for intensity = 1, 5 do
    local light_palette = Utils.generate_light_palette_at_intensity(name, intensity)
    if not light_palette then
      print(string.format("✗ Failed to generate light palette for %s at intensity %d", name, intensity))
      return false
    end
    light_palettes[intensity] = light_palette
  end

  -- Generate and write CSS
  local output_path = string.format("%s/oasis_%s.css", output_dir, name)
  local css = generate_vimium_css(name, raw_palette.dark, light_palettes)
  File.write(output_path, css)
  print(string.format("✓ Generated: %s", output_path))

  return true
end

--- Generate Vimium themes for all palettes
--- Creates the output directory and iterates through all palettes,
--- generating a CSS file for each with dark and light variants
local function generate_all_themes()
  print("\n=== Oasis Vimium Theme Generator ===\n")

  local palette_names = Utils.get_palette_names()
  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d dual-mode palette(s)\n", #palette_names))

  local output_dir = "extras/vimium/themes"
  Directory.create(output_dir)

  local success_count = 0
  local error_count = 0

  for _, name in ipairs(palette_names) do
    if process_palette(name, output_dir) then
      success_count = success_count + 1
    else
      error_count = error_count + 1
    end
  end

  print(string.format("\n=== Summary ==="))
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

--- CLI entry point
--- Routes to appropriate handler based on command-line arguments
--- @param args string[] Command-line arguments
local function main(args)
  local arg = args[1]

  if arg == "--help" or arg == "-h" then
    show_help()
  elseif arg == "--list" or arg == "-l" then
    list_themes()
  else
    generate_all_themes()
  end
end

-- Run the generator
main(arg)
