#!/usr/bin/env lua
-- extras/vimium-c/generate_vimiumc.lua
-- Generates Vimium-C browser extension themes from Oasis color palettes
-- Each theme file contains dual-mode CSS (day/night) for automatic switching

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")
local Directory = require("oasis.lib.directory")

local function extract_vimiumc_colors(name, palette)
  -- For desert theme, swap primary and secondary
  local is_desert = name:match("desert") ~= nil
  local primary = is_desert and palette.theme.secondary or palette.theme.primary
  local secondary = is_desert and palette.theme.primary or palette.theme.secondary

  -- Map palette structure to Vimium-C color scheme
  return {
    bg_core = palette.bg.core,
    bg_mantle = palette.bg.mantle,
    bg_surface = palette.bg.surface,
    fg = palette.fg.core,
    fg_dim = palette.fg.muted,
    link = palette.theme.strong_primary,
    border = palette.bg.mantle,
    primary = primary,
    light_primary = palette.theme.light_primary,
    secondary = secondary,
    title_match = palette.theme.accent,
    link_match = secondary,
  }
end

local function generate_vimiumc_css(name, day_palette, night_palette, intensity)
  local display_name = Utils.format_display_name(name)
  local day_colors = extract_vimiumc_colors(name, day_palette)
  local night_colors = extract_vimiumc_colors(name, night_palette)

  -- Read the CSS template
  local template = assert(File.read("./extras/vimium-c/vimium-c.css.erb"), "Missing vimium-c CSS template")

  local replacements = {
    ["{{day_name}}"] = display_name .. " Light " .. intensity,
    ["{{night_name}}"] = display_name .. " Dark",
    ["{{day_bg_core}}"] = day_colors.bg_core,
    ["{{day_bg_mantle}}"] = day_colors.bg_mantle,
    ["{{day_bg_surface}}"] = day_colors.bg_surface,
    ["{{day_fg}}"] = day_colors.fg,
    ["{{day_fg_dim}}"] = day_colors.fg_dim,
    ["{{day_link}}"] = day_colors.link,
    ["{{day_border}}"] = day_colors.border,
    ["{{day_primary}}"] = day_colors.primary,
    ["{{day_light_primary}}"] = day_colors.light_primary,
    ["{{day_secondary}}"] = day_colors.secondary,
    ["{{day_title_match}}"] = day_colors.title_match,
    ["{{day_link_match}}"] = day_colors.link_match,
    ["{{night_bg_core}}"] = night_colors.bg_core,
    ["{{night_bg_mantle}}"] = night_colors.bg_mantle,
    ["{{night_bg_surface}}"] = night_colors.bg_surface,
    ["{{night_fg}}"] = night_colors.fg,
    ["{{night_link}}"] = night_colors.link,
    ["{{night_border}}"] = night_colors.border,
    ["{{night_primary}}"] = night_colors.primary,
    ["{{night_light_primary}}"] = night_colors.light_primary,
    ["{{night_secondary}}"] = night_colors.secondary,
    ["{{night_title_match}}"] = night_colors.title_match,
    ["{{night_link_match}}"] = night_colors.link_match,
  }

  local css = template
  for pattern, value in pairs(replacements) do
    css = css:gsub(pattern, value)
  end

  return css
end

local function main(args)
  if args[1] == "--help" or args[1] == "-h" then
    print([[
Oasis Vimium-C Theme Generator

Usage:
  lua extras/vimium-c/generate_vimiumc.lua [options]

Options:
  -l, --list    List all available themes
  -h, --help    Show this help

Output Structure:
  themes/
  ├── 1/        Light intensity 1 (brightest)
  │   ├── oasis_lagoon.css
  │   └── ...
  ├── 2/
  ├── 3/        Light intensity 3 (default)
  ├── 4/
  └── 5/        Light intensity 5 (darkest)

Each CSS file contains dual-mode themes (day/night) that automatically
switch based on the browser's light/dark mode preference.
]])
    return
  end

  if args[1] == "--list" or args[1] == "-l" then
    local palette_names = Utils.get_palette_names()
    print("\n=== Available Oasis Themes ===\n")
    for i, name in ipairs(palette_names) do
      print(string.format("  %d. %s", i, Utils.capitalize(name)))
    end
    print(string.format("\nTotal: %d dual-mode themes", #palette_names))
    print("Each theme generates 5 intensity variants (light modes 1-5)\n")
    return
  end

  print("\n=== Oasis Vimium-C Theme Generator ===\n")

  local palette_names = Utils.get_palette_names()

  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d dual-mode palette(s)\n", #palette_names))

  local success_count = 0
  local error_count = 0

  -- Iterate over each palette and generate 5 intensity variants
  for _, name in ipairs(palette_names) do
    local ok, raw_palette = pcall(require, "oasis.color_palettes.oasis_" .. name)
    if not ok then
      print(string.format("✗ Failed to load palette: %s", name))
      error_count = error_count + 1
      goto continue
    end

    -- Only process dual-mode palettes
    if not Utils.is_dual_mode_palette(raw_palette) then
      print(string.format("↷ Skipping legacy palette: %s", name))
      goto continue
    end

    -- Get the dark palette (same for all intensity variants)
    local night_palette = raw_palette.dark

    -- Generate 5 light intensity variants
    for intensity = 1, 5 do
      local day_palette = Utils.generate_light_palette_at_intensity(name, intensity)
      if not day_palette then
        print(string.format("✗ Failed to generate light palette for %s at intensity %d", name, intensity))
        error_count = error_count + 1
        goto next_intensity
      end

      -- Build output path: themes/{intensity}/oasis_{name}.css
      local output_dir = string.format("extras/vimium-c/themes/%d", intensity)
      Directory.create(output_dir)
      local output_path = string.format("%s/oasis_%s.css", output_dir, name)

      -- Generate and write CSS
      local css = generate_vimiumc_css(name, day_palette, night_palette, intensity)
      File.write(output_path, css)
      print(string.format("✓ Generated: %s", output_path))
      success_count = success_count + 1

      ::next_intensity::
    end

    ::continue::
  end

  print(string.format("\n=== Summary ==="))
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main(arg)
