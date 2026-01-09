#!/usr/bin/env lua
-- extras/lazygit/generate_lazygit.lua
-- Generates Lazygit themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")

local function generate_lazygit_theme(name, palette)
  -- For desert theme, swap primary and secondary
  local is_desert = name:match("desert") ~= nil
  local primary = is_desert and palette.theme.secondary or palette.theme.primary
  local secondary = is_desert and palette.theme.primary or palette.theme.secondary

  local display_name = Utils.format_display_name(name)

  local lines = {
    "# extras/lazygit/oasis_" .. name .. ".yml",
    "# name: " .. display_name,
    "# author: uhs-robert",
    "",
    "theme:",
    "  activeBorderColor:",
    string.format("    - '%s'", palette.ui.lineNumber),
    "    - bold",
    "  inactiveBorderColor:",
    string.format("    - '%s'", primary),
    "  optionsTextColor:",
    string.format("    - '%s'", palette.terminal.yellow),
    "  selectedLineBgColor:",
    string.format("    - '%s'", palette.ui.cursorLine),
    "  cherryPickedCommitBgColor:",
    string.format("    - '%s'", palette.bg.surface),
    "  cherryPickedCommitFgColor:",
    string.format("    - '%s'", primary),
    "  unstagedChangesColor:",
    string.format("    - '%s'", palette.terminal.red),
    "  defaultFgColor:",
    string.format("    - '%s'", palette.fg.core),
    "  searchingActiveBorderColor:",
    string.format("    - '%s'", palette.terminal.yellow),
    "",
    "authorColors:",
    string.format("  '*': '%s'", secondary),
  }

  return table.concat(lines, "\n")
end

local function main()
  print("\n=== Oasis Lazygit Theme Generator ===\n")

  local palette_names = Utils.get_palette_names()

  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
    -- Build output path using shared utility
    local output_path, variant_name = Utils.build_variant_path("extras/lazygit", "yml", name, mode, intensity)

    -- Generate and write theme
    local theme = generate_lazygit_theme(variant_name, palette)
    File.write(output_path, theme)
    print(string.format("✓ Generated: %s", output_path))
  end)

  print(string.format("\n=== Summary ==="))
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
