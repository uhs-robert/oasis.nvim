#!/usr/bin/env lua
-- extras/gemini-cli/generate_geminicli.lua
-- Generates Gemini CLI JSON themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")
local color_utils = require("oasis.tools.color_utils")

local function generate_gemini_cli_theme(name, palette)
	local display_name = "Oasis " .. utils.capitalize(name)

	-- Terminal color mappings
	local colors = {}
	local bright_colors = {}
	local color_names = { "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }

	for i, color_name in ipairs(color_names) do
		colors[color_name] = palette.terminal["color" .. (i - 1)]
		bright_colors[color_name] = palette.terminal["color" .. (i + 7)]
	end

	-- Build JSON theme structure
	local theme = {
		name = display_name,
		type = "custom",
		Background = palette.bg.core,
		Foreground = palette.fg.core,
		LightBlue = bright_colors.blue,
		AccentBlue = colors.blue,
		AccentPurple = colors.magenta,
		AccentCyan = colors.cyan,
		AccentGreen = colors.green,
		AccentYellow = colors.yellow,
		AccentRed = colors.red,
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

	local success_count = 0
	local error_count = 0

	for _, name in ipairs(palette_names) do
		local palette = utils.load_palette(name)
		local theme = generate_gemini_cli_theme(name, palette)
		local gemini_cli_path = string.format("extras/gemini-cli/oasis_%s.json", name)
		utils.write_file(gemini_cli_path, theme)
		print(string.format("✓ Generated: %s", gemini_cli_path))
		success_count = success_count + 1
	end

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
