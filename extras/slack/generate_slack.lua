#!/usr/bin/env lua
-- extras/slack/generate_slack.lua
-- Generates Slack terminal themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")
local File = require("oasis.lib.file")

local function generate_slack_theme(name, palette)
	local display_name = utils.format_display_name(name)

	-- Map Oasis colors to Slack theme components
	-- Format: Column BG, Menu BG Hover, Active Item, Active Item Text, Hover Item,
	--         Text Color, Active Presence, Mention Badge, Column BG (repeat), Text Color (repeat)
	local theme_string = string.format(
		"%s,%s,%s,%s,%s,%s,%s,%s,%s,%s",
		palette.bg.surface, -- Column BG
		palette.bg.mantle, -- Menu BG Hover
		palette.theme.primary, -- Active Item
		palette.bg.surface, -- Active Item Text
		palette.bg.mantle, -- Hover Item
		palette.fg.core, -- Text Color
		palette.theme.secondary, -- Active Presence
		palette.theme.accent, -- Mention Badge
		palette.bg.core, -- Column BG (repeat)
		palette.fg.core -- Text Color (repeat)
	)

	return display_name, theme_string
end

local function main()
	print("\n=== Oasis Slack Theme Generator ===\n")

	local palette_names = utils.get_palette_names()

	if #palette_names == 0 then
		print("Error: No palette files found in lua/oasis/color_palettes/")
		return
	end

	print(string.format("Found %d palette(s)\n", #palette_names))

	-- Generate theme strings for README
	local readme_lines = {
		"# Slack Themes",
		"",
		"Custom Slack color themes for all Oasis palette variants.",
		"",
		"## Installation",
		"",
		"1. Open Slack preferences (Cmd/Ctrl + ,)",
		"2. Navigate to **Appearance**",
		"3. In the **Color Mode** section, select **Custom theme**",
		"4. Select **Import**",
		"4. Copy one of the theme strings below and paste it into the input field",
		"5. Click **Apply**",
		"",
	}

	-- Organize themes by base palette name
	local palettes = {} -- { palette_name = { dark = theme, light = {theme1, theme2...} } }

	local success_count, error_count = utils.for_each_palette_variant(function(name, palette, mode, intensity)
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

		local display_name, theme_string = generate_slack_theme(variant_name, palette)

		-- Initialize palette group if needed
		if not palettes[name] then
			palettes[name] = { dark = nil, light = {} }
		end

		-- Categorize by mode
		if palette.light_mode then
			table.insert(palettes[name].light, { name = display_name, string = theme_string })
		else
			palettes[name].dark = { name = display_name, string = theme_string }
		end
	end)

	-- Sort palette names alphabetically
	local palette_names = {}
	for palette_name in pairs(palettes) do
		table.insert(palette_names, palette_name)
	end
	table.sort(palette_names)

	-- Generate table of contents
	table.insert(readme_lines, "## Table of Contents")
	table.insert(readme_lines, "")
	for _, palette_name in ipairs(palette_names) do
		local display = utils.capitalize(palette_name)
		table.insert(readme_lines, string.format("- [%s](#%s)", display, palette_name:lower()))
	end
	table.insert(readme_lines, "")
	table.insert(readme_lines, "---")
	table.insert(readme_lines, "")

	-- Generate themes grouped by palette
	for _, palette_name in ipairs(palette_names) do
		local group = palettes[palette_name]
		local display = utils.capitalize(palette_name)

		-- Palette header
		table.insert(readme_lines, string.format("## %s", display))
		table.insert(readme_lines, "")

		-- Dark variant first
		if group.dark then
			table.insert(readme_lines, string.format("**%s**", group.dark.name))
			table.insert(readme_lines, "```")
			table.insert(readme_lines, group.dark.string)
			table.insert(readme_lines, "```")
			table.insert(readme_lines, "")
		end

		-- Sort light variants by intensity (1-5)
		table.sort(group.light, function(a, b)
			local a_intensity = a.name:match("Light (%d+)")
			local b_intensity = b.name:match("Light (%d+)")
			if a_intensity and b_intensity then
				return tonumber(a_intensity) < tonumber(b_intensity)
			end
			return a.name < b.name
		end)

		-- Light variants underneath
		for _, theme in ipairs(group.light) do
			table.insert(readme_lines, string.format("**%s**", theme.name))
			table.insert(readme_lines, "```")
			table.insert(readme_lines, theme.string)
			table.insert(readme_lines, "```")
			table.insert(readme_lines, "")
		end
	end

	-- Write README
	local readme_content = table.concat(readme_lines, "\n")
	File.write("extras/slack/README.md", readme_content)
	print("✓ Generated: extras/slack/README.md")

	-- Count totals
	local dark_count = 0
	local light_count = 0
	for _, group in pairs(palettes) do
		if group.dark then
			dark_count = dark_count + 1
		end
		light_count = light_count + #group.light
	end

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d", error_count))
	print(string.format("Palettes: %d", #palette_names))
	print(string.format("Dark themes: %d", dark_count))
	print(string.format("Light themes: %d\n", light_count))
end

-- Run the generator
main()
