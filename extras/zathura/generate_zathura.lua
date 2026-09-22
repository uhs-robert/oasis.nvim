#!/usr/bin/env lua
-- extras/zathura/generate_zathura.lua
-- Generates Zathura PDF viewer themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")

local function setting(key, value)
  return string.format('set %-28s "%s"', key, value)
end

local function generate_zathura_theme(name, palette)
  local display_name = Utils.format_display_name(name)

  local lines = {
    "# extras/zathura/oasis_" .. name .. ".zathurarc",
    "## name: " .. display_name,
    "## author: uhs-robert",
    "",
    "# Recolor: zathura maps white to lightcolor and black to darkcolor",
    "set recolor true",
    "set recolor-keephue true",
    setting("recolor-lightcolor", palette.bg.core),
    setting("recolor-darkcolor", palette.fg.core),
    "",
    "# Chrome",
    setting("default-bg", palette.bg.core),
    setting("default-fg", palette.fg.core),
    setting("statusbar-bg", palette.bg.mantle),
    setting("statusbar-fg", palette.fg.core),
    setting("inputbar-bg", palette.bg.mantle),
    setting("inputbar-fg", palette.fg.strong),
    "",
    "# Search",
    setting("highlight-color", palette.ui.search.bg),
    setting("highlight-active-color", palette.ui.match.bg),
    "",
    "# Completion",
    setting("completion-bg", palette.bg.core),
    setting("completion-fg", palette.fg.core),
    setting("completion-highlight-bg", palette.ui.visual.bg),
    setting("completion-highlight-fg", palette.fg.strong),
    setting("completion-group-bg", palette.bg.mantle),
    setting("completion-group-fg", palette.ui.title),
    "",
    "# Notifications",
    setting("notification-bg", palette.bg.mantle),
    setting("notification-fg", palette.fg.core),
    setting("notification-error-bg", palette.bg.mantle),
    setting("notification-error-fg", palette.syntax.exception),
    setting("notification-warning-bg", palette.bg.mantle),
    setting("notification-warning-fg", palette.ui.line_number),
    "",
  }

  return table.concat(lines, "\n")
end

local function main()
  print("\n=== Oasis Zathura Theme Generator ===\n")

  local palette_names = Utils.get_palette_names()

  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
    local output_path, variant_name = Utils.build_variant_path("extras/zathura", "zathurarc", name, mode, intensity)

    local theme = generate_zathura_theme(variant_name, palette)
    File.write(output_path, theme)
    print(string.format("✓ Generated: %s", output_path))
  end)

  print(string.format("\n=== Summary ==="))
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
