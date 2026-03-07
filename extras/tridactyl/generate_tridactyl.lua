#!/usr/bin/env lua
-- extras/tridactyl/generate_tridactyl.lua
-- Generates Tridactyl browser extension themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")

local TEMPLATE_PATH = "./extras/tridactyl/tridactyl.css.erb"

--- Convert hex color string to lowercase
--- @param color string Hex color (e.g. "#FF7979")
--- @return string Lowercased hex color (e.g. "#ff7979")
local function hex(color)
  return color:lower()
end

--- Extract Tridactyl-specific colors from an Oasis palette
--- @param palette table Extracted palette (dark or light mode)
--- @return table<string, string> colors Table of color values keyed by template placeholder name
local function extract_tridactyl_colors(palette)
  local t = palette.terminal
  local is_light = palette.light_mode or false
  -- cursor is not generated for light palettes; fall back to syntax.statement
  local cursor = palette.theme.cursor or (is_light and palette.syntax.statement) or palette.theme.primary
  return {
    -- Theme
    accent = hex(palette.theme.accent),
    cursor = hex(cursor),
    label = hex(palette.theme.label),
    light_primary = hex(palette.theme.light_primary),
    primary = hex(palette.theme.primary),
    secondary = hex(palette.theme.secondary),
    strong_primary = hex(palette.theme.strong_primary),
    -- Background
    bg_core = hex(palette.bg.core),
    bg_mantle = hex(palette.bg.mantle),
    bg_shadow = hex(palette.bg.shadow),
    bg_surface = hex(palette.bg.surface),
    -- Foreground
    fg_comment = hex(palette.fg.comment),
    fg_core = hex(palette.fg.core),
    fg_dim = hex(palette.fg.dim),
    fg_muted = hex(palette.fg.muted),
    fg_strong = hex(palette.fg.strong),
    -- UI
    ui_search_bg = hex(palette.ui.search.bg),
    ui_border = hex(palette.ui.border),
    -- Terminal
    terminal_black = hex(t.black),
    terminal_blue = hex(t.blue),
    terminal_bright_black = hex(t.bright_black),
    terminal_bright_blue = hex(t.bright_blue),
    terminal_bright_cyan = hex(t.bright_cyan),
    terminal_bright_green = hex(t.bright_green),
    terminal_bright_magenta = hex(t.bright_magenta),
    terminal_bright_red = hex(t.bright_red),
    terminal_bright_white = hex(t.bright_white),
    terminal_bright_yellow = hex(t.bright_yellow),
    terminal_cyan = hex(t.cyan),
    terminal_green = hex(t.green),
    terminal_magenta = hex(t.magenta),
    terminal_red = hex(t.red),
    terminal_white = hex(t.white),
    terminal_yellow = hex(t.yellow),
  }
end

--- Generate a Tridactyl CSS theme from an Oasis palette
--- @param variant_name string Variant name (e.g. "lagoon_dark", "lagoon_light_3")
--- @param output_path string Output file path (used in the file header comment)
--- @param palette table Extracted palette (dark or light mode)
--- @return string css Complete CSS content with all color values substituted
local function generate_tridactyl_css(variant_name, output_path, palette)
  local template = assert(File.read(TEMPLATE_PATH), "Missing tridactyl CSS template: " .. TEMPLATE_PATH)
  local display_name = Utils.format_display_name(variant_name):upper():gsub("^OASIS ", "")

  -- Relative path for the file header comment
  local rel_path = output_path:gsub("^%./", "")

  local colors = extract_tridactyl_colors(palette)
  colors.file_path = rel_path
  colors.display_name = Utils.format_display_name(variant_name)
  colors.theme_name = display_name

  -- Replace all {{placeholder}} tokens
  local css = template
  for key, value in pairs(colors) do
    local pattern = "{{" .. key .. "}}"
    local escaped = pattern:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$])", "%%%1")
    css = css:gsub(escaped, value)
  end

  return css
end

local function main()
  print("\n=== Oasis Tridactyl Theme Generator ===\n")

  local palette_names = Utils.get_palette_names()
  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
    local output_path, variant_name = Utils.build_variant_path("extras/tridactyl", "css", name, mode, intensity)
    local css = generate_tridactyl_css(variant_name, output_path, palette)
    File.write(output_path, css)
    print(string.format("✓ Generated: %s", output_path))
  end)

  print(string.format("\n=== Summary ==="))
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

main()
