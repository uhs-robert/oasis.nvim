#!/usr/bin/env lua
-- extras/alacritty/generate_alacritty.lua
-- Generates Alacritty terminal themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")

local function generate_alacritty_theme(name, palette)
	local display_name = utils.capitalize(name)

	local lines = {
		"# extras/alacritty/oasis_" .. name .. ".toml",
		"## name: Oasis " .. display_name,
		"## author: uhs-robert",
		"",
		"[colors.primary]",
		string.format("background = '%s'", palette.bg.core),
		string.format("foreground = '%s'", palette.fg.core),
		"",
		"[colors.selection]",
		string.format("background = '%s'", palette.ui.visual.bg),
		string.format("text = '%s'", palette.fg.core),
		"",
		"[colors.cursor]",
		string.format("cursor = '%s'", palette.terminal.yellow),
		string.format("text = '%s'", palette.terminal.black),
		"",
		"[colors.vi_mode_cursor]",
		string.format("cursor = '%s'", palette.terminal.bright_yellow),
		string.format("text = '%s'", palette.terminal.black),
		"",
		"[colors.normal]",
		string.format("black   = '%s'", palette.terminal.black),
		string.format("red     = '%s'", palette.terminal.red),
		string.format("green   = '%s'", palette.terminal.green),
		string.format("yellow  = '%s'", palette.terminal.yellow),
		string.format("blue    = '%s'", palette.terminal.blue),
		string.format("magenta = '%s'", palette.terminal.magenta),
		string.format("cyan    = '%s'", palette.terminal.cyan),
		string.format("white   = '%s'", palette.terminal.white),
		"",
		"[colors.bright]",
		string.format("black   = '%s'", palette.terminal.bright_black),
		string.format("red     = '%s'", palette.terminal.bright_red),
		string.format("green   = '%s'", palette.terminal.bright_green),
		string.format("yellow  = '%s'", palette.terminal.bright_yellow),
		string.format("blue    = '%s'", palette.terminal.bright_blue),
		string.format("magenta = '%s'", palette.terminal.bright_magenta),
		string.format("cyan    = '%s'", palette.terminal.bright_cyan),
		string.format("white   = '%s'", palette.terminal.bright_white),
	}

	return table.concat(lines, "\n")
end

local function main()
	print("\n=== Oasis Alacritty Theme Generator ===\n")

	local palette_names = utils.get_palette_names()

	if #palette_names == 0 then
		print("Error: No palette files found in lua/oasis/color_palettes/")
		return
	end

	print(string.format("Found %d palette(s)\n", #palette_names))

	local success_count, error_count = utils.for_each_palette_mode(function(name, palette, mode)
		-- Build variant name (append mode suffix for dual-mode palettes)
		local variant_name = mode and (name .. "_" .. mode) or name
		local output_path = string.format("extras/alacritty/oasis_%s.toml", variant_name)

		-- Generate and write theme
		local theme = generate_alacritty_theme(variant_name, palette)
		utils.write_file(output_path, theme)
		print(string.format("✓ Generated: %s", output_path))
	end)

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
