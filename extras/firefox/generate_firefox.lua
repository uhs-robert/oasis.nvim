#!/usr/bin/env lua
-- extras/firefox/generate_firefox.lua
-- Generates Firefox Color theme URLs for README

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")
local ColorUtils = require("oasis.tools.color_utils")

-- Convert hex color to RGB object for Firefox Color
local function hex_to_rgb(hex)
	if not hex or hex == "NONE" then
		return { r = 0, g = 0, b = 0 }
	end

	hex = hex:gsub("#", "")
	local r = tonumber(hex:sub(1, 2), 16)
	local g = tonumber(hex:sub(3, 4), 16)
	local b = tonumber(hex:sub(5, 6), 16)

	return { r = r, g = g, b = b }
end

-- Generate Firefox Color theme object
local function generate_firefox_color_theme(name, palette)
	local display_name = Utils.format_display_name(name)

	return {
		colors = {
			-- Main UI
			frame = hex_to_rgb(palette.bg.core),
			toolbar = hex_to_rgb(palette.bg.mantle),
			toolbar_text = hex_to_rgb(palette.theme.primary),
			tab_background_text = hex_to_rgb(palette.theme.primary),

			-- Input fields
			toolbar_field = hex_to_rgb(palette.bg.mantle),
			toolbar_field_text = hex_to_rgb(palette.fg.core),
			toolbar_field_border = hex_to_rgb(palette.bg.surface),
			toolbar_field_focus = hex_to_rgb(palette.bg.core),
			toolbar_field_border_focus = hex_to_rgb(palette.theme.primary),
			toolbar_field_highlight = hex_to_rgb(palette.ui.search.bg),
			toolbar_field_highlight_text = hex_to_rgb(palette.ui.search.fg),

			-- Tabs
			tab_line = hex_to_rgb(palette.theme.secondary),
			tab_selected = hex_to_rgb(palette.bg.core),
			tab_text = hex_to_rgb(palette.fg.core),
			tab_loading = hex_to_rgb(palette.theme.secondary),
			tab_background_separator = hex_to_rgb(palette.theme.accent),

			-- Popups and menus
			popup = hex_to_rgb(palette.bg.core),
			popup_text = hex_to_rgb(palette.fg.core),
			popup_border = hex_to_rgb(palette.bg.surface),
			popup_highlight = hex_to_rgb(palette.ui.search.bg),
			popup_highlight_text = hex_to_rgb(palette.ui.search.fg),

			-- Buttons
			button_background_active = hex_to_rgb(palette.ui.visual.bg),

			-- Sidebar
			sidebar = hex_to_rgb(palette.bg.core),
			sidebar_text = hex_to_rgb(palette.fg.core),
			sidebar_border = hex_to_rgb(palette.theme.primary),
			sidebar_highlight = hex_to_rgb(palette.ui.search.bg),
			sidebar_highlight_text = hex_to_rgb(palette.ui.search.fg),

			-- Icons and accents
			icons = hex_to_rgb(palette.theme.primary),
			icons_attention = hex_to_rgb(palette.syntax.exception),

			-- New tab page
			ntp_background = hex_to_rgb(palette.bg.mantle),
			ntp_text = hex_to_rgb(palette.fg.core),

			-- Misc
			frame_inactive = hex_to_rgb(palette.bg.shadow),
			toolbar_bottom_separator = hex_to_rgb(palette.bg.core),
			toolbar_field_separator = hex_to_rgb(palette.theme.accent),
			toolbar_vertical_separator = hex_to_rgb(palette.theme.accent),
		},
		images = {
			additional_backgrounds = {},
		},
		title = display_name,
	}
end

-- Compress JSON for Firefox Color using json-url LZMA codec
local function compress_for_firefox(json_str)
	-- Check if Node.js and json-url are available
	local check_node = assert(io.popen("command -v node 2>/dev/null"))
	local node_path = check_node:read("*a"):gsub("%s+", "")
	check_node:close()

	if node_path == "" then
		print("Warning: Node.js not found. Install Node.js and run 'npm install' in extras/firefox/")
		return nil
	end

	-- Check if compress.js exists
	local compress_script = "extras/firefox/compress.js"
	local script_check = io.open(compress_script, "r")
	if not script_check then
		print("Error: compress.js not found at " .. compress_script)
		return nil
	end
	script_check:close()

	-- Use the Node.js script to compress
	local cmd = string.format("echo '%s' | node %s", json_str:gsub("'", "'\\''"), compress_script)
	local handle = assert(io.popen(cmd .. " 2>&1"))
	local result = handle:read("*a")
	local success = handle:close()

	if not success or result:match("Error:") then
		print("Compression error: " .. result)
		return nil
	end

	-- Trim whitespace
	result = result:gsub("^%s+", ""):gsub("%s+$", "")

	return result
end

