#!/usr/bin/env lua
-- extras/thunderbird/generate_thunderbird.lua
-- Generates Thunderbird WebExtension themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local utils = require("oasis.utils")
local color_utils = require("oasis.tools.color_utils")

-- Simple UUID generator (deterministic based on name)
local function generate_uuid(name)
	-- Use a simple hash-based UUID for consistency
	-- This is deterministic so the same palette always gets the same UUID
	local hash = 0
	for i = 1, #name do
		hash = (hash * 31 + string.byte(name, i)) % 2147483647
	end

	-- Format as UUID (not cryptographically secure, but sufficient for extension IDs)
	-- Use math.floor division instead of >> for LuaJIT compatibility
	return string.format(
		"%08x-%04x-%04x-%04x-%012x",
		hash,
		math.floor(hash / 65536) % 0x10000, -- Equivalent to (hash >> 16)
		0x4000 + (hash % 0x1000), -- Version 4 UUID
		0x8000 + (hash % 0x4000), -- Variant bits
		hash % 0x1000000000000
	)
end

-- Generate styles.css content
local function generate_stylesheet()
	-- Minimal CSS for theme experiment support
	-- This allows the experimental color variables to be applied
	return [[/* Oasis Thunderbird Theme Stylesheet */
/* This stylesheet enables experimental theme color variables */

:root {
  /* Custom color variables are injected by the theme manifest */
}
]]
end

local function generate_manifest(name, palette)
	local display_name = utils.format_display_name(name)
	-- Keep a stable slug for IDs, but present a readable name in Thunderbird
	local theme_id = "oasis-" .. name

	-- Build the manifest structure
	local manifest = {
		manifest_version = 2,
		name = display_name,
		version = "1.0.0",
		applications = {
			gecko = {
				id = "{" .. generate_uuid(theme_id) .. "}",
				strict_min_version = "60.0",
			},
		},
		description = string.format("%s", display_name),
		icons = {
			["16"] = "images/icon16.png",
			["48"] = "images/icon48.png",
			["128"] = "images/icon128.png",
		},
		theme_experiment = {
			stylesheet = "styles.css",
			colors = {
				spaces_bg = "--spaces-bg-color",
				spaces_bg_active = "--spaces-button-active-bg-color",
				spaces_button = "--spaces-button-active-text-color",
				tree_view_bg = "--tree-view-bg",
				bg_color = "--bg-color",
				button_primary_bg = "--button-primary-background-color",
				button_text = "--button-primary-text-color",
				tree_pane_bg = "--tree-pane-background",
				tree_card_bg = "--tree-card-background",
				layout_bg_0 = "--layout-background-0",
				layout_bg_1 = "--layout-background-1",
				button_bg = "--button-background-color",
				lwt_accent_color = "--lwt-accent-color",
				list_container_background_selected_current = "--list-container-background-selected-current",
				ab_cards_list_bg = "--ab-cards-list-bg",
				in_content_box_info_background = "--in-content-box-info-background",
				calendar_view_toggle_bg = "--calendar-view-toggle-background",
				calendar_view_toggle_hover_bg = "--calendar-view-toggle-hover-background",
				tabs_toolbar_bg = "--tabs-toolbar-background-color",
				color_gray_70 = "--color-gray-70",
				color_gray_50 = "--color-gray-50",
			},
		},
		theme = {
			colors = {
				-- Main window and frame
				frame = palette.bg.core,

				-- Toolbar
				toolbar = palette.bg.mantle,
				toolbar_text = palette.fg.core,

				-- Tabs
				tab_text = palette.fg.core,
				tab_line = palette.theme.primary,
				tab_loading = palette.theme.primary,
				tab_selected = palette.bg.surface,
				tab_background_text = palette.theme.light_primary,
				-- tab_background_text = palette.syntax.comment,
				tab_background_separator = palette.bg.surface,

				-- Buttons
				button_background_active = palette.theme.primary,
				button_background_hover = palette.bg.surface,

				-- Icons
				icons = palette.fg.core,

				-- Bookmarks/toolbar items
				bookmark_text = palette.fg.core,

				-- Input fields (search, address bar, etc.)
				toolbar_field = palette.bg.surface,
				toolbar_field_text = palette.fg.core,
				toolbar_field_highlight = palette.theme.primary,
				toolbar_field_highlight_text = palette.bg.core,
				toolbar_field_border = palette.ui.border,
				toolbar_field_focus = palette.bg.surface,
				toolbar_field_text_focus = palette.fg.core,
				toolbar_field_border_focus = palette.theme.primary,

				-- Separators
				toolbar_top_separator = palette.bg.surface,
				toolbar_bottom_separator = palette.bg.surface,
				toolbar_vertical_separator = palette.bg.surface,

				-- Sidebar
				sidebar = palette.bg.core,
				sidebar_text = palette.fg.core,
				sidebar_highlight = palette.theme.primary,
				sidebar_highlight_text = palette.bg.core,
				sidebar_border = palette.ui.border,

				-- Popups and menus
				popup = palette.bg.surface,
				popup_text = palette.fg.core,
				popup_border = palette.ui.border,
				popup_highlight = palette.theme.primary,
				popup_highlight_text = palette.bg.core,

				-- Experimental theme colors
				spaces_bg = palette.bg.mantle,
				spaces_bg_active = palette.theme.primary,
				spaces_button = palette.bg.core,
				tree_view_bg = palette.bg.crust,
				bg_color = palette.bg.core,
				button_primary_bg = palette.theme.primary,
				button_text = palette.bg.core,
				tree_pane_bg = palette.bg.crust,
				tree_card_bg = palette.bg.mantle,
				layout_bg_0 = palette.bg.core,
				layout_bg_1 = palette.bg.core,
				button_bg = palette.bg.mantle,
				lwt_accent_color = palette.bg.mantle,
				list_container_background_selected_current = palette.bg.mantle,
				ab_cards_list_bg = palette.bg.mantle,
				in_content_box_info_background = palette.bg.mantle,
				calendar_view_toggle_bg = palette.bg.mantle,
				calendar_view_toggle_hover_bg = palette.bg.surface,
				tabs_toolbar_bg = palette.bg.mantle,
				color_gray_70 = palette.bg.mantle,
				color_gray_50 = palette.bg.surface,
			},
		},
	}

	return color_utils.encode_json(manifest)
