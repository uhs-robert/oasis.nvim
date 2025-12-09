#!/usr/bin/env lua
-- extras/btop/generate_btop.lua
-- Generates Btop terminal themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")
local File = require("oasis.lib.file")

local function generate_btop_theme(name, palette)
	local display_name = utils.format_display_name(name)

	local lines = {
		"# extras/btop/oasis_" .. name .. ".theme",
		"# Btop theme for " .. display_name,
		"# Author: uhs-robert",
		"",
		"# Main background, empty for terminal default, need to be empty if you want transparent background",
		string.format('theme[main_bg]="%s"', palette.bg.core),
		"",
		"# Main text color",
		string.format('theme[main_fg]="%s"', palette.fg.core),
		"",
		"# Title color for boxes",
		string.format('theme[title]="%s"', palette.fg.core),
		"",
		"# Highlight color for keyboard shortcuts",
		string.format('theme[hi_fg]="%s"', palette.theme.primary),
		"",
		"# Background color of selected item in processes box",
		string.format('theme[selected_bg]="%s"', palette.bg.surface),
		"",
		"# Foreground color of selected item in processes box",
		string.format('theme[selected_fg]="%s"', palette.theme.primary),
		"",
		"# Color of inactive/disabled text",
		string.format('theme[inactive_fg]="%s"', palette.fg.muted),
		"",
		"# Color of text appearing on top of graphs, i.e uptime and current network graph scaling",
		string.format('theme[graph_text]="%s"', palette.fg.strong),
		"",
		"# Background color of the percentage meters",
		string.format('theme[meter_bg]="%s"', palette.bg.mantle),
		"",
		"# Misc colors for processes box including mini cpu graphs, details memory graph and details status text",
		string.format('theme[proc_misc]="%s"', palette.fg.strong),
		"",
		"# CPU, Memory, Network, Proc box outline colors",
		string.format('theme[cpu_box]="%s"', palette.terminal.green),
		string.format('theme[mem_box]="%s"', palette.terminal.yellow),
		string.format('theme[net_box]="%s"', palette.terminal.magenta),
		string.format('theme[proc_box]="%s"', palette.terminal.red),
		"",
		"# Box divider line and small boxes line color",
		string.format('theme[div_line]="%s"', palette.bg.surface),
		"",
		"# Temperature graph color (Blue -> Bright Blue -> Magenta)",
		string.format('theme[temp_start]="%s"', palette.terminal.blue),
		string.format('theme[temp_mid]="%s"', palette.terminal.bright_blue),
		string.format('theme[temp_end]="%s"', palette.terminal.bright_magenta),
		"",
		"# CPU graph colors (Green -> Orange -> Bright Red)",
		string.format('theme[cpu_start]="%s"', palette.terminal.green),
		string.format('theme[cpu_mid]="%s"', palette.terminal.bright_yellow),
		string.format('theme[cpu_end]="%s"', palette.terminal.bright_red),
		"",
		"# Mem/Disk used meter (Bright Red -> Red)",
		string.format('theme[used_start]="%s"', palette.terminal.bright_red),
		'theme[used_mid]=""',
		string.format('theme[used_end]="%s"', palette.terminal.red),
		"",
		"# Mem/Disk available meter (Yellow ->  orange)",
		string.format('theme[available_start]="%s"', palette.terminal.yellow),
		'theme[available_mid]=""',
		string.format('theme[available_end]="%s"', palette.terminal.bright_yellow),
		"",
		"# Mem/Disk cached meter (Blue -> Bright Blue)",
		string.format('theme[cached_start]="%s"', palette.terminal.blue),
		'theme[cached_mid]=""',
		string.format('theme[cached_end]="%s"', palette.terminal.bright_blue),
		"",
		"# Mem/Disk free meter (Green -> Bright Green)",
		string.format('theme[free_start]="%s"', palette.terminal.green),
		'theme[free_mid]=""',
		string.format('theme[free_end]="%s"', palette.terminal.bright_green),
		"",
		"# Download graph colors (Blue -> Bright Blue)",
		string.format('theme[download_start]="%s"', palette.terminal.blue),
		'theme[download_mid]=""',
		string.format('theme[download_end]="%s"', palette.terminal.bright_blue),
		"",
		"# Upload graph colors (Magenta -> Bright Magenta)",
		string.format('theme[upload_start]="%s"', palette.terminal.magenta),
		'theme[upload_mid]=""',
		string.format('theme[upload_end]="%s"', palette.terminal.bright_magenta),
		"",
		"# Process box color gradient for threads, mem and cpu usage (Green -> Orange -> Red)",
		string.format('theme[process_start]="%s"', palette.terminal.green),
		string.format('theme[process_mid]="%s"', palette.terminal.bright_yellow),
		string.format('theme[process_end]="%s"', palette.terminal.red),
	}

	return table.concat(lines, "\n")
end

local function main()
	print("\n=== Oasis Btop Theme Generator ===\n")

	local palette_names = utils.get_palette_names()

	if #palette_names == 0 then
		print("Error: No palette files found in lua/oasis/color_palettes/")
		return
	end

	print(string.format("Found %d palette(s)\n", #palette_names))

	local success_count, error_count = utils.for_each_palette_variant(function(name, palette, mode, intensity)
		-- Build output path using shared utility
		local output_path, variant_name = utils.build_variant_path("extras/btop", "theme", name, mode, intensity)

		-- Generate and write theme
		local theme = generate_btop_theme(variant_name, palette)
		File.write(output_path, theme)
		print(string.format("✓ Generated: %s", output_path))
	end)

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
