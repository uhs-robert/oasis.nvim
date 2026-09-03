#!/usr/bin/env lua
-- extras/psreadline/generate_psreadline.lua
-- Generates PSReadLine color config scripts from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")
local ColorUtils = require("oasis.tools.color_utils")

local function ansi(hex)
  local rgb = ColorUtils.hex_to_rgb(hex):gsub(",", ";")
  return "`e[38;2;" .. rgb .. "m"
end

-- PSReadLine's own defaults render Comment/InlinePrediction in italic
local function ansi_italic(hex)
  local rgb = ColorUtils.hex_to_rgb(hex):gsub(",", ";")
  return "`e[3;38;2;" .. rgb .. "m"
end

local REVERSE_VIDEO = "`e[7m"

local function generate_psreadline_theme(name, palette)
  local display_name = Utils.format_display_name(name)

  -- stylua: ignore
  local fields = {
    { "Command",                  ansi(palette.syntax.statement) },
    { "Comment",                  ansi_italic(palette.syntax.comment) },
    { "ContinuationPrompt",       ansi(palette.fg.muted) },
    { "Default",                  ansi(palette.fg.core) },
    { "Emphasis",                 ansi(palette.theme.accent) },
    { "Error",                    ansi(palette.ui.diag.error.fg) },
    { "InlinePrediction",         ansi_italic(palette.fg.dim) },
    { "Keyword",                  ansi(palette.syntax.conditional) },
    { "ListPrediction",           ansi(palette.theme.secondary) },
    { "ListPredictionSelected",   REVERSE_VIDEO },
    { "ListPredictionTooltip",    ansi(palette.fg.muted) },
    { "Member",                   ansi(palette.syntax.func) },
    { "Number",                   ansi(palette.syntax.constant) },
    { "Operator",                 ansi(palette.syntax.operator) },
    { "Parameter",                ansi(palette.syntax.parameter) },
    { "Selection",                REVERSE_VIDEO },
    { "String",                   ansi(palette.syntax.string) },
    { "Type",                     ansi(palette.syntax.type) },
    { "Variable",                 ansi(palette.syntax.identifier) },
  }
  -- stylua: on

  local lines = {
    "# extras/psreadline/themes/.../oasis_" .. name .. ".ps1",
    "# name: " .. display_name,
    "# author: uhs-robert",
    "",
    "Set-PSReadLineOption -Colors @{",
  }

  for _, field in ipairs(fields) do
    lines[#lines + 1] = string.format('    %s = "%s"', field[1], field[2])
  end

  lines[#lines + 1] = "}"

  return table.concat(lines, "\n")
end

local function main()
  print("\n=== Oasis PSReadLine Theme Generator ===\n")

  local palette_names = Utils.get_palette_names()

  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
    -- Build output path using shared utility
    local output_path, variant_name = Utils.build_variant_path("extras/psreadline", "ps1", name, mode, intensity)

    -- Generate and write theme
    local theme = generate_psreadline_theme(variant_name, palette)
    File.write(output_path, theme)
    print(string.format("✓ Generated: %s", output_path))
  end)

  print(string.format("\n=== Summary ==="))
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
