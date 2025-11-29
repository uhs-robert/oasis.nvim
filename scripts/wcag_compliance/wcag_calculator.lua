#!/usr/bin/env lua
-- scripts/wcag_compliance/wcag_calculator.lua
-- CLI interface for WCAG color calculator

-- Add project root to package path
local script_path = debug.getinfo(1, "S").source:sub(2)
local script_dir = script_path:match("(.*/)")
local project_root = script_dir:gsub("scripts/wcag_compliance/$", "")
package.path = project_root .. "lua/?.lua;" .. project_root .. "lua/?/init.lua;" .. package.path

-- Mock vim global for standalone execution (config.lua needs vim.deepcopy)
if not _G.vim then
	_G.vim = {
		deepcopy = function(orig)
			local orig_type = type(orig)
			local copy
			if orig_type == 'table' then
				copy = {}
				for orig_key, orig_value in next, orig, nil do
					copy[vim.deepcopy(orig_key)] = vim.deepcopy(orig_value)
				end
				setmetatable(copy, vim.deepcopy(getmetatable(orig)))
			else
				copy = orig
			end
			return copy
		end
	}
end

-- Load the calculator
local calc = require("oasis.tools.wcag_color_calculator")

-- Dynamically discover available themes from color_palettes directory
local function discover_themes()
	local light_themes = {}
	local dark_themes = {}
	local palette_dir = project_root .. "lua/oasis/color_palettes/"

	-- Get all .lua files in the palette directory (basename only)
	local handle = io.popen('ls "' .. palette_dir .. '" 2>/dev/null | grep "\\.lua$"')
	if not handle then
		print("Error: Could not read palette directory")
		return {}, {}
	end

	local result = handle:read("*a")
	handle:close()

	-- Process each file
	for filename in result:gmatch("[^\r\n]+") do
		if filename:match("%.lua$") then
			-- Extract theme name (remove .lua extension)
			local theme_name = filename:gsub("%.lua$", "")
			local success, palette = pcall(require, "oasis.color_palettes." .. theme_name)

			if success and palette then
				if palette.light_mode then
					table.insert(light_themes, theme_name)
				else
					table.insert(dark_themes, theme_name)
				end
			else
				print("Warning: Could not load palette: " .. theme_name)
			end
		end
	end

	-- Sort alphabetically for consistent output
	table.sort(light_themes)
	table.sort(dark_themes)

	return light_themes, dark_themes
end

local LIGHT_THEMES, DARK_THEMES = discover_themes()

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
  Actual:                 lua wcag_calculator.lua actual [theme_name|all] [flags]
  Presets:                lua wcag_calculator.lua presets [theme_name|all]

Flags (for 'actual' mode only):
  --themed-syntax, -t     Test with themed_syntax enabled (dark themes only)
  --both, -b              Test both normal and themed_syntax modes (dark themes only)

Examples:
  lua wcag_calculator.lua '#EFE5B6' '#D26600' 7.0
  lua wcag_calculator.lua actual lagoon
  lua wcag_calculator.lua actual lagoon --themed-syntax
  lua wcag_calculator.lua actual lagoon --both
  lua wcag_calculator.lua actual all --themed-syntax
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

local function process_palette(palette_name, custom_targets, config_opts)
	config_opts = config_opts or {}
	print(string.format("Processing %s...", palette_name))

	-- If no custom targets provided, auto-detect light/dark and apply appropriate defaults
	if not custom_targets then
		local palette, err
		if next(config_opts) then
			palette, err = calc.load_palette_with_config(palette_name, config_opts)
		else
			palette, err = calc.load_palette(palette_name)
		end
		if palette then
			custom_targets = palette.light_mode and get_light_theme_targets() or get_dark_theme_targets()
		end
	end

	-- Use config-aware check if config options provided
	if next(config_opts) then
		calc.check_palette_with_config(palette_name, config_opts, nil, custom_targets)
	else
		calc.check_palette(palette_name, nil, custom_targets)
	end
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

local function process_all_palettes(config_opts)
	config_opts = config_opts or {}
	local mode_label = config_opts.themed_syntax and " (themed_syntax)" or ""

	print("\n" .. string.rep("=", 80))
	print("WCAG: Compliance Check for All Actual Oasis Palettes" .. mode_label)
	print("(Light: AA comments, AAA others | Dark: AAA all)")
	print(string.rep("=", 80))

	print("\n" .. string.rep("-", 80))
	print("LIGHT THEMES")
	print(string.rep("-", 80))
	for _, theme in ipairs(LIGHT_THEMES) do
		process_palette(theme, nil, config_opts)
	end

	print("\n" .. string.rep("-", 80))
	print("DARK THEMES")
	print(string.rep("-", 80))
	for _, theme in ipairs(DARK_THEMES) do
		process_palette(theme, nil, config_opts)
	end
end

-- Parse flags from arguments
local function parse_flags(args)
	local flags = {
		themed_syntax = false,
		both = false,
	}

	for _, arg in ipairs(args) do
		if arg == "--themed-syntax" or arg == "-t" then
			flags.themed_syntax = true
		elseif arg == "--both" or arg == "-b" then
			flags.both = true
		end
	end

	return flags
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
		local flags = parse_flags(args)
		local theme_name = args[2]

		-- Handle flags: theme name might be in args[2] or later if flags come first
		if theme_name and (theme_name:match("^%-") or theme_name == "all") then
			-- args[2] is a flag or "all"
			if theme_name == "all" then
				if flags.both then
					-- Run both normal and themed_syntax
					process_all_palettes({})
					process_all_palettes({ themed_syntax = true })
				elseif flags.themed_syntax then
					process_all_palettes({ themed_syntax = true })
				else
					process_all_palettes({})
				end
			else
				-- No theme specified, check args[3] for "all"
				if args[3] == "all" then
					if flags.both then
						process_all_palettes({})
						process_all_palettes({ themed_syntax = true })
					elseif flags.themed_syntax then
						process_all_palettes({ themed_syntax = true })
					else
						process_all_palettes({})
					end
				else
					process_all_palettes({})
				end
			end
		elseif not theme_name then
			-- No theme specified, default to all
			if flags.both then
				process_all_palettes({})
				process_all_palettes({ themed_syntax = true })
			elseif flags.themed_syntax then
				process_all_palettes({ themed_syntax = true })
			else
				process_all_palettes({})
			end
		else
			-- Specific theme
			local palette_name = ensure_oasis_prefix(theme_name)
			if flags.both then
				-- Run both normal and themed_syntax
				process_palette(palette_name, nil, {})
				process_palette(palette_name, nil, { themed_syntax = true })
			elseif flags.themed_syntax then
				process_palette(palette_name, nil, { themed_syntax = true })
			else
				process_palette(palette_name, nil, {})
			end
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
