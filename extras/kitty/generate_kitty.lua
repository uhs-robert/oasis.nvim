#!/usr/bin/env lua
-- extras/kitty/generate_kitty.lua
-- Generates Kitty terminal themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")

local function generate_kitty_theme(name, palette)
	local display_name = utils.capitalize(name)

	local lines = {
		"# extras/kitty/oasis_" .. name .. ".conf",
		"## name: Oasis " .. display_name,
		"## author: uhs-robert",
		"",
		"# Palette",
	}

	-- Terminal palette colors (0-15)
	for i = 0, 7 do
		lines[#lines + 1] = string.format("%-24s %s", "color" .. i, palette.terminal["color" .. i])
		lines[#lines + 1] = string.format("%-24s %s", "color" .. (i + 8), palette.terminal["color" .. (i + 8)])
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
		string.format("%-24s %s", "cursor", palette.terminal.yellow),
		string.format("%-24s %s", "cursor_text_color", palette.terminal.black),
		"",
		"# Borders (panes)",
		string.format("%-24s %s", "active_border_color", palette.terminal.red),
		string.format("%-24s %s", "inactive_border_color", palette.terminal.bright_black),
		"",
		"# Tabs",
		string.format("%-24s %s", "active_tab_foreground", palette.terminal.black),
		string.format("%-24s %s", "active_tab_background", palette.terminal.yellow),
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

	local success_count, error_count = utils.for_each_palette_mode(function(name, palette, mode)
		-- Build variant name (append mode suffix for dual-mode palettes)
		local variant_name = mode and (name .. "_" .. mode) or name
		local output_path = string.format("extras/kitty/oasis_%s.conf", variant_name)

		-- Generate and write theme
		local theme = generate_kitty_theme(variant_name, palette)
		utils.write_file(output_path, theme)
		print(string.format("✓ Generated: %s", output_path))
	end)

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
