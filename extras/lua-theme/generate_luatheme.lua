#!/usr/bin/env lua
-- extras/lua-theme/generate_luatheme.lua
-- extras/lua/generate_lua.lua
-- Generates Lua palette tables from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")

local terminal_semantic_keys = {
  "black",
  "red",
  "green",
  "yellow",
  "blue",
  "magenta",
  "cyan",
  "white",
  "bright_black",
  "bright_red",
  "bright_green",
  "bright_yellow",
  "bright_blue",
  "bright_magenta",
  "bright_cyan",
  "bright_white",
}

local terminal_numeric_keys = (function()
  local keys = {}
  for i = 0, 15 do
    keys[#keys + 1] = "color" .. i
  end
  return keys
end)()

local diag_key_map = {
  { palette = "error", output = "error" },
  { palette = "warn", output = "warning" },
  { palette = "info", output = "info" },
  { palette = "hint", output = "hint" },
  { palette = "ok", output = "ok" },
}

local function get_diag_fg(diag, key)
  local target = diag[key]
  if not target then return "" end
  return target.fg or target.fg_light or ""
end

local function generate_lua_palette(display_name, palette, output_path)
  local diag = (palette.ui and palette.ui.diag) or {}

  local lines = {
    string.format("-- %s", output_path or ("extras/lua-theme/themes/" .. display_name .. ".lua")),
    "-- Generated from Oasis palettes",
    "",
    "return {",
    "-- Backgrounds",
    string.format('\tbg_core = "%s",', palette.bg.core),
    string.format('\tbg_mantle = "%s",', palette.bg.mantle),
    string.format('\tbg_shadow = "%s",', palette.bg.shadow),
    string.format('\tbg_surface = "%s",', palette.bg.surface),
    "",
    "-- Foregrounds",
    string.format('\tfg_core = "%s",', palette.fg.core),
    string.format('\tfg_strong = "%s",', palette.fg.strong),
    string.format('\tfg_muted = "%s",', palette.fg.muted),
    string.format('\tfg_dim = "%s",', palette.fg.dim),
    "",
    "-- Accents",
    string.format('\ttheme_primary = "%s",', palette.theme.primary),
    string.format('\ttheme_secondary = "%s",', palette.theme.secondary),
    string.format('\ttheme_accent = "%s",', palette.theme.accent),
  }

  lines[#lines + 1] = ""
  lines[#lines + 1] = "-- Status"
  for _, mapping in ipairs(diag_key_map) do
    lines[#lines + 1] = string.format('\t%s = "%s",', mapping.output, get_diag_fg(diag, mapping.palette))
  end

  lines[#lines + 1] = ""
  lines[#lines + 1] = "-- ANSI Semnatic Colors"
  for _, key in ipairs(terminal_semantic_keys) do
    lines[#lines + 1] = string.format('\t%s = "%s",', key, palette.terminal[key])
  end

  lines[#lines + 1] = ""
  lines[#lines + 1] = "-- ANSI Terminal Colors"
  for _, key in ipairs(terminal_numeric_keys) do
    lines[#lines + 1] = string.format('\t%s = "%s",', key, palette.terminal[key])
  end
  lines[#lines + 1] = "}"

  return table.concat(lines, "\n")
end

local function main()
  print("\n=== Oasis Lua Palette Generator ===\n")

  local palette_names = Utils.get_palette_names()

  if #palette_names == 0 then
    print("Error: No palette files found in lua-theme/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
    local output_path, _, display_name =
      Utils.build_display_variant_path("extras/lua-theme", "lua", name, mode, intensity)
    local content = generate_lua_palette(display_name, palette, output_path)
    File.write(output_path, content)
    print(string.format("✓ Generated: %s", output_path))
  end)

  print("\n=== Summary ===")
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

main()
