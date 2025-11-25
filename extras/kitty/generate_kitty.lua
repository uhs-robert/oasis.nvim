#!/usr/bin/env lua
-- extras/kitty/generate_kitty.lua
-- Generates Kitty terminal themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")

local function generate_kitty_theme(name, palette)
	local display_name = utils.capitalize(name)
	local term = palette.terminal -- Each Oasis palette defines its own terminal table

	local lines = {
		"# extras/kitty/oasis_" .. name .. ".conf",
		"## name: Oasis " .. display_name,
		"## author: uhs-robert",
		"",
		"# Palette",
	}

	-- Terminal palette colors (0-15)
	for i = 0, 7 do
		lines[#lines + 1] = string.format("%-24s %s", "color" .. i, term["color" .. i])
		lines[#lines + 1] = string.format("%-24s %s", "color" .. (i + 8), term["color" .. (i + 8)])
		lines[#lines + 1] = ""
	end

	-- Static content
	local static = {
		"# Core",
		string.format("%-24s %s", "foreground", palette.fg.core),
		string.format("%-24s %s", "background", palette.bg.core),
		"",
		"# Selection",
		string.format("%-24s %s", "selection_background", palette.ui.visual.bg),
		string.format("%-24s %s", "selection_foreground", palette.fg.core),
		"",
		"# Cursor",
		string.format("%-24s %s", "cursor", term.color3),
		string.format("%-24s %s", "cursor_text_color", term.color0),
		"",
		"# Borders (panes)",
		string.format("%-24s %s", "active_border_color", term.color1),
		string.format("%-24s %s", "inactive_border_color", term.color8),
		"",
		"# Tabs",
		string.format("%-24s %s", "active_tab_foreground", term.color0),
		string.format("%-24s %s", "active_tab_background", term.color3),
		string.format("%-24s %s", "inactive_tab_foreground", palette.fg.muted),
		string.format("%-24s %s", "inactive_tab_background", palette.bg.mantle),
		"",
	}

	for _, line in ipairs(static) do
		lines[#lines + 1] = line
	end

	return table.concat(lines, "\n")
end

local function main()
	print("\n=== Oasis Kitty Theme Generator ===\n")

	local palette_names = utils.get_palette_names()

	if #palette_names == 0 then
		print("Error: No palette files found in lua/oasis/color_palettes/")
		return
	end

	print(string.format("Found %d palette(s)\n", #palette_names))

	local success_count = 0
	local error_count = 0

	for _, name in ipairs(palette_names) do
		local palette, err = utils.load_palette(name)

		if not palette then
			print(string.format("✗ Failed to load %s: %s", name, err))
			error_count = error_count + 1
		else
			local theme = generate_kitty_theme(name, palette)
			local kitty_path = string.format("extras/kitty/oasis_%s.conf", name)
			utils.write_file(kitty_path, theme)
			print(string.format("✓ Generated: %s", kitty_path))
			success_count = success_count + 1
		end
	end

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
