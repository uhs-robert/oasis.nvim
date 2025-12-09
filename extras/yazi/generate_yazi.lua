#!/usr/bin/env lua
-- extras/yazi/generate_yazi.lua
-- Generates Yazi file manager themes from Oasis color palettes

-- Load shared utilities
package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"
local Utils = require("oasis.utils")
local File = require("oasis.lib.file")

-- Extract Yazi theme colors from Oasis palette
local function extract_yazi_theme_colors(palette)
	-- Map Oasis palette structure to Yazi theme placeholders
	return {
		-- Basic UI colors
		primary = palette.theme.primary,
		secondary = palette.theme.secondary,
		accent = palette.theme.accent,
		fg_core = palette.fg.core,
		fg_strong = palette.fg.strong,
		fg_muted = palette.syntax.comment,
		hover_bg = palette.bg.surface,
		hover_bg_alt = palette.ui.visual.bg,
		bg_core = palette.bg.core,
		bg_mantle = palette.bg.mantle,
		bg_surface = palette.bg.surface,
		border = palette.ui.border,
		search = palette.ui.match.bg,

		-- Status/diagnostic colors
		error = palette.syntax.exception,
		warning = palette.terminal.yellow,
		info = palette.ui.diag.info.fg,
		success = palette.syntax.string,

		-- Tab/mode colors
		tab_active = palette.theme.primary,
		mode_normal = palette.terminal.yellow,
		mode_select = palette.terminal.bright_yellow,
		mode_unset = palette.ui.diag.error.fg,

		-- Spot border
		spot_border = palette.ui.diag.error.fg,

		-- File type colors (used in theme rules)
		ft_image = palette.terminal.bright_cyan,
		ft_media = palette.terminal.yellow,
		ft_archive = palette.terminal.bright_magenta,
		ft_document = palette.terminal.green,
	}
end

-- Extract Yazi terminal colors from Oasis palette
local function extract_yazi_icon_colors(palette)
	local colors = {}

	for key, value in pairs(palette.terminal) do
		colors[key] = value
	end

	colors.bg_mantle = palette.bg.mantle
	colors.bg_surface = palette.bg.surface

	return colors
end

-- Generate merged Yazi theme TOML combining theme and icons templates
local function generate_merged_theme(name, palette, output_path)
	local display_name = Utils.format_display_name(name)
	local theme_template = File.read("extras/yazi/theme.toml.template")
	local icons_template = File.read("extras/yazi/icons.toml.template")

	if not theme_template then
		error("Failed to read theme.toml.template")
	end

	if not icons_template then
		error("Failed to read icons.toml.template")
	end

	-- Extract all colors (theme + icons)
	local theme_colors = extract_yazi_theme_colors(palette)
	local icon_colors = extract_yazi_icon_colors(palette)

	-- Merge both color tables
	local all_colors = {}
	for k, v in pairs(theme_colors) do
		all_colors[k] = v
	end
	for k, v in pairs(icon_colors) do
		all_colors[k] = v
	end

	-- Add header comment
	local output = string.format("# %s\n## name: Oasis %s\n## author: uhs-robert\n\n", output_path or "", display_name)

	-- Process theme template
	local processed_theme = theme_template
	for key, value in pairs(all_colors) do
		local pattern = "{{" .. key .. "}}"
		processed_theme = processed_theme:gsub(pattern, value)
	end

	-- Process icons template
	local processed_icons = icons_template
	for key, value in pairs(all_colors) do
		local pattern = "{{" .. key .. "}}"
		processed_icons = processed_icons:gsub(pattern, value)
	end

	-- Merge both sections with a separator
	return output .. processed_theme .. "\n" .. processed_icons
end

local function main()
	print("\n=== Oasis Yazi Theme Generator ===\n")

	local palette_names = Utils.get_palette_names()

	if #palette_names == 0 then
		print("Error: No palette files found in lua/oasis/color_palettes/")
		return
	end

	print(string.format("Found %d palette(s)\n", #palette_names))

	local success_count, error_count = Utils.for_each_palette_variant(function(name, palette, mode, intensity)
		-- Build variant name with mode and optional intensity suffix
		local variant_name
		if mode then
			-- Dual-mode palette
			if mode == "dark" then
				variant_name = name .. "_dark"
			else
				variant_name = name .. "_light_" .. intensity
			end
		else
			-- Legacy flat palette
			variant_name = name
		end

		-- Build directory structure: themes/<mode>/[intensity/]flavors/oasis-<variant>.yazi/
		local _, _, subdir = Utils.build_variant_path("extras/yazi", "", name, mode, intensity)
		local flavor_dir =
			string.format("extras/yazi/themes/%s/flavors/oasis-%s.yazi", subdir, variant_name:gsub("_", "-"))
		local output_path = string.format("%s/flavor.toml", flavor_dir)

		-- Create directory structure
		os.execute(string.format('mkdir -p "%s"', flavor_dir))

		-- Generate merged theme file
		local merged = generate_merged_theme(variant_name, palette, output_path)
		File.write(output_path, merged)
		print(string.format("✓ Generated: %s", output_path))
	end)

	print(string.format("\n=== Summary ==="))
	print(string.format("Success: %d", success_count))
	print(string.format("Errors: %d\n", error_count))
end

-- Run the generator
main()
