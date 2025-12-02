#!/usr/bin/env lua
-- extras/firefox/generate_firefox.lua
-- Generates Firefox Color theme URLs for README

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")
local color_utils = require("oasis.tools.color_utils")

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
	local display_name = utils.capitalize(name)

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
			toolbar_field_highlight = hex_to_rgb(palette.syntax.exception),
			toolbar_field_highlight_text = hex_to_rgb(palette.bg.core),

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
			popup_highlight = hex_to_rgb(palette.ui.visual.bg),
			popup_highlight_text = hex_to_rgb(palette.fg.core),

			-- Buttons
			button_background_active = hex_to_rgb(palette.ui.visual.bg),

			-- Sidebar
			sidebar = hex_to_rgb(palette.bg.core),
			sidebar_text = hex_to_rgb(palette.fg.core),
			sidebar_border = hex_to_rgb(palette.theme.primary),
			sidebar_highlight = hex_to_rgb(palette.theme.accent),
			sidebar_highlight_text = hex_to_rgb(palette.bg.crust),

			-- Icons and accents
			icons = hex_to_rgb(palette.theme.primary),
			icons_attention = hex_to_rgb(palette.syntax.exception),

			-- New tab page
			ntp_background = hex_to_rgb(palette.bg.crust),
			ntp_text = hex_to_rgb(palette.fg.core),

			-- Misc
			frame_inactive = hex_to_rgb(palette.bg.crust),
			toolbar_bottom_separator = hex_to_rgb(palette.bg.core),
			toolbar_field_separator = hex_to_rgb(palette.theme.accent),
			toolbar_vertical_separator = hex_to_rgb(palette.theme.accent),
		},
		images = {
			additional_backgrounds = {},
		},
		title = "Oasis " .. display_name,
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
		"## Themes",
		"",
	}

	-- Dynamically categorize palettes by light/dark mode
	local dark_palettes = {}
	local light_palettes = {}

	for name, data in pairs(palette_data) do
		if data.is_light then
			table.insert(light_palettes, name)
		else
			table.insert(dark_palettes, name)
		end
	end

	-- Sort alphabetically
	table.sort(dark_palettes)
	table.sort(light_palettes)

	-- Generate dark themes section
	if #dark_palettes > 0 then
		table.insert(lines, "### Dark Themes")
		table.insert(lines, "")

		for _, name in ipairs(dark_palettes) do
			local data = palette_data[name]
			local display_name = utils.capitalize(name)
			local link = string.format("- [**Oasis %s**](https://color.firefox.com/?theme=%s)", display_name, data.url)
			table.insert(lines, link)
		end

		table.insert(lines, "")
	end

	-- Generate light themes section
	if #light_palettes > 0 then
		table.insert(lines, "### Light Themes")
		table.insert(lines, "")

		for _, name in ipairs(light_palettes) do
			local data = palette_data[name]
			local display_name = utils.capitalize(name)
			local link = string.format("- [**Oasis %s**](https://color.firefox.com/?theme=%s)", display_name, data.url)
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

	local palette_names = utils.get_palette_names()

	if #palette_names == 0 then
		print("Error: No palette files found in lua/oasis/color_palettes/")
		return
	end

	print(string.format("Found %d palette(s)\n", #palette_names))

	local palette_data = {}

	local success_count, error_count = utils.for_each_palette_mode(function(name, palette, mode)
		-- Build variant name (append mode suffix for dual-mode palettes)
		local variant_name = mode and (name .. "_" .. mode) or name

		local theme = generate_firefox_color_theme(variant_name, palette)

		-- Convert to JSON
		local json = color_utils.encode_json(theme)

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
		utils.write_file("extras/firefox/README.md", readme)
		print(string.format("\n✓ Generated: extras/firefox/README.md"))
	end

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d", error_count))
	print()
end

-- Run the generator
main()
