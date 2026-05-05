#!/usr/bin/env lua
-- extras/nless/generate_nless.lua
-- Generates nless JSON theme files from Oasis color palettes

package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")

local function generate_nless_theme(variant_name, palette)
  local is_light = palette.light_mode or false
  local is_desert = palette.is_desert or false
  local is_twilight = variant_name:find("twilight") ~= nil
  local cursor_color = is_light and palette.syntax.statement or palette.theme.cursor

  -- stylua: ignore
  local fields = {
    { "name",             "oasis-" .. variant_name:gsub("_", "-") },
    { "cursor_bg",        palette.bg.surface },
    { "cursor_fg",        (is_desert or is_twilight) and palette.theme.primary or palette.theme.secondary },
    { "header_bg",        palette.syntax.delimiter },
    { "header_fg",        palette.bg.core },
    { "fixed_column_bg",  palette.bg.surface },
    { "col_odd_fg",       palette.fg.core },
    { "col_even_fg",      palette.fg.strong },
    { "row_odd_bg",       palette.bg.mantle },
    { "row_even_bg",      palette.bg.core },
    { "scrollbar_bg",     palette.bg.core },
    { "scrollbar_fg",     (is_desert or is_twilight) and palette.theme.primary or palette.theme.secondary },
    { "search_match_bg",  palette.ui.visual.bg },
    { "search_match_fg",  palette.theme.accent },
    { "mark_bg",          palette.diff.delete },
    { "highlight",        palette.theme.secondary },
    { "accent",           palette.theme.accent },
    { "status_tailing",   palette.ui.diag.hint.fg },
    { "status_loading",   palette.ui.diag.error.fg },
    { "muted",            palette.fg.comment },
    { "border",           palette.theme.primary },
    { "brand",            palette.theme.primary },
  }
  -- stylua: on

  local lines = { "{" }
  for i, field in ipairs(fields) do
    local comma = i < #fields and "," or ""
    lines[#lines + 1] = string.format('  "%s": "%s"%s', field[1], field[2], comma)
  end
  lines[#lines + 1] = "}"

  return table.concat(lines, "\n")
end

local function main()
  print("\n=== Oasis nless Theme Generator ===\n")

  local palette_names = Utils.get_palette_names()
  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
    local output_path, variant_name = Utils.build_variant_path("extras/nless", "json", name, mode, intensity)
    local theme = generate_nless_theme(variant_name, palette)
    File.write(output_path, theme)
    print(string.format("✓ Generated: %s", output_path))
  end)

  print(string.format("\n=== Summary ==="))
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

main()