-- Generate README content with theme links
local function generate_readme(palette_data)
	local lines = {
		"# Firefox Color Themes",
		"",
		"Install Oasis themes for Firefox using [Firefox Color](https://color.firefox.com).",
		"",
		"Click the theme links below to instantly apply Oasis color palettes to your Firefox browser.",
		"",
		'<img src="/assets/screenshots/extras/firefox.png" alt="Firefox" width="2534" height="1518">',
		"",
	}

	-- Organize by base palette name
	local palettes = {} -- { palette_name = { dark = data, light = {data1, data2...} } }

	for variant_name, data in pairs(palette_data) do
		-- Extract base palette name (e.g., "lagoon" from "lagoon_dark" or "lagoon_light_3")
		local base_name = variant_name:match("^(.+)_dark$") or variant_name:match("^(.+)_light_%d+$") or variant_name

		-- Initialize palette group
		if not palettes[base_name] then
			palettes[base_name] = { dark = nil, light = {} }
		end

		-- Categorize
		if data.is_light then
			table.insert(palettes[base_name].light, { name = variant_name, data = data })
		else
			palettes[base_name].dark = { name = variant_name, data = data }
		end
	end

	-- Sort palette names alphabetically
	local palette_names = {}
	for palette_name in pairs(palettes) do
		table.insert(palette_names, palette_name)
	end
	table.sort(palette_names)

	-- Generate table of contents
	table.insert(lines, "## Table of Contents")
	table.insert(lines, "")
	for _, palette_name in ipairs(palette_names) do
		local display = Utils.capitalize(palette_name)
		table.insert(lines, string.format("- [%s](#%s)", display, palette_name:lower()))
	end
	table.insert(lines, "")
	table.insert(lines, "---")
	table.insert(lines, "")

	-- Generate themes grouped by palette
	for _, palette_name in ipairs(palette_names) do
		local group = palettes[palette_name]
		local display = Utils.capitalize(palette_name)

		-- Palette header
		table.insert(lines, string.format("## %s", display))
		table.insert(lines, "")

		-- Dark variant first
		if group.dark then
			local display_name = Utils.format_display_name(group.dark.name)
			local link =
				string.format("- [**%s**](https://color.firefox.com/?theme=%s)", display_name, group.dark.data.url)
			table.insert(lines, link)
		end

		-- Sort light variants by intensity (1-5)
		table.sort(group.light, function(a, b)
			local a_intensity = a.name:match("_light_(%d+)$")
			local b_intensity = b.name:match("_light_(%d+)$")
			if a_intensity and b_intensity then
				return tonumber(a_intensity) < tonumber(b_intensity)
			end
			return a.name < b.name
		end)

		-- Light variants underneath
		for _, theme in ipairs(group.light) do
			local display_name = Utils.format_display_name(theme.name)
			local link = string.format("- [**%s**](https://color.firefox.com/?theme=%s)", display_name, theme.data.url)
			table.insert(lines, link)
		end

		table.insert(lines, "")
	end

	-- Add installation notes
	table.insert(lines, "## Installation")
	table.insert(lines, "")
	table.insert(lines, "1. Click any theme link above")
	table.insert(lines, "2. Firefox Color will open with the theme preview")
	table.insert(lines, "3. Click the **Install** button to apply the theme")
	table.insert(lines, "4. The theme will be saved to your Firefox profile")
	table.insert(lines, "")
	table.insert(lines, "## Customization")
	table.insert(lines, "")
	table.insert(lines, "After installing a theme, you can further customize it using Firefox Color:")
	table.insert(lines, "")
	table.insert(lines, "1. Open [Firefox Color](https://color.firefox.com)")
	table.insert(lines, "2. Select your installed Oasis theme")
	table.insert(lines, "3. Adjust individual colors as desired")
	table.insert(lines, "4. Save your customized theme")
	table.insert(lines, "")
	table.insert(lines, "## Textfox - TUI Firefox")
	table.insert(lines, "")
	table.insert(
		lines,
		"Wouldn't it be nice if Firefox looked like a TUI application? Check out [**Textfox**](https://github.com/adriankarlen/textfox) - a TUI (Text User Interface) configuration for Firefox. It's what I use personally and this Oasis design is tailored for it specifically."
	)
	table.insert(lines, "")
	table.insert(
		lines,
		"Textfox provides a minimal Firefox interface that complements the Oasis color palette perfectly for users who prefer terminal-based workflows."
	)
	table.insert(lines, "")

	return table.concat(lines, "\n")
end

local function main()
	print("\n=== Oasis Firefox Color Theme Generator ===\n")

	local palette_names = Utils.get_palette_names()

	if #palette_names == 0 then
		print("Error: No palette files found in lua/oasis/color_palettes/")
		return
	end

	print(string.format("Found %d palette(s)\n", #palette_names))

	local palette_data = {}

	local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
		-- Build variant name with mode and optional intensity suffix
		local variant_name
		if mode then
			if mode == "dark" then
				variant_name = name .. "_dark"
			else
				variant_name = name .. "_light_" .. intensity
			end
		else
			variant_name = name
		end

		local theme = generate_firefox_color_theme(variant_name, palette)

		-- Convert to JSON
		local json = ColorUtils.encode_json(theme)

		-- Compress for Firefox Color using json-url LZMA
		local compressed = compress_for_firefox(json)

		if compressed and compressed ~= "" then
			palette_data[variant_name] = {
				url = compressed,
				is_light = palette.light_mode == true,
			}
			local theme_mode = palette.light_mode and "light" or "dark"
			print(string.format("✓ Generated: %s (%s, %d chars)", variant_name, theme_mode, #compressed))
		else
			error("Failed to compress theme for " .. variant_name)
		end
	end)

	-- Generate README
	if success_count > 0 then
		local readme = generate_readme(palette_data)
		File.write("extras/firefox/README.md", readme)
		print(string.format("\n✓ Generated: extras/firefox/README.md"))
	end

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d", error_count))
	print()
end

-- Run the generator
main()
