#!/usr/bin/env lua
-- extras/wezterm/generate_wezterm.lua
-- Generates Wezterm terminal themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")

local function generate_wezterm_theme(name, palette)
  local display_name = Utils.format_display_name(name)
  local is_light = palette.light_mode or false

  local lines = {
    "# extras/wezterm/oasis_" .. name .. ".toml",
    "## name: " .. display_name,
    "## author: uhs-robert",
    "",
    "[colors]",
    'foreground = "' .. palette.fg.core .. '"',
    'background= "' .. palette.bg.core .. '"',
    string.format('cursor_bg = "%s"', is_light and palette.syntax.statement or palette.terminal.yellow),
    string.format('cursor_border = "%s"', is_light and palette.syntax.statement or palette.terminal.yellow),
    'cursor_fg= "' .. palette.bg.core .. '"',
    'selection_bg= "' .. palette.ui.search.bg .. '"',
    'selection_fg= "' .. palette.ui.search.fg .. '"',
    'split= "' .. palette.ui.border .. '"',
    'compose_cursor= "' .. palette.ui.lineNumber .. '"',
    'scrollbar_thumb= "' .. palette.bg.surface .. '"',
    'visual_bell= "' .. palette.bg.mantle .. '"',
    "",
  }

  -- Ansi
  lines[#lines + 1] = "ansi = ["
  for i = 0, 7 do
    lines[#lines + 1] = string.format("  '%s',", palette.terminal["color" .. i])
  end
  lines[#lines + 1] = "]"
  lines[#lines + 1] = ""

  -- Brights
  lines[#lines + 1] = "brights = ["
  for i = 0, 7 do
    lines[#lines + 1] = string.format("  '%s',", palette.terminal["color" .. (i + 8)])
  end
  lines[#lines + 1] = "]"
  lines[#lines + 1] = ""

  -- Colors Indexed
  lines[#lines + 1] = "[colors.indexed]"
  lines[#lines + 1] = string.format("16 = '%s'", palette.ui.lineNumber)
  lines[#lines + 1] = string.format("17 = '%s'", palette.syntax.exception)
  lines[#lines + 1] = ""

  -- Tab Bar
  lines[#lines + 1] = "[colors.tab_bar]"
  lines[#lines + 1] = string.format("background = '%s'", palette.bg.mantle)
  lines[#lines + 1] = string.format("inactive_tab_edge = '%s'", palette.bg.shadow)
  lines[#lines + 1] = ""

  -- Tab Bar Active Tab
  lines[#lines + 1] = "[colors.tab_bar.active_tab]"
  lines[#lines + 1] = string.format("bg_color = '%s'", palette.theme.primary)
  lines[#lines + 1] = string.format("fg_color = '%s'", palette.bg.core)
  lines[#lines + 1] = "intensity = 'Normal'"
  lines[#lines + 1] = "italic = false"
  lines[#lines + 1] = "strikethrough = false"
  lines[#lines + 1] = "underline = 'None'"
  lines[#lines + 1] = ""

  -- Tab Bar Inactive Tab
  lines[#lines + 1] = "[colors.tab_bar.inactive_tab]"
  lines[#lines + 1] = string.format("bg_color = '%s'", palette.bg.surface)
  lines[#lines + 1] = string.format("fg_color = '%s'", palette.theme.primary)
  lines[#lines + 1] = "intensity = 'Normal'"
  lines[#lines + 1] = "italic = false"
  lines[#lines + 1] = "strikethrough = false"
  lines[#lines + 1] = "underline = 'None'"
  lines[#lines + 1] = ""

  -- Tab Bar Inactive Tab Hover
  lines[#lines + 1] = "[colors.tab_bar.inactive_tab_hover]"
  lines[#lines + 1] = string.format("bg_color = '%s'", palette.bg.surface)
  lines[#lines + 1] = string.format("fg_color = '%s'", palette.theme.secondary)
  lines[#lines + 1] = "intensity = 'Normal'"
  lines[#lines + 1] = "italic = false"
  lines[#lines + 1] = "strikethrough = false"
  lines[#lines + 1] = "underline = 'None'"
  lines[#lines + 1] = ""

  -- Tab Bar New Tab
  lines[#lines + 1] = "[colors.tab_bar.new_tab]"
  lines[#lines + 1] = string.format("bg_color = '%s'", palette.theme.secondary)
  lines[#lines + 1] = string.format("fg_color = '%s'", palette.bg.core)
  lines[#lines + 1] = "intensity = 'Normal'"
  lines[#lines + 1] = "italic = false"
  lines[#lines + 1] = "strikethrough = false"
  lines[#lines + 1] = "underline = 'None'"
  lines[#lines + 1] = ""

  -- Tab Bar New Tab Hover
  lines[#lines + 1] = "[colors.tab_bar.new_tab_hover]"
  lines[#lines + 1] = string.format("bg_color = '%s'", palette.theme.accent)
  lines[#lines + 1] = string.format("fg_color = '%s'", palette.bg.core)
  lines[#lines + 1] = "intensity = 'Normal'"
  lines[#lines + 1] = "italic = false"
  lines[#lines + 1] = "strikethrough = false"
  lines[#lines + 1] = "underline = 'None'"
  lines[#lines + 1] = ""

  -- Metadata
  lines[#lines + 1] = "[metadata]"
  lines[#lines + 1] = "aliases = []"
  lines[#lines + 1] = "author = 'uhs-robert'"
  lines[#lines + 1] = string.format("name = '%s'", display_name)

  return table.concat(lines, "\n")
end

local function main()
  print("\n=== Oasis Wezterm Theme Generator ===\n")

  local palette_names = Utils.get_palette_names()

  if #palette_names == 0 then
    print("Error: No palette files found in lua/oasis/color_palettes/")
    return
  end

  print(string.format("Found %d palette(s)\n", #palette_names))

  local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
    local output_path, variant_name = Utils.build_variant_path("extras/wezterm", "toml", name, mode, intensity)

    -- Generate and write theme
    local theme = generate_wezterm_theme(variant_name, palette)
    File.write(output_path, theme)
    print(string.format("✓ Generated: %s", output_path))
  end)

  print(string.format("\n=== Summary ==="))
  print(string.format("Success: %d", success_count))
  print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
