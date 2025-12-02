#!/usr/bin/env lua
-- extras/termux/generate_termux.lua
-- Generates Termux terminal themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")

local function generate_termux_theme(name, palette)
	local display_name = utils.capitalize(name)

	-- Termux uses a properties file format
	local lines = {
		"# extras/termux/oasis_" .. name .. ".properties",
		"# name: Oasis " .. display_name,
		"# author: uhs-robert",
		"",
		"background: " .. palette.bg.core,
		"foreground: " .. palette.fg.core,
		"",
		"# Normal colors",
	}

	for i = 0, 7 do
		lines[#lines + 1] = string.format("color%d:  %s", i, palette.terminal["color" .. i])
	end

	lines[#lines + 1] = ""
	lines[#lines + 1] = "# Bright colors"

	for i = 8, 15 do
		-- Note: termux properties use color8, color9, etc.
		lines[#lines + 1] = string.format("color%d: %s", i, palette.terminal["color" .. i])
	end

	lines[#lines + 1] = ""
	lines[#lines + 1] = "# Extended colors"
	lines[#lines + 1] = string.format("color16: %s", palette.ui.lineNumber)
	lines[#lines + 1] = string.format("color17: %s", palette.syntax.exception)

	return table.concat(lines, "\n")
end

local function main()
	print("\n=== Oasis Termux Theme Generator ===\n")

	local palette_names = utils.get_palette_names()

	if #palette_names == 0 then
		print("Error: No palette files found in lua/oasis/color_palettes/")
		return
	end

	print(string.format("Found %d palette(s)\n", #palette_names))

	local success_count, error_count = utils.for_each_palette_mode(function(name, palette, mode)
		-- Build variant name (append mode suffix for dual-mode palettes)
		local variant_name = mode and (name .. "_" .. mode) or name
		local output_path = string.format("extras/termux/oasis_%s.properties", variant_name)

		-- Generate and write theme
		local theme = generate_termux_theme(variant_name, palette)
		utils.write_file(output_path, theme)
		print(string.format("✓ Generated: %s", output_path))
	end)

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()

