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
  return target.fg or ""
end

local function get_diag_bg(diag, key)
  local target = diag[key]
  if not target then return "" end
  return target.bg or ""
end

local function generate_lua_palette(display_name, palette, output_path, is_desert)
  -- Desert-family themes swap primary and secondary (see lua/oasis/theme_generator.lua)
  local theme = palette.theme
  local primary = is_desert and theme.secondary or theme.primary
  local secondary = is_desert and theme.primary or theme.secondary

  -- Desert swaps primary/secondary above, so their strong/light variants swap too.
  -- secondary_strong isn't defined on every palette; fall back to flat secondary.
  local primary_strong = is_desert and theme.secondary_strong or theme.primary_strong
  local primary_light = is_desert and theme.secondary_light or theme.primary_light
  local secondary_strong = is_desert and theme.primary_strong or (theme.secondary_strong or secondary)

  local ui = palette.ui or {}
  local diag = ui.diag or {}
  local float = ui.float or {}
  -- Not every palette defines a dedicated picker; reuse float, matching the
  -- fallback theme_generator.lua uses for SnacksPicker highlights.
  local picker = ui.picker or float
  local float_border = float.border or {}
  local picker_border = picker.border or float_border

  local lines = {
    string.format("-- %s", output_path or ("extras/lua-theme/themes/" .. display_name .. ".lua")),
    "-- Generated from Oasis palettes",
    "",
    "return {",
    "-- Backgrounds",
    string.format('\tbg_shadow = "%s",', palette.bg.shadow),
    string.format('\tbg_core = "%s",', palette.bg.core),
    string.format('\tbg_crust = "%s",', palette.bg.crust),
    string.format('\tbg_mantle = "%s",', palette.bg.mantle),
    string.format('\tbg_surface = "%s",', palette.bg.surface),
    "",
    "-- Foregrounds",
    string.format('\tfg_core = "%s",', palette.fg.core),
    string.format('\tfg_strong = "%s",', palette.fg.strong),
    string.format('\tfg_muted = "%s",', palette.fg.muted),
    string.format('\tfg_dim = "%s",', palette.fg.dim),
    string.format('\tfg_inlay = "%s",', palette.fg.inlay),
    "",
    "-- Accents",
    string.format('\ttheme_primary = "%s",', primary),
    string.format('\ttheme_secondary = "%s",', secondary),
    string.format('\ttheme_accent = "%s",', palette.theme.accent),
  }

  lines[#lines + 1] = ""
  lines[#lines + 1] = "-- Status"
  for _, mapping in ipairs(diag_key_map) do
    lines[#lines + 1] = string.format('\t%s = "%s",', mapping.output, get_diag_fg(diag, mapping.palette))
  end

  lines[#lines + 1] = ""
  lines[#lines + 1] = "-- Theme Variants"
  lines[#lines + 1] = string.format('\ttheme_primary_strong = "%s",', primary_strong)
  lines[#lines + 1] = string.format('\ttheme_primary_light = "%s",', primary_light)
  lines[#lines + 1] = string.format('\ttheme_secondary_strong = "%s",', secondary_strong)
  lines[#lines + 1] = string.format('\ttheme_label = "%s",', theme.label)
  lines[#lines + 1] = string.format('\ttheme_cursor = "%s",', theme.cursor)

  lines[#lines + 1] = ""
  lines[#lines + 1] = "-- UI"
  lines[#lines + 1] = string.format('\tui_border = "%s",', ui.border)
  lines[#lines + 1] = string.format('\tui_title = "%s",', ui.title)
  lines[#lines + 1] = string.format('\tui_dir = "%s",', ui.dir)
  lines[#lines + 1] = string.format('\tui_cursor_line = "%s",', ui.cursor_line)
  lines[#lines + 1] = string.format('\tui_nontext = "%s",', ui.nontext)
  lines[#lines + 1] = string.format('\tui_visual_bg = "%s",', (ui.visual or {}).bg)
  lines[#lines + 1] = string.format('\tui_search_bg = "%s",', (ui.search or {}).bg)
  lines[#lines + 1] = string.format('\tui_search_fg = "%s",', (ui.search or {}).fg)
  lines[#lines + 1] = string.format('\tui_match_bg = "%s",', (ui.match or {}).bg)
  lines[#lines + 1] = string.format('\tui_match_fg = "%s",', (ui.match or {}).fg)
  lines[#lines + 1] = string.format('\tui_float_bg = "%s",', float.bg)
  lines[#lines + 1] = string.format('\tui_float_fg = "%s",', float.fg)
  lines[#lines + 1] = string.format('\tui_float_title = "%s",', float.title)
  lines[#lines + 1] = string.format('\tui_float_border = "%s",', float_border.fg)
  lines[#lines + 1] = string.format('\tui_picker_bg = "%s",', picker.bg)
  lines[#lines + 1] = string.format('\tui_picker_fg = "%s",', picker.fg)
  lines[#lines + 1] = string.format('\tui_picker_title = "%s",', picker.title)
  lines[#lines + 1] = string.format('\tui_picker_border = "%s",', picker_border.fg)

  lines[#lines + 1] = ""
  lines[#lines + 1] = "-- Diagnostic Backgrounds"
  lines[#lines + 1] = string.format('\terror_bg = "%s",', get_diag_bg(diag, "error"))
  lines[#lines + 1] = string.format('\twarning_bg = "%s",', get_diag_bg(diag, "warn"))
  lines[#lines + 1] = string.format('\tinfo_bg = "%s",', get_diag_bg(diag, "info"))
  lines[#lines + 1] = string.format('\thint_bg = "%s",', get_diag_bg(diag, "hint"))

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
    local _, variant_name, subdir = Utils.build_variant_path("extras/lua-theme", "lua", name, mode, intensity)
    local output_path = string.format("extras/lua-theme/themes/%s/oasis_%s.lua", subdir, name)

    -- is_desert lives on the dark table only; re-derive it here since `palette`
    -- may be the light variant, mirroring lua/oasis/init.lua's forwarding.
    local ok_raw, raw = pcall(require, "oasis.color_palettes.oasis_" .. name)
    local is_desert = (ok_raw and raw.dark and raw.dark.is_desert) or name:match("desert") ~= nil

    local content = generate_lua_palette(variant_name, palette, output_path, is_desert)
    File.write(output_path, content)
    print(string.format("✓ Generated: %s", output_path))
  end)

  print("\n=== Summary ===")
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

main()
