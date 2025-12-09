#!/usr/bin/env lua
-- extras/gemini-cli/generate_geminicli.lua
-- Generates Gemini CLI JSON themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")
local File = require("oasis.lib.file")
local color_utils = require("oasis.tools.color_utils")

local function generate_gemini_cli_theme(name, palette)
	local display_name = utils.format_display_name(name)

	-- Build JSON theme structure
	local theme = {
		name = display_name,
		type = "custom",
		Background = palette.bg.core,
		Foreground = palette.fg.core,
		LightBlue = palette.terminal.bright_blue,
		AccentBlue = palette.terminal.blue,
		AccentPurple = palette.terminal.magenta,
		AccentCyan = palette.terminal.cyan,
		AccentGreen = palette.terminal.green,
		AccentYellow = palette.terminal.yellow,
		AccentRed = palette.terminal.red,
		Comment = palette.syntax.comment,
		Gray = palette.fg.muted,
		DiffAdded = palette.diff.add,
		DiffRemoved = palette.diff.delete,
		DiffModified = palette.diff.change,
		GradientColors = {
			palette.theme.primary,
			palette.theme.accent,
			palette.theme.secondary,
		},
	}

	return color_utils.encode_json(theme, 2)
end

local function main()
	print("\n=== Oasis Gemini CLI Theme Generator ===\n")

	local palette_names = utils.get_palette_names()

	if #palette_names == 0 then
		print("Error: No palette files found in lua/oasis/color_palettes/")
		return
	end

	print(string.format("Found %d palette(s)\n", #palette_names))

	local success_count, error_count = utils.for_each_palette_variant(function(name, palette, mode, intensity)
		-- Build output path using shared utility
		local output_path, variant_name = utils.build_variant_path("extras/gemini-cli", "json", name, mode, intensity)

		-- Generate and write theme
		local theme = generate_gemini_cli_theme(variant_name, palette)
		File.write(output_path, theme)
		print(string.format("✓ Generated: %s", output_path))
	end)

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
