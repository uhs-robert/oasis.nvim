#!/usr/bin/env lua
-- extras/dark-reader/generate_darkreader.lua
-- Generates Dark Reader browser extension themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")

local function generate_darkreader_theme(name, palette)
	local display_name = utils.format_display_name(name)

	local lines = {
		"# extras/dark-reader/oasis_" .. name .. ".txt",
		"# Dark Reader theme for " .. display_name,
		"# Author: uhs-robert",
		"#",
		"# Enable the new Dark Reader design prototype (skip if already enabled)",
		"# 1. Open the Dark Reader extension",
		"# 2. Click 'More' then 'All Settings'",
		"# 3. Click 'Advanced' then 'Dev Tools'",
		"# 4. Click 'Advanced' again, then click 'Enable design prototype'",
		"# 5. Close and reopen the Dark Reader extension",
		"",
		"# Update your Dark Reader settings",
		"# 1. Open the Dark Reader extension",
		"# 2. Click 'See all options' and then click 'Colors'",
		"# 3. Set the values for each of the settings below:",
		"",
		"Background: " .. palette.bg.core,
		"Text:       " .. palette.fg.core,
		"Scrollbar:  " .. palette.bg.surface,
		"Selection:  " .. palette.ui.visual.bg,
	}

	return table.concat(lines, "\n")
end

local function main()
	print("\n=== Oasis Dark Reader Theme Generator ===\n")

	local palette_names = utils.get_palette_names()

	if #palette_names == 0 then
		print("Error: No palette files found in lua/oasis/color_palettes/")
		return
	end

	print(string.format("Found %d palette(s)\n", #palette_names))

	local success_count, error_count = utils.for_each_palette_variant(function(name, palette, mode, intensity)
		-- Build output path using shared utility
		local output_path, variant_name = utils.build_variant_path("extras/dark-reader", "txt", name, mode, intensity)

		-- Generate and write theme
		local theme = generate_darkreader_theme(variant_name, palette)
		utils.write_file(output_path, theme)
		print(string.format("✓ Generated: %s", output_path))
	end)

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
