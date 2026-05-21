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

local function build_color_section(section_name, palette)
  local is_light = palette.light_mode or false
  local lines = {
    "[" .. section_name .. "]",
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

local function generate_foot_theme(name, intensity, dark_palette, light_palette)
  local display_name = Utils.format_display_name(name .. "_light_" .. intensity)
  local header = table.concat({
    "# extras/foot/themes/" .. intensity .. "/oasis_" .. name .. ".ini",
    "# name: " .. display_name,
    "# author: uhs-robert",
  }, "\n")

  return header
    .. "\n\n"
    .. build_color_section("colors-dark", dark_palette)
    .. "\n\n"
    .. build_color_section("colors-light", light_palette)
    .. "\n"
end

local function main()
  print("\n=== Oasis Foot Theme Generator ===\n")

  local palette_names = Utils.get_palette_names()

  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local success_count = 0
  local error_count = 0

  for _, name in ipairs(palette_names) do
    local ok, raw_palette = pcall(require, "oasis.color_palettes.oasis_" .. name)
    if not ok or not Utils.is_dual_mode_palette(raw_palette) then
      print(string.format("✗ Skipping non-dual-mode palette: %s", name))
      error_count = error_count + 1
      goto continue
    end

    local dark_palette = raw_palette.dark

    for intensity = 1, 5 do
      local light_palette = Utils.generate_light_palette_at_intensity(name, intensity)
      if not light_palette then
        print(string.format("✗ Failed to generate light palette for %s at intensity %d", name, intensity))
        error_count = error_count + 1
        goto next_intensity
      end

      local output_dir = string.format("extras/foot/themes/%d", intensity)
      require("oasis.lib.directory").create(output_dir)
      local output_path = string.format("%s/oasis_%s.ini", output_dir, name)

      local theme = generate_foot_theme(name, intensity, dark_palette, light_palette)
      File.write(output_path, theme)
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
main()
