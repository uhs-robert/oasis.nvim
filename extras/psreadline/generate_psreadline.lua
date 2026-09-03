#!/usr/bin/env lua
-- extras/psreadline/generate_psreadline.lua
-- Generates PSReadLine truecolor theme scripts from Oasis color palettes

package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")
local ColorUtils = require("oasis.tools.color_utils")

--- Fail loudly instead of writing a malformed file with a missing color.
--- @param value string|nil Hex color pulled from the palette
--- @param label string Token name, used in the error message
--- @return string value The verified hex color
local function require_color(value, label)
  if value == nil then error(string.format("Missing palette color for token '%s'", label)) end
  return value
end

--- @param hex string Hex color (e.g. "#RRGGBB")
--- @param mode "38"|"48" ANSI mode: 38 for foreground, 48 for background
--- @return string escape PowerShell-interpolated truecolor escape sequence
local function ansi_escape(hex, mode)
  local rgb = ColorUtils.hex_to_rgb(hex):gsub(",", ";")
  return string.format('"$esc[%s;2;%sm"', mode, rgb)
end

local function generate_psreadline_theme(variant_name, palette, output_path)
  local display_name = Utils.format_display_name(variant_name)
  -- palette.ui.visual.fg is the Neovim sentinel "none" (inherit), not a real
  -- color, so fall back to the normal foreground for selection-style tokens.
  local selection_fg = palette.fg.core

  -- stylua: ignore start
  local tokens = {
    { "Command",                require_color(palette.syntax.func, "Command") },
    { "Comment",                require_color(palette.syntax.comment, "Comment") },
    { "ContinuationPrompt",     require_color(palette.fg.muted, "ContinuationPrompt") },
    { "Default",                require_color(palette.fg.core, "Default") },
    { "Emphasis",               require_color(palette.theme.accent, "Emphasis") },
    { "Error",                  require_color(palette.ui.diag.error.fg, "Error") },
    { "InlinePrediction",       require_color(palette.fg.dim, "InlinePrediction") },
    { "Keyword",                require_color(palette.syntax.statement, "Keyword") },
    { "ListPrediction",         require_color(palette.fg.dim, "ListPrediction") },
    { "ListPredictionTooltip",  require_color(palette.fg.dim, "ListPredictionTooltip") },
    { "Member",                 require_color(palette.syntax.identifier, "Member") },
    { "Number",                 require_color(palette.syntax.constant, "Number") },
    { "Operator",               require_color(palette.syntax.operator, "Operator") },
    { "Parameter",              require_color(palette.syntax.parameter, "Parameter") },
    { "String",                 require_color(palette.syntax.string, "String") },
    { "Type",                   require_color(palette.syntax.type, "Type") },
    { "Variable",               require_color(palette.syntax.builtin_var, "Variable") },
  }
  -- stylua: ignore end

  local bg = require_color(palette.ui.visual.bg, "ListPredictionSelected/Selection background")
  local fg = require_color(selection_fg, "ListPredictionSelected/Selection foreground")
  local selected = ansi_escape(bg, "48") .. " + " .. ansi_escape(fg, "38")

  local lines = {
    "# " .. output_path,
    string.format("## name: %s", display_name),
    "## author: uhs-robert",
    "",
    "$esc = [char]0x1B",
    "",
    "Set-PSReadLineOption -Colors @{",
  }

  for _, token in ipairs(tokens) do
    lines[#lines + 1] = string.format("  %-23s = %s", token[1], ansi_escape(token[2], "38"))
  end
  lines[#lines + 1] = string.format("  %-23s = %s", "ListPredictionSelected", selected)
  lines[#lines + 1] = string.format("  %-23s = %s", "Selection", selected)
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
    local output_path, variant_name = Utils.build_variant_path("extras/psreadline", "ps1", name, mode, intensity)
    local theme = generate_psreadline_theme(variant_name, palette, output_path)
    File.write(output_path, theme)
    print(string.format("✓ Generated: %s", output_path))
  end)

  print(string.format("\n=== Summary ==="))
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

main()
