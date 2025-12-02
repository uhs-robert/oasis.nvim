-- lua/oasis/config.lua

local M = {}

local default_dark = "lagoon"
local default_light = "dawn"
local utils = require("oasis.utils")

-- Helper to get deepcopy function (use vim.deepcopy if available, otherwise utils.deepcopy)
local function deepcopy(orig)
	if vim and vim.deepcopy then
		return vim.deepcopy(orig)
	else
		return utils.deepcopy(orig)
	end
end

-- Helper to get background setting (use vim.o.background if available, otherwise default to "dark" for standalone lua)
local function get_background()
	if vim and vim.o and vim.o.background then
		return vim.o.background
	else
		return "dark"
	end
end

-- Default configuration
-- stylua: ignore start
M.defaults = {
	style = default_dark,         -- Primary style choice (default palette)
	dark_style = "auto",          -- "auto" uses `style`, or specify a dark theme (e.g., "sol", "canyon")
	light_style = "auto",         -- "auto" uses `style`, or specify a light theme (e.g., "day")
	use_legacy_comments = false,  -- Applies to `desert` only. Uses vibrant skyblue for comments
	themed_syntax = true,         -- Use theme primary color for statements/keywords (dark themes only)
	light_intensity = 2,          -- Light background intensity (1-5): 1=subtle, 5=saturated
	palette_overrides = {},
	highlight_overrides = {},

	-- Text styling toggles
	styles = {
		bold = true,                -- Enable/disable bold text
		italic = true,              -- Enable/disable italic text
		underline = true,           -- Enable/disable underline
		undercurl = true,           -- Enable/disable undercurl (diagnostics, spell)
		strikethrough = true,       -- Enable/disable strikethrough
	},

	-- Additional toggles
	terminal_colors = true,       -- Enable/disable terminal color setting
	transparent = false,          -- Make backgrounds transparent (NONE)
}
-- stylua: ignore end

-- Current active configuration
M.options = deepcopy(M.defaults)

--- Deep merge two tables
---@param base table The base table
---@param override table The table to merge on top
---@return table merged The merged result
local function deep_merge(base, override)
	local result = deepcopy(base)

	for k, v in pairs(override) do
		if type(v) == "table" and type(result[k]) == "table" then
			result[k] = deep_merge(result[k], v)
		else
			result[k] = v
		end
	end

	return result
end

--- Setup configuration
---@param user_config table|nil User configuration to merge with defaults
function M.setup(user_config)
	user_config = user_config or {}
	M.options = deep_merge(M.defaults, user_config)
end

--- Get current configuration
---@return table config The current configuration
function M.get()
	return M.options
end

--- Get the full palette name from the configured style
--- Guaranteed to return a usable palette name string (falls back to defaults).
---@return string palette_name Full palette name (e.g., "oasis_lagoon")
function M.get_palette_name()
	local bg = get_background()

	-- Use dark_style/light_style based on background
	local style_option = bg == "light" and M.options.light_style or M.options.dark_style

	-- Default to main `style` if `light_style`/`dark_style` is "auto"
	if style_option == "auto" then
		style_option = M.options.style

		-- Check if the configured style is compatible with current background or use defaults
		local palette_name = "oasis_" .. style_option
		local mode = utils.get_palette_mode(palette_name)
		if mode and mode ~= "dual" and mode ~= bg then
			style_option = bg == "light" and default_light or default_dark
		end
	end

	if not style_option then
		return "oasis_" .. default_dark
	end

	-- Otherwise return the parsed palette
	local palette_name = "oasis_" .. style_option
	return palette_name
end

--- Apply palette overrides to a loaded palette
---@param palette table The base palette
---@param palette_name string The name of the palette (e.g., "oasis_desert")
---@return table palette The palette with overrides applied
function M.apply_palette_overrides(palette, palette_name)
	local result = deepcopy(palette)

	if M.options.palette_overrides[palette_name] then
		result = deep_merge(result, M.options.palette_overrides[palette_name])
	end

	return result
end

return M
