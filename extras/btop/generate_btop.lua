#!/usr/bin/env lua
-- extras/btop/generate_btop.lua
-- Generates Btop terminal themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")

local function generate_btop_theme(name, palette)
	local display_name = utils.capitalize(name)

	-- Terminal color mappings
	local colors = {}
	local bright_colors = {}
	local color_names = { "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white" }

	for i, color_name in ipairs(color_names) do
		colors[color_name] = palette.terminal["color" .. (i - 1)]
		bright_colors[color_name] = palette.terminal["color" .. (i + 7)]
	end

	local lines = {
		"# extras/btop/oasis_" .. name .. ".theme",
		"# Btop theme for Oasis " .. display_name,
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
		string.format('theme[cpu_box]="%s"', colors.green),
		string.format('theme[mem_box]="%s"', colors.yellow),
		string.format('theme[net_box]="%s"', colors.magenta),
		string.format('theme[proc_box]="%s"', colors.red),
		"",
		"# Box divider line and small boxes line color",
		string.format('theme[div_line]="%s"', palette.bg.surface),
		"",
		"# Temperature graph color (Blue -> Bright Blue -> Magenta)",
		string.format('theme[temp_start]="%s"', colors.blue),
		string.format('theme[temp_mid]="%s"', bright_colors.blue),
		string.format('theme[temp_end]="%s"', bright_colors.magenta),
		"",
		"# CPU graph colors (Green -> Orange -> Bright Red)",
		string.format('theme[cpu_start]="%s"', colors.green),
		string.format('theme[cpu_mid]="%s"', bright_colors.yellow),
		string.format('theme[cpu_end]="%s"', bright_colors.red),
		"",
		"# Mem/Disk used meter (Bright Red -> Red)",
		string.format('theme[used_start]="%s"', bright_colors.red),
		'theme[used_mid]=""',
		string.format('theme[used_end]="%s"', colors.red),
		"",
		"# Mem/Disk available meter (Yellow ->  orange)",
		string.format('theme[available_start]="%s"', colors.yellow),
		'theme[available_mid]=""',
		string.format('theme[available_end]="%s"', bright_colors.yellow),
		"",
		"# Mem/Disk cached meter (Blue -> Bright Blue)",
		string.format('theme[cached_start]="%s"', colors.blue),
		'theme[cached_mid]=""',
		string.format('theme[cached_end]="%s"', bright_colors.blue),
		"",
		"# Mem/Disk free meter (Green -> Bright Green)",
		string.format('theme[free_start]="%s"', colors.green),
		'theme[free_mid]=""',
		string.format('theme[free_end]="%s"', bright_colors.green),
		"",
		"# Download graph colors (Blue -> Bright Blue)",
		string.format('theme[download_start]="%s"', colors.blue),
		'theme[download_mid]=""',
		string.format('theme[download_end]="%s"', bright_colors.blue),
		"",
		"# Upload graph colors (Magenta -> Bright Magenta)",
		string.format('theme[upload_start]="%s"', colors.magenta),
		'theme[upload_mid]=""',
		string.format('theme[upload_end]="%s"', bright_colors.magenta),
		"",
		"# Process box color gradient for threads, mem and cpu usage (Green -> Orange -> Red)",
		string.format('theme[process_start]="%s"', colors.green),
		string.format('theme[process_mid]="%s"', bright_colors.yellow),
		string.format('theme[process_end]="%s"', colors.red),
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

	local success_count = 0
	local error_count = 0

	for _, name in ipairs(palette_names) do
		local palette = utils.load_palette(name)
		local theme = generate_btop_theme(name, palette)
		local btop_path = string.format("extras/btop/oasis_%s.theme", name)
		utils.write_file(btop_path, theme)
		print(string.format("✓ Generated: %s", btop_path))
		success_count = success_count + 1
	end

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