end

-- Create .xpi file
local function create_xpi(name, manifest_json)
	local temp_dir = "/tmp/oasis_thunderbird_" .. name

	-- Extract base palette name (e.g., "lagoon" from "lagoon_dark" or "lagoon_light_3")
	local base_name = name:match("^(.-)_") or name
	local themes_dir = "extras/thunderbird/themes/" .. base_name
	os.execute("mkdir -p " .. themes_dir)

	local xpi_path = themes_dir .. "/oasis_" .. name .. ".xpi"

	-- Create temp directory structure
	os.execute("rm -rf " .. temp_dir)
	os.execute("mkdir -p " .. temp_dir .. "/images")

	-- Write manifest.json
	utils.write_file(temp_dir .. "/manifest.json", manifest_json)

	-- Write styles.css
	utils.write_file(temp_dir .. "/styles.css", generate_stylesheet())

	-- Copy icon files
	os.execute("cp extras/thunderbird/assets/icon16.png " .. temp_dir .. "/images/")
	os.execute("cp extras/thunderbird/assets/icon48.png " .. temp_dir .. "/images/")
	os.execute("cp extras/thunderbird/assets/icon128.png " .. temp_dir .. "/images/")

	-- Create themes directory if it doesn't exist
	os.execute("mkdir -p " .. themes_dir)

	-- Create .xpi (zip archive)
	-- Get absolute path to project root
	local handle = io.popen("pwd")
	if not handle then
		print("Error: Failed to get current directory")
		return false
	end
	local cwd = handle:read("*l")
	handle:close()

	local zip_cmd = string.format("cd %s && zip -q -r %s/%s . && cd - >/dev/null", temp_dir, cwd, xpi_path)

	local success = os.execute(zip_cmd)

	-- Clean up temp directory
	os.execute("rm -rf " .. temp_dir)

	return success == 0 or success == true
