#!/usr/bin/env lua
-- extras/lazygit/generate_lazygit.lua
-- Generates Lazygit themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")

local function generate_lazygit_theme(name, palette)
	local display_name = utils.capitalize(name)

	local lines = {
		"# extras/lazygit/oasis_" .. name .. ".yml",
		"# name: Oasis " .. display_name,
		"# author: uhs-robert",
		"",
		"theme:",
		"  activeBorderColor:",
		string.format("    - '%s'", palette.ui.lineNumber),
		"    - bold",
		"  inactiveBorderColor:",
		string.format("    - '%s'", palette.theme.primary),
		"  optionsTextColor:",
		string.format("    - '%s'", palette.terminal.yellow),
		"  selectedLineBgColor:",
		string.format("    - '%s'", palette.ui.cursorLine),
		"  cherryPickedCommitBgColor:",
		string.format("    - '%s'", palette.bg.surface),
		"  cherryPickedCommitFgColor:",
		string.format("    - '%s'", palette.theme.primary),
		"  unstagedChangesColor:",
		string.format("    - '%s'", palette.terminal.red),
		"  defaultFgColor:",
		string.format("    - '%s'", palette.fg.core),
		"  searchingActiveBorderColor:",
		string.format("    - '%s'", palette.terminal.yellow),
		"",
		"authorColors:",
		string.format("  '*': '%s'", palette.theme.secondary),
	}

	return table.concat(lines, "\n")
end

local function main()
	print("\n=== Oasis Lazygit Theme Generator ===\n")

	local palette_names = utils.get_palette_names()

	if #palette_names == 0 then
		print("Error: No palette files found in lua/oasis/color_palettes/")
		return
	end

	print(string.format("Found %d palette(s)\n", #palette_names))

	local success_count, error_count = utils.for_each_palette_mode(function(name, palette, mode)
		-- Build variant name (append mode suffix for dual-mode palettes)
		local variant_name = mode and (name .. "_" .. mode) or name
		local output_path = string.format("extras/lazygit/oasis_%s.yml", variant_name)

		-- Generate and write theme
		local theme = generate_lazygit_theme(variant_name, palette)
		utils.write_file(output_path, theme)
		print(string.format("✓ Generated: %s", output_path))
	end)

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
