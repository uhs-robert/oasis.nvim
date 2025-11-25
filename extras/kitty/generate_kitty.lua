#!/usr/bin/env lua
-- extras/kitty/generate_kitty.lua
-- Generates Kitty terminal themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")

local function generate_kitty_theme(name, palette)
	local display_name = utils.capitalize(name)
	local term = palette.terminal -- Each Oasis palette defines its own terminal table

	local lines = {}

	-- Header
	table.insert(lines, "# extras/kitty/oasis_" .. name .. ".conf")
	table.insert(lines, "## name: Oasis " .. display_name)
	table.insert(lines, "")

	-- Terminal palette colors (0-15)
	table.insert(lines, "# Palette")
	table.insert(lines, string.format("%-24s %s", "color0", term.color0))
	table.insert(lines, string.format("%-24s %s", "color8", term.color8))
	table.insert(lines, "")

	table.insert(lines, string.format("%-24s %s", "color1", term.color1))
	table.insert(lines, string.format("%-24s %s", "color9", term.color9))
	table.insert(lines, "")

	table.insert(lines, string.format("%-24s %s", "color2", term.color2))
	table.insert(lines, string.format("%-24s %s", "color10", term.color10))
	table.insert(lines, "")

	table.insert(lines, string.format("%-24s %s", "color3", term.color3))
	table.insert(lines, string.format("%-24s %s", "color11", term.color11))
	table.insert(lines, "")

	table.insert(lines, string.format("%-24s %s", "color4", term.color4))
	table.insert(lines, string.format("%-24s %s", "color12", term.color12))
	table.insert(lines, "")

	table.insert(lines, string.format("%-24s %s", "color5", term.color5))
	table.insert(lines, string.format("%-24s %s", "color13", term.color13))
	table.insert(lines, "")

	table.insert(lines, string.format("%-24s %s", "color6", term.color6))
	table.insert(lines, string.format("%-24s %s", "color14", term.color14))
	table.insert(lines, "")

	table.insert(lines, string.format("%-24s %s", "color7", term.color7))
	table.insert(lines, string.format("%-24s %s", "color15", term.color15))
	table.insert(lines, "")

	-- Core colors
	table.insert(lines, "# Core")
	table.insert(lines, string.format("%-24s %s", "foreground", palette.fg.core))
	table.insert(lines, string.format("%-24s %s", "background", palette.bg.core))
	table.insert(lines, "")

	-- Selection colors
	table.insert(lines, "# Selection")
	table.insert(lines, string.format("%-24s %s", "selection_background", palette.ui.visual.bg))
	table.insert(lines, string.format("%-24s %s", "selection_foreground", palette.fg.core))
	table.insert(lines, "")

	-- Cursor colors
	table.insert(lines, "# Cursor")
	table.insert(lines, string.format("%-24s %s", "cursor", term.color3)) -- Using yellow for cursor
	table.insert(lines, string.format("%-24s %s", "cursor_text_color", term.color0)) -- Using black for cursor text
	table.insert(lines, "")

	-- Border colors (panes)
	table.insert(lines, "# Borders (panes)")
	table.insert(lines, string.format("%-24s %s", "active_border_color", term.color1)) -- Using red for active
	table.insert(lines, string.format("%-24s %s", "inactive_border_color", term.color8)) -- Using bright black for inactive
	table.insert(lines, "")

	-- Tab colors
	table.insert(lines, "# Tabs")
	table.insert(lines, string.format("%-24s %s", "active_tab_foreground", term.color0)) -- Black text on...
	table.insert(lines, string.format("%-24s %s", "active_tab_background", term.color3)) -- Yellow background
	table.insert(lines, string.format("%-24s %s", "inactive_tab_foreground", palette.fg.muted)) -- Muted text
	table.insert(lines, string.format("%-24s %s", "inactive_tab_background", palette.bg.mantle)) -- Mantle background
	table.insert(lines, "")

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
			local ok, write_err = utils.write_file(kitty_path, theme)

			if ok then
				print(string.format("✓ Generated: %s", kitty_path))
				success_count = success_count + 1
			else
				print(string.format("✗ Failed to write: %s", write_err))
				error_count = error_count + 1
			end
		end
	end

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
