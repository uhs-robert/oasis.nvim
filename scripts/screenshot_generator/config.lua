-- scripts/screenshot_generator/config.lua
-- Configuration and constants for screenshot generation

-- Calculate paths upfront
local SCRIPT_DIR = debug.getinfo(1, "S").source:match("@?(.*/)") or "./"
local PROJECT_ROOT = SCRIPT_DIR .. "../.."
package.path = PROJECT_ROOT .. "/lua/?.lua;" .. PROJECT_ROOT .. "/lua/?/init.lua;" .. package.path

-- Load utils and set external file paths
local System = require("oasis.lib.system")
local TMUX_CONFIG = System.get_home_dir() .. "/.tmux.conf"

-- Module export, configuration table with all values
local Config = {
	-- Path configuration
	TMUX_CONFIG = TMUX_CONFIG,
	TMUX_BACKUP_FLAVOR = "/tmp/tmux-oasis-original-flavor",
	PROJECT_ROOT = PROJECT_ROOT,
	OUTPUT_DIR = PROJECT_ROOT .. "/assets/screenshots",
	TEMP_DIR = "/tmp/oasis-screenshots",

	-- Light intensity settings
	LIGHT_INTENSITY = 3,

	-- Exception palettes that should capture all light intensity levels (1-5)
	SHOWCASE_LIGHT_INTENSITY_THEMES = {
		lagoon = { 1, 2, 3, 4, 5 },
	},
}

-- Get available themes from oasis utils
function Config.get_themes()
	-- Add project root to package path for utils
	package.path = Config.PROJECT_ROOT .. "/lua/?.lua;" .. Config.PROJECT_ROOT .. "/lua/?/init.lua;" .. package.path

	local Utils = require("oasis.utils")
	local all_palettes = Utils.get_palette_names() -- excludes deprecated
	local themes = {}

	for _, name in ipairs(all_palettes) do
		local mode = Utils.get_palette_mode("oasis_" .. name)
		if mode == "dual" then
			table.insert(themes, name)
		end
	end

	return themes
end

-- Generate all variants (get both dark and light)
function Config.generate_variants()
	local variants = {}
	local themes = Config.get_themes()

	-- Add themes
	for _, theme in ipairs(themes) do
		table.insert(variants, theme .. "_dark")
		table.insert(variants, theme .. "_light_" .. Config.LIGHT_INTENSITY)
	end

	-- Add special light intensity themes
	for theme, intensities in pairs(Config.SHOWCASE_LIGHT_INTENSITY_THEMES) do
		for _, intensity in ipairs(intensities) do
			table.insert(variants, theme .. "_light_" .. intensity)
		end
	end

	return variants
end

-- List of all variants to process
Config.VARIANTS = Config.generate_variants()
-- Config.VARIANTS = {"sol_dark", "sol_light_3"} --NOTE: swap with the line above to test a single variant

return Config
