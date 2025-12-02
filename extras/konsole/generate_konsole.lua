#!/usr/bin/env lua
-- extras/konsole/generate_konsole.lua
-- Generates Konsole terminal themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")
local color_utils = require("oasis.tools.color_utils")

local function generate_konsole_theme(name, palette)
	local display_name = utils.capitalize(name)

	local lines = {
		"[Background]",
		string.format("Color=%s", color_utils.hex_to_rgb(palette.bg.core)),
		"",
		"[BackgroundFaint]",
		string.format("Color=%s", color_utils.hex_to_rgb(palette.bg.shadow)),
		"",
		"[BackgroundIntense]",
		string.format("Color=%s", color_utils.hex_to_rgb(palette.bg.surface)),
		"",
	}

	-- Generate Color0-7 with Faint and Intense variants (normal colors)
	for i = 0, 7 do
		local normal_color = palette.terminal["color" .. i]
		local intense_color = palette.terminal["color" .. (i + 8)]

		lines[#lines + 1] = string.format("[Color%d]", i)
		lines[#lines + 1] = string.format("Color=%s", color_utils.hex_to_rgb(normal_color))
		lines[#lines + 1] = ""

		lines[#lines + 1] = string.format("[Color%dFaint]", i)
		lines[#lines + 1] =
			string.format("Color=%s", color_utils.hex_to_rgb(color_utils.adjust_brightness(normal_color, 0.7))) -- TODO: Is this the right number to adjust brightness by?
		lines[#lines + 1] = ""

		lines[#lines + 1] = string.format("[Color%dIntense]", i)
		lines[#lines + 1] = string.format("Color=%s", color_utils.hex_to_rgb(intense_color))
		lines[#lines + 1] = ""
	end

	-- Foreground colors
	lines[#lines + 1] = "[Foreground]"
	lines[#lines + 1] = string.format("Color=%s", color_utils.hex_to_rgb(palette.fg.core))
	lines[#lines + 1] = ""

	lines[#lines + 1] = "[ForegroundFaint]"
	lines[#lines + 1] = string.format("Color=%s", color_utils.hex_to_rgb(palette.fg.muted))
	lines[#lines + 1] = ""

	lines[#lines + 1] = "[ForegroundIntense]"
	lines[#lines + 1] = string.format("Color=%s", color_utils.hex_to_rgb(palette.fg.strong))
	lines[#lines + 1] = ""

	-- General metadata section
	lines[#lines + 1] = "[General]"
	lines[#lines + 1] = "Blur=false"
	lines[#lines + 1] = "ColorRandomization=false"
	lines[#lines + 1] = string.format("Description=Oasis %s", display_name)
	lines[#lines + 1] = "Opacity=1"
	lines[#lines + 1] = "Wallpaper="

	return table.concat(lines, "\n")
end

local function main()
	print("\n=== Oasis Konsole Theme Generator ===\n")

	local palette_names = utils.get_palette_names()

	if #palette_names == 0 then
		print("Error: No palette files found in lua/oasis/color_palettes/")
		return
	end

	print(string.format("Found %d palette(s)\n", #palette_names))

	local success_count, error_count = utils.for_each_palette_mode(function(name, palette, mode)
		-- Build variant name (append mode suffix for dual-mode palettes)
		local variant_name = mode and (name .. "_" .. mode) or name
		local output_path = string.format("extras/konsole/oasis_%s.colorscheme", variant_name)

		-- Generate and write theme
		local theme = generate_konsole_theme(variant_name, palette)
		utils.write_file(output_path, theme)
		print(string.format("✓ Generated: %s", output_path))
	end)

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