end

local function main()
	print("\n=== Oasis Thunderbird Theme Generator ===\n")

	-- Check for zip command
	local zip_check = os.execute("which zip >/dev/null 2>&1")
	if not (zip_check == 0 or zip_check == true) then
		print("Error: 'zip' command not found. Please install zip.")
		return
	end

	local palette_names = utils.get_palette_names()

	if #palette_names == 0 then
		print("Error: No palette files found in lua/oasis/color_palettes/")
		return
	end

	print(string.format("Found %d palette(s)\n", #palette_names))

	local dark_themes = {}
	local light_themes = {}

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

		local manifest = generate_manifest(variant_name, palette)
		local success = create_xpi(variant_name, manifest)

		if success then
			print(string.format("✓ Generated: extras/thunderbird/themes/oasis_%s.xpi", variant_name))

			-- Track for README generation
			local display_name = utils.format_display_name(variant_name)
			if palette.light_mode then
				table.insert(light_themes, { name = variant_name, display = display_name })
			else
				table.insert(dark_themes, { name = variant_name, display = display_name })
			end
		else
			error("Failed to create xpi for " .. variant_name)
		end
	end)

	-- Generate README
	if success_count > 0 then
		local readme_lines = {
			"# Thunderbird Themes",
			"",
			"Oasis color themes for Mozilla Thunderbird, packaged as WebExtension themes.",
			"",
			"## Installation",
			"",
			"1. Download your preferred `.xpi` theme file from the `themes/` directory",
			"2. Open Thunderbird",
			"3. Go to **Tools** → **Add-ons and Themes** (or press `Ctrl+Shift+A`)",
			"4. Click the gear icon ⚙️ and select **Install Add-on From File...**",
			"5. Navigate to and select the downloaded `.xpi` file",
			"6. Click **Add** to install the theme",
			"7. The theme will be applied automatically",
			"",
			"## Available Themes",
			"",
		}

		if #dark_themes > 0 then
			table.insert(readme_lines, "### Dark Themes")
			table.insert(readme_lines, "")
			for _, theme in ipairs(dark_themes) do
				table.insert(
					readme_lines,
					string.format("- **Oasis %s** - `themes/oasis_%s.xpi`", theme.display, theme.name)
				)
			end
			table.insert(readme_lines, "")
		end

		if #light_themes > 0 then
			table.insert(readme_lines, "### Light Themes")
			table.insert(readme_lines, "")
			for _, theme in ipairs(light_themes) do
				table.insert(
					readme_lines,
					string.format("- **Oasis %s** - `themes/oasis_%s.xpi`", theme.display, theme.name)
				)
			end
			table.insert(readme_lines, "")
		end

		table.insert(readme_lines, "## Uninstallation")
		table.insert(readme_lines, "")
		table.insert(readme_lines, "1. Go to **Tools** → **Add-ons and Themes**")
		table.insert(readme_lines, "2. Find the Oasis theme in the **Themes** section")
		table.insert(readme_lines, "3. Click **Remove** or **Disable**")
		table.insert(readme_lines, "")
		table.insert(readme_lines, "## Development")
		table.insert(readme_lines, "")
		table.insert(readme_lines, "To regenerate all themes:")
		table.insert(readme_lines, "")
		table.insert(readme_lines, "```bash")
		table.insert(readme_lines, "lua extras/thunderbird/generate_thunderbird.lua")
		table.insert(readme_lines, "```")
		table.insert(readme_lines, "")

		local readme_content = table.concat(readme_lines, "\n")
		utils.write_file("extras/thunderbird/README.md", readme_content)
		print("\n✓ Generated: extras/thunderbird/README.md")
	end

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d", error_count))
	print(string.format("Dark themes: %d", #dark_themes))
	print(string.format("Light themes: %d\n", #light_themes))
end

-- Run the generator
main()
