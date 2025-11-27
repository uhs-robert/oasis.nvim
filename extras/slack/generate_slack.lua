#!/usr/bin/env lua
-- extras/slack/generate_slack.lua
-- Generates Slack terminal themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")

local function generate_slack_theme(name, palette)
	local display_name = utils.capitalize(name)

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
		"## Available Themes",
		"",
		"### Dark Themes",
		"",
	}

	-- Separate dark and light themes
	local dark_themes = {}
	local light_themes = {}

	for _, name in ipairs(palette_names) do
		local palette = utils.load_palette(name)
		local display_name, theme_string = generate_slack_theme(name, palette)

		-- Determine if theme is light or dark based on naming convention
		if name:match("dawnlight") or name:match("^day$") or name:match("^dusk$") or name:match("^dust$") then
			table.insert(light_themes, { name = display_name, string = theme_string })
		else
			table.insert(dark_themes, { name = display_name, string = theme_string })
		end
	end

	-- Add dark themes to README
	for _, theme in ipairs(dark_themes) do
		table.insert(readme_lines, string.format("**Oasis %s**", theme.name))
		table.insert(readme_lines, "```")
		table.insert(readme_lines, theme.string)
		table.insert(readme_lines, "```")
		table.insert(readme_lines, "")
	end

	-- Add light themes section
	table.insert(readme_lines, "### Light Themes")
	table.insert(readme_lines, "")

	for _, theme in ipairs(light_themes) do
		table.insert(readme_lines, string.format("**Oasis %s**", theme.name))
		table.insert(readme_lines, "```")
		table.insert(readme_lines, theme.string)
		table.insert(readme_lines, "```")
		table.insert(readme_lines, "")
	end

	-- Write README
	local readme_content = table.concat(readme_lines, "\n")
	utils.write_file("extras/slack/README.md", readme_content)
	print("✓ Generated: extras/slack/README.md")

	print(string.format("\n=== Summary ==="))
	print(string.format("Dark themes: %d", #dark_themes))
	print(string.format("Light themes: %d", #light_themes))
	print(string.format("Total: %d\n", #dark_themes + #light_themes))
end

-- Run the generator
main()
