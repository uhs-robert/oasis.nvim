#!/usr/bin/env lua
-- extras/windows-terminal/generate_windowsterminal.lua
-- Generates Windows Terminal JSON color schemes from Oasis color palettes

package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")

local function generate_windows_terminal_theme(variant_name, palette)
  local display_name = Utils.format_display_name(variant_name)
  local is_light = palette.light_mode or false
  local cursor_color = is_light and palette.syntax.statement or palette.theme.cursor

  -- stylua: ignore start
  local fields = {
    { "name",                display_name },
    { "background",          palette.bg.core },
    { "foreground",          palette.fg.core },
    { "cursorColor",         cursor_color },
    { "selectionBackground", palette.ui.visual.bg },
    { "black",               palette.terminal.black },
    { "red",                 palette.terminal.red },
    { "green",               palette.terminal.green },
    { "yellow",              palette.terminal.yellow },
    { "blue",                palette.terminal.blue },
    { "purple",              palette.terminal.magenta },
    { "cyan",                palette.terminal.cyan },
    { "white",               palette.terminal.white },
    { "brightBlack",         palette.terminal.bright_black },
    { "brightRed",           palette.terminal.bright_red },
    { "brightGreen",         palette.terminal.bright_green },
    { "brightYellow",        palette.terminal.bright_yellow },
    { "brightBlue",          palette.terminal.bright_blue },
    { "brightPurple",        palette.terminal.bright_magenta },
    { "brightCyan",          palette.terminal.bright_cyan },
    { "brightWhite",         palette.terminal.bright_white },
  }
  -- stylua: ignore end

  local lines = { "{" }
  for i, field in ipairs(fields) do
    local comma = i < #fields and "," or ""
    lines[#lines + 1] = string.format('  "%s": "%s"%s', field[1], field[2], comma)
  end
  lines[#lines + 1] = "}"

  return table.concat(lines, "\n")
end

local function main()
  print("\n=== Oasis Windows Terminal Theme Generator ===\n")

  local palette_names = Utils.get_palette_names()
  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
    local output_path, variant_name = Utils.build_variant_path("extras/windows-terminal", "json", name, mode, intensity)
    local theme = generate_windows_terminal_theme(variant_name, palette)
    File.write(output_path, theme)
    print(string.format("✓ Generated: %s", output_path))
  end)

  print(string.format("\n=== Summary ==="))
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

main()
