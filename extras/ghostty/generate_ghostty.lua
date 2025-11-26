#!/usr/bin/env lua
-- extras/ghostty/generate_ghostty.lua
-- Generates Ghostty terminal themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")

local function generate_ghostty_theme(name, palette)
	local lines = {
		"# Oasis " .. utils.capitalize(name),
		"# Author: uhs-robert",
		"",
	}

	-- Terminal palette colors (0-15)
	for i = 0, 7 do
		lines[#lines + 1] = string.format("palette = %d=%s", i, palette.terminal["color" .. i])
		lines[#lines + 1] = string.format("palette = %d=%s", i + 8, palette.terminal["color" .. (i + 8)])
		lines[#lines + 1] = ""
	end

	-- Static content
	local static = {
		"foreground = " .. palette.fg.core,
		"background = " .. palette.bg.core,
		"",
		"selection-background = " .. palette.ui.visual.bg,
		"selection-foreground = " .. palette.fg.core,
		"",
		"cursor-color = " .. palette.terminal.yellow,
		"cursor-text = " .. palette.terminal.black,
		"",
	}

	for _, line in ipairs(static) do
		lines[#lines + 1] = line
	end

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
		local palette = utils.load_palette(name)
		local theme = generate_ghostty_theme(name, palette)
		local ghostty_path = string.format("extras/ghostty/oasis_%s", name)
		utils.write_file(ghostty_path, theme)
		print(string.format("✓ Generated: %s", ghostty_path))
		success_count = success_count + 1
	end

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
