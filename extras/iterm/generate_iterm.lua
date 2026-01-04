#!/usr/bin/env lua
-- extras/iterm/generate_iterm.lua
-- Generates iTerm color schemes from Oasis palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")

-- Convert hex color to normalized RGB components (0-1)
local function hex_to_components(hex)
  if not hex or hex == "NONE" then return 0, 0, 0 end

  local r, g, b = hex:match("^#?(%x%x)(%x%x)(%x%x)")
  if not r then return 0, 0, 0 end

  return tonumber(r, 16) / 255, tonumber(g, 16) / 255, tonumber(b, 16) / 255
end

-- Append a plist color dictionary for a given label
local function add_color_block(lines, label, hex, alpha)
  alpha = alpha or 1
  local r, g, b = hex_to_components(hex)

  local block = {
    "\t<key>" .. label .. "</key>",
    "\t<dict>",
    "\t\t<key>Alpha Component</key>",
    string.format("\t\t<real>%.4f</real>", alpha),
    "\t\t<key>Blue Component</key>",
    string.format("\t\t<real>%.10f</real>", b),
    "\t\t<key>Color Space</key>",
    "\t\t<string>sRGB</string>",
    "\t\t<key>Green Component</key>",
    string.format("\t\t<real>%.10f</real>", g),
    "\t\t<key>Red Component</key>",
    string.format("\t\t<real>%.10f</real>", r),
    "\t</dict>",
  }

  for _, line in ipairs(block) do
    lines[#lines + 1] = line
  end
end

local function generate_iterm_colors(display_name, palette)
  local is_light = palette.light_mode or false
  local lines = {
    '<?xml version="1.0" encoding="UTF-8"?>',
    '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">',
    '<plist version="1.0">',
    "<dict>",
    "\t<!-- name: " .. display_name .. " -->",
    "\t<!-- author: uhs-robert -->",
  }

  -- ANSI colors (deterministic order)
  local ansi_colors = {
    { "Ansi 0 Color", palette.terminal.black },
    { "Ansi 1 Color", palette.terminal.red },
    { "Ansi 2 Color", palette.terminal.green },
    { "Ansi 3 Color", palette.terminal.yellow },
    { "Ansi 4 Color", palette.terminal.blue },
    { "Ansi 5 Color", palette.terminal.magenta },
    { "Ansi 6 Color", palette.terminal.cyan },
    { "Ansi 7 Color", palette.terminal.white },
    { "Ansi 8 Color", palette.terminal.bright_black },
    { "Ansi 9 Color", palette.terminal.bright_red },
    { "Ansi 10 Color", palette.terminal.bright_green },
    { "Ansi 11 Color", palette.terminal.bright_yellow },
    { "Ansi 12 Color", palette.terminal.bright_blue },
    { "Ansi 13 Color", palette.terminal.bright_magenta },
    { "Ansi 14 Color", palette.terminal.bright_cyan },
    { "Ansi 15 Color", palette.terminal.bright_white },
  }

  for _, color in ipairs(ansi_colors) do
    add_color_block(lines, color[1], color[2])
  end

  -- Core UI colors
  add_color_block(lines, "Background Color", palette.bg.core)
  add_color_block(lines, "Foreground Color", palette.fg.core)
  add_color_block(lines, "Cursor Color", is_light and palette.syntax.statement or palette.terminal.yellow)
  add_color_block(lines, "Cursor Text Color", palette.bg.core)
  add_color_block(lines, "Bold Color", palette.fg.strong)
  add_color_block(lines, "Link Color", palette.terminal.blue)
  add_color_block(lines, "Selection Color", palette.ui.visual.bg)
  add_color_block(lines, "Selected Text Color", palette.fg.core)

  -- Extras with transparency
  add_color_block(lines, "Cursor Guide Color", palette.fg.core, 0.25)
  add_color_block(lines, "Badge Color", palette.terminal.red, 0.5)

  lines[#lines + 1] = "</dict>"
  lines[#lines + 1] = "</plist>"

  return table.concat(lines, "\n")
end

local function main()
  print("\n=== Oasis iTerm Theme Generator ===\n")

  local palette_names = Utils.get_palette_names()

  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
    local output_path, variant_name = Utils.build_variant_path("extras/iterm", "itermcolors", name, mode, intensity)
    local display_name = Utils.format_display_name(variant_name)

    -- iTerm uses the filename as the preset name; save with the friendly display name
    local output_dir = output_path:match("(.+)/[^/]+$")
    if not output_dir then
      local subdir = mode == "light" and string.format("light/%s", tostring(intensity)) or "dark"
      output_dir = string.format("extras/iterm/themes/%s", subdir)
    end
    local safe_display = display_name:gsub("/", "-")
    local friendly_output_path = string.format("%s/%s.itermcolors", output_dir, safe_display)

    local theme = generate_iterm_colors(display_name, palette)
    File.write(friendly_output_path, theme)

    -- Clean up the old slugged filename to avoid duplicates
    if friendly_output_path ~= output_path then os.remove(output_path) end

    print(string.format("✓ Generated: %s", friendly_output_path))
  end)

  print("\n=== Summary ===")
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

main()
