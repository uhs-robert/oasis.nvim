#!/usr/bin/env lua
-- extras/vimium-c/generate_vimiumc.lua
-- Generates Vimium-C browser extension themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")

local function get_display_name(name)
  return Utils.capitalize(name)
end

local function extract_vimiumc_colors(name, palette)
  -- For desert theme, swap primary and secondary
  local is_desert = name:match("desert") ~= nil or name:match("%..*$") and name:match("^(.+)%.") == "desert"
  local primary = is_desert and palette.theme.secondary or palette.theme.primary
  local secondary = is_desert and palette.theme.primary or palette.theme.secondary

  -- Map palette structure to Vimium-C color scheme
  return {
    bg_core = palette.bg.core,
    bg_mantle = palette.bg.mantle,
    bg_surface = palette.bg.surface,
    fg = palette.fg.core,
    fg_dim = palette.fg.muted,
    link = palette.theme.strong_primary, -- Use dim foreground for links
    border = palette.bg.mantle, -- Use mantle for borders
    primary = primary,
    light_primary = palette.theme.light_primary,
    secondary = secondary,
    title_match = palette.theme.accent, -- Use string color for matches
    link_match = secondary, -- Use secondary for link matches
  }
end

local function list_palettes()
  local palette_names = Utils.get_palette_names()
  assert(#palette_names > 0, "No palettes found")

  local light_themes = {}
  local dark_themes = {}

  for _, name in ipairs(palette_names) do
    -- Load raw palette to check if dual-mode
    local ok, raw_palette = pcall(require, "oasis.color_palettes.oasis_" .. name)
    if not ok then goto continue end

    -- Check if dual-mode palette
    if Utils.is_dual_mode_palette(raw_palette) then
      -- Add both modes to respective lists
      local dark_display = get_display_name(name) .. " (Dark)"
      local light_display = get_display_name(name) .. " (Light)"
      table.insert(dark_themes, { name = name .. ".dark", display = dark_display })
      table.insert(light_themes, { name = name .. ".light", display = light_display })
    else
      -- Legacy palette - categorize by light_mode flag
      local display_name = get_display_name(name)
      if raw_palette.light_mode then
        table.insert(light_themes, { name = name, display = display_name })
      else
        table.insert(dark_themes, { name = name, display = display_name })
      end
    end

    ::continue::
  end

  return light_themes, dark_themes
end

local function select_theme(label, themes)
  print(string.format("\n%s:", label))
  for i, theme in ipairs(themes) do
    print(string.format("  %d. %s", i, theme.display))
  end

  local alternate_label = label:match("light") and "dark" or "light"
  print(string.format("  %d. Use a %s theme instead", #themes + 1, alternate_label))

  io.write(string.format("\nSelect %s (1-%d): ", label, #themes + 1))
  local choice = tonumber(io.read())

  if not choice or choice < 1 or choice > #themes + 1 then return nil, "Invalid selection" end

  if choice > #themes then return "SWITCH_THEME_TYPE" end

  return themes[choice].name
end

local function generate_vimiumc_css(day_name, night_name, day_palette, night_palette)
  local day_colors = extract_vimiumc_colors(day_name, day_palette)
  local night_colors = extract_vimiumc_colors(night_name, night_palette)

  -- Read the CSS template
  local template = assert(File.read("./extras/vimium-c/vimium-c.css.erb"), "Missing vimium-c CSS template")

  local replacements = {
    ["{{day_name}}"] = get_display_name(day_name),
    ["{{night_name}}"] = get_display_name(night_name),
    ["{{day_bg_core}}"] = day_colors.bg_core,
    ["{{day_bg_mantle}}"] = day_colors.bg_mantle,
    ["{{day_bg_surface}}"] = day_colors.bg_surface,
    ["{{day_fg}}"] = day_colors.fg,
    ["{{day_fg_dim}}"] = day_colors.fg_dim,
    ["{{day_link}}"] = day_colors.link,
    ["{{day_border}}"] = day_colors.border,
    ["{{day_primary}}"] = day_colors.primary,
    ["{{day_light_primary}}"] = day_colors.light_primary,
    ["{{day_secondary}}"] = day_colors.secondary,
    ["{{day_title_match}}"] = day_colors.title_match,
    ["{{day_link_match}}"] = day_colors.link_match,
    ["{{night_bg_core}}"] = night_colors.bg_core,
    ["{{night_bg_mantle}}"] = night_colors.bg_mantle,
    ["{{night_bg_surface}}"] = night_colors.bg_surface,
    ["{{night_fg}}"] = night_colors.fg,
    ["{{night_link}}"] = night_colors.link,
    ["{{night_border}}"] = night_colors.border,
    ["{{night_primary}}"] = night_colors.primary,
    ["{{night_light_primary}}"] = night_colors.light_primary,
    ["{{night_secondary}}"] = night_colors.secondary,
    ["{{night_title_match}}"] = night_colors.title_match,
    ["{{night_link_match}}"] = night_colors.link_match,
  }

  local css = template
  for pattern, value in pairs(replacements) do
    css = css:gsub(pattern, value)
  end

  return css
end

local function main(args)
  if args[1] == "--list" or args[1] == "-l" then
    local light_themes, dark_themes = list_palettes()
    print("\n=== Oasis Vimium-C Themes ===")
    print("\nLight Themes:")
    for i, theme in ipairs(light_themes) do
      print(string.format("  %d. %s", i, theme.display))
    end
    print("\nDark Themes:")
    for i, theme in ipairs(dark_themes) do
      print(string.format("  %d. %s", i, theme.display))
    end
    print()
    return
  end

  if args[1] == "--help" or args[1] == "-h" then
    print([[
Oasis Vimium-C Theme Generator

Usage:
  lua extras/vimium-c/generate_vimiumc.lua [options]

Options:
  -d, --day THEME     Specify day theme (light mode)
  -n, --night THEME   Specify night theme (dark mode)
  -l, --list          List all available themes
  -h, --help          Show this help

Interactive Mode:
  Running without arguments starts interactive mode where you can
  select day and night themes from a menu.

Examples:
  lua extras/vimium-c/generate_vimiumc.lua                    # Interactive mode
  lua extras/vimium-c/generate_vimiumc.lua -d day -n lagoon   # CLI mode
  lua extras/vimium-c/generate_vimiumc.lua --list             # List themes
]])
    return
  end

  print("\n=== Oasis Vimium-C Theme Generator ===")

  local day_name, night_name

  -- Check for CLI arguments
  local i = 1
  while i <= #args do
    if args[i] == "-d" or args[i] == "--day" then
      day_name = args[i + 1]
      i = i + 2
    elseif args[i] == "-n" or args[i] == "--night" then
      night_name = args[i + 1]
      i = i + 2
    else
      i = i + 1
    end
  end

  -- Interactive mode if not specified via CLI
  if not day_name or not night_name then
    local light_themes, dark_themes = list_palettes()

    if not day_name then
      local name
      local select_err
      local is_light = true
      while not day_name do
        local themes = is_light and light_themes or dark_themes
        local label = is_light and "Day theme (light mode)" or "Day theme (dark mode)"
        name, select_err = select_theme(label, themes)
        if not name then
          print("Error: " .. select_err)
          return
        end

        if name == "SWITCH_THEME_TYPE" then
          is_light = not is_light
        else
          day_name = name
        end
      end
    end

    if not night_name then
      local name
      local select_err
      local is_dark = true
      while not night_name do
        local themes = is_dark and dark_themes or light_themes
        local label = is_dark and "Night theme (dark mode)" or "Night theme (light mode)"
        name, select_err = select_theme(label, themes)
        if not name then
          print("Error: " .. select_err)
          return
        end

        if name == "SWITCH_THEME_TYPE" then
          is_dark = not is_dark
        else
          night_name = name
        end
      end
    end
  end

  -- Load palettes (handle dual-mode suffix if present)
  local function load_palette_with_mode(name)
    -- Check if name has mode suffix (e.g., "lagoon.dark")
    local base_name, mode = name:match("^(.+)%.(.+)$")
    if base_name and (mode == "dark" or mode == "light") then
      -- Load raw palette and extract mode
      local ok, raw_palette = pcall(require, "oasis.color_palettes.oasis_" .. base_name)
      if ok and Utils.is_dual_mode_palette(raw_palette) then return raw_palette[mode] end
    end
    -- Legacy palette or no suffix - use standard loader
    return Utils.load_palette(name)
  end

  local day_palette = load_palette_with_mode(day_name)
  local night_palette = load_palette_with_mode(night_name)

  -- Strip mode suffix for display/file names (e.g., "lagoon.dark" -> "lagoon")
  local clean_day_name = day_name:match("^(.+)%..+$") or day_name
  local clean_night_name = night_name:match("^(.+)%..+$") or night_name

  -- Generate CSS
  local css = generate_vimiumc_css(clean_day_name, clean_night_name, day_palette, night_palette)

  -- Write to file
  local output_path = string.format("extras/vimium-c/output/vimiumc-%s-%s.css", clean_night_name, clean_day_name)
  File.write(output_path, css)
  print(string.format("\n✓ Generated: %s", output_path))
  print(string.format("  Day theme: Oasis %s", get_display_name(clean_day_name)))
  print(string.format("  Night theme: Oasis %s\n", get_display_name(clean_night_name)))
end

-- Run the generator
main(arg)
