#!/usr/bin/env lua
-- extras/ghostty/generate_ghostty.lua
-- Generates Ghostty terminal themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")

local function generate_ghostty_theme(name, palette)
	local term = palette.terminal -- Each Oasis palette defines its own terminal table

	local lines = {}

	-- Terminal palette colors (0-15)
	table.insert(lines, "palette = 0=" .. term.color0)
	table.insert(lines, "palette = 8=" .. term.color8)
	table.insert(lines, "")

	table.insert(lines, "palette = 1=" .. term.color1)
	table.insert(lines, "palette = 9=" .. term.color9)
	table.insert(lines, "")

	table.insert(lines, "palette = 2=" .. term.color2)
	table.insert(lines, "palette = 10=" .. term.color10)
	table.insert(lines, "")

	table.insert(lines, "palette = 3=" .. term.color3)
	table.insert(lines, "palette = 11=" .. term.color11)
	table.insert(lines, "")

	table.insert(lines, "palette = 4=" .. term.color4)
	table.insert(lines, "palette = 12=" .. term.color12)
	table.insert(lines, "")

	table.insert(lines, "palette = 5=" .. term.color5)
	table.insert(lines, "palette = 13=" .. term.color13)
	table.insert(lines, "")

	table.insert(lines, "palette = 6=" .. term.color6)
	table.insert(lines, "palette = 14=" .. term.color14)
	table.insert(lines, "")

	table.insert(lines, "palette = 7=" .. term.color7)
	table.insert(lines, "palette = 15=" .. term.color15)
	table.insert(lines, "")

	-- Core colors
	table.insert(lines, "foreground = " .. palette.fg.core)
	table.insert(lines, "background = " .. palette.bg.core)
	table.insert(lines, "")

	-- Selection colors
	table.insert(lines, "selection-background = " .. palette.ui.visual.bg)
	table.insert(lines, "selection-foreground = " .. palette.fg.core)
	table.insert(lines, "")

	-- Cursor colors
	table.insert(lines, "cursor-color = " .. term.color3) -- Using yellow for cursor
	table.insert(lines, "cursor-text = " .. term.color0) -- Using black for cursor text
	table.insert(lines, "")

	return table.concat(lines, "\n")
end

local function main()
	print("\n=== Oasis Ghostty Theme Generator ===\n")

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
			local theme = generate_ghostty_theme(name, palette)
			local ghostty_path = string.format("extras/ghostty/oasis_%s", name)
			local ok, write_err = utils.write_file(ghostty_path, theme)

			if ok then
				print(string.format("✓ Generated: %s", ghostty_path))
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
