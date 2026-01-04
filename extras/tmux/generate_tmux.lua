#!/usr/bin/env lua
-- extras/tmux/generate_tmux.lua
-- Generates TMUX themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")

local function generate_tmux_theme(name, palette)
  local display_name = Utils.format_display_name(name)

  local lines = {
    "# vim:set ft=tmux:",
    "## name: " .. display_name,
    "## author: uhs-robert",
    "",
    "# Main",
    string.format('set -ogq @thm_strong_primary "%s"', string.lower(palette.theme.strong_primary)),
    string.format('set -ogq @thm_primary "%s"', string.lower(palette.theme.primary)),
    string.format('set -ogq @thm_light_primary "%s"', string.lower(palette.theme.light_primary)),
    string.format('set -ogq @thm_secondary "%s"', string.lower(palette.theme.secondary)),
    string.format('set -ogq @thm_prefix "%s"', string.lower(palette.theme.accent)),
    string.format('set -ogq @thm_fg "%s"', string.lower(palette.fg.core)),
    "",
    "# Surfaces and overlays",
    string.format('set -ogq @thm_core "%s"', string.lower(palette.bg.core)),
    string.format('set -ogq @thm_mantle "%s"', string.lower(palette.bg.mantle)),
    string.format('set -ogq @thm_surface "%s"', string.lower(palette.bg.surface)),
    "",
    "# General",
    string.format('set -ogq @thm_red "%s"', string.lower(palette.terminal.red)),
    string.format('set -ogq @thm_orange "%s"', string.lower(palette.terminal.bright_yellow)),
    string.format('set -ogq @thm_yellow "%s"', string.lower(palette.terminal.yellow)),
    string.format('set -ogq @thm_green "%s"', string.lower(palette.syntax.string)),
    string.format('set -ogq @thm_teal "%s"', string.lower(palette.terminal.bright_cyan)),
    string.format('set -ogq @thm_blue "%s"', string.lower(palette.terminal.blue)),
    string.format('set -ogq @thm_indigo "%s"', string.lower(palette.terminal.magenta)),
    "",
  }

  return table.concat(lines, "\n")
end

local function main()
  print("\n=== Oasis TMUX Theme Generator ===\n")

  local palette_names = Utils.get_palette_names()

  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
    -- Build output path using shared utility
    local output_path, variant_name = Utils.build_variant_path("extras/tmux", "conf", name, mode, intensity)

    -- Generate and write theme
    local theme = generate_tmux_theme(variant_name, palette)
    File.write(output_path, theme)
    print(string.format("✓ Generated: %s", output_path))
  end)

  print(string.format("\n=== Summary ==="))
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
