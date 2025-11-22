#!/usr/bin/env lua
-- scripts/wcag_compliance/wcag_calculator.lua
-- CLI interface for WCAG color calculator

-- Add project root to package path
local script_path = debug.getinfo(1, "S").source:sub(2)
local script_dir = script_path:match("(.*/)")
local project_root = script_dir:gsub("scripts/wcag_compliance/$", "")
package.path = project_root .. "lua/?.lua;" .. project_root .. "lua/?/init.lua;" .. package.path

-- Load the calculator
local calc = require("oasis.tools.wcag_color_calculator")

-- Available themes
local LIGHT_THEMES = {
	"oasis_dawn",
	"oasis_dawnlight",
	"oasis_day",
	"oasis_dusk",
	"oasis_dust",
}

local DARK_THEMES = {
	"oasis_desert",
	"oasis_abyss",
	"oasis_midnight",
	"oasis_night",
	"oasis_sol",
	"oasis_canyon",
	"oasis_dune",
	"oasis_mirage",
	"oasis_cactus",
	"oasis_lagoon",
	"oasis_twilight",
	"oasis_rose",
	"oasis_starlight",
}

-- Use targets from the module (edit lua/oasis/tools/wcag_color_calculator.lua to customize)
local function get_light_theme_targets()
	return calc.PRESETS.LIGHT_TARGETS
end

local function get_dark_theme_targets()
	return calc.PRESETS.DARK_TARGETS
end

-- Utility: Ensure palette name has oasis_ prefix
local function ensure_oasis_prefix(theme_name)
	if not theme_name:match("^oasis_") then
		return "oasis_" .. theme_name
	end
	return theme_name
end

local function print_usage()
	print([[
WCAG Color Calculator for Oasis Theme
Calculates AAA-compliant colors while maintaining hue and saturation.

Modes:
  Actual:  The live colors used by each theme (with auto light/dark targets)
  Presets: The preset template BASE_COLORS used to produce each theme

Usage:
  Single color:           lua wcag_calculator.lua <background_hex> <foreground_hex> [target_ratio]
  Actual:                 lua wcag_calculator.lua actual [theme_name|all]
  Presets:                lua wcag_calculator.lua presets [theme_name|all]

Examples:
  lua wcag_calculator.lua '#EFE5B6' '#D26600' 7.0
  lua wcag_calculator.lua actual lagoon
  lua wcag_calculator.lua actual all
  lua wcag_calculator.lua presets lagoon
  lua wcag_calculator.lua presets all

Commands:
  Single color mode       - Calculate WCAG compliance for one color pair
  actual [theme|all]      - Test actual colors with auto light/dark targets
  presets [theme|all]     - Test reference BASE_COLORS against all backgrounds

Custom Targets (edit lua/oasis/tools/wcag_color_calculator.lua):
  LIGHT_TARGETS - Comments: AA (4.5), Muted/Dim/Nontext: <AA, Others: AAA (7.05)
  DARK_TARGETS  - All colors use AAA (7.05) by default

Available light themes:
]])
	for _, theme in ipairs(LIGHT_THEMES) do
		print("  " .. theme)
	end
	print("\nAvailable dark themes:")
	for _, theme in ipairs(DARK_THEMES) do
		print("  " .. theme)
	end
	print()
end

local function process_single_color(background, foreground, target)
	target = target or calc.STANDARDS.AAA_NORMAL

	local current_ratio = calc.contrast_ratio(foreground, background)
	local new_color, new_ratio = calc.adjust_for_target(foreground, background, target)

	print(string.format("\nCurrent contrast: %.2f:1", current_ratio))

	if current_ratio >= target then
		print(string.format("✓ Already meets target of %.2f:1", target))
		print(string.format("\nCurrent color: %s", foreground))
		print(string.format("Target-adjusted color: %s (%.2f:1)", new_color, new_ratio))
		if foreground ~= new_color then
			print("  (Shows what exact target would be)")
		end
	else
		print(string.format("✗ Below target of %.2f:1", target))
		print(string.format("\nRecommended color: %s", new_color))
		print(string.format("New contrast: %.2f:1", new_ratio))
		print(string.format("\nChange: %s → %s", foreground, new_color))
	end
end

local function process_palette(palette_name, custom_targets)
	print(string.format("Processing %s...", palette_name))

	-- If no custom targets provided, auto-detect light/dark and apply appropriate defaults
	if not custom_targets then
		local palette, err = calc.load_palette(palette_name)
		if palette then
			custom_targets = palette.light_mode and get_light_theme_targets() or get_dark_theme_targets()
		end
	end

	calc.check_palette(palette_name, nil, custom_targets)
end

local function process_preset_single(palette_name)
	palette_name = ensure_oasis_prefix(palette_name)

	-- Load palette to determine if light or dark
	local palette, err = calc.load_palette(palette_name)
	if not palette then
		print("Error loading " .. palette_name .. ": " .. (err or "unknown error"))
		return
	end

	local color_set = palette.light_mode and calc.PRESETS.LIGHT_COLORS or calc.PRESETS.DARK_COLORS
	local results, err2, background = calc.check_preset_theme(palette_name, color_set)

	if results then
		calc.print_results(
			results,
			background,
			"WCAG AAA: Presets Calculations for `" .. palette_name .. "` (bg: `" .. background .. "`)"
		)
	else
		print("Error checking preset: " .. (err2 or "unknown error"))
	end
end

local function process_all_palettes()
	print("\n" .. string.rep("=", 80))
	print("WCAG: Compliance Check for All Actual Oasis Palettes")
	print("(Light: AA comments, AAA others | Dark: AAA all)")
	print(string.rep("=", 80))

	print("\n" .. string.rep("-", 80))
	print("LIGHT THEMES")
	print(string.rep("-", 80))
	for _, theme in ipairs(LIGHT_THEMES) do
		process_palette(theme)
	end

	print("\n" .. string.rep("-", 80))
	print("DARK THEMES")
	print(string.rep("-", 80))
	for _, theme in ipairs(DARK_THEMES) do
		process_palette(theme)
	end
end

-- Main CLI handler
local function main(...)
	local args = { ... }

	if #args == 0 then
		print_usage()
		return
	end

	if args[1] == "presets" then
		local theme_name = args[2]
		if not theme_name or theme_name == "all" then
			calc.check_all_presets()
		else
			process_preset_single(theme_name)
		end
	elseif args[1] == "actual" then
		local theme_name = args[2]
		if not theme_name or theme_name == "all" then
			process_all_palettes()
		else
			process_palette(ensure_oasis_prefix(theme_name))
		end
	elseif args[1] == "both" then
		local theme_name = args[2]
		if not theme_name or theme_name == "all" then
			calc.check_all_presets()
			process_all_palettes()
		else
			process_preset_single(theme_name)
			process_palette(ensure_oasis_prefix(theme_name))
		end
	else
		-- Single color mode
		local background = args[1]
		local foreground = args[2]
		local target = args[3] and tonumber(args[3]) or nil

		if not background or not foreground then
			print("Error: Please provide both background and foreground colors")
			print_usage()
			os.exit(1)
		end

		process_single_color(background, foreground, target)
	end
end

-- Run CLI
main(...)
