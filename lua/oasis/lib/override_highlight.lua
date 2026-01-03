-- lua/oasis/lib/override_highlight.lua

local HighlightOverrides = {}
local Config = require("oasis.config")
local DEFAULT_LIGHT_INTENSITY = 3

-- Helper to merge highlight groups from source into target
--- Merge highlight groups from source into target
--- @param target table
--- @param source table|nil
local function merge_highlights(target, source)
	if not source then
		return
	end
	for name, attrs in pairs(source) do
		target[name] = attrs
	end
end

-- Helper to check if a value is a highlight definition (vs a palette section)
--- Check whether value is a highlight definition (vs palette section)
--- @param value any
--- @return boolean
local function is_highlight_definition(value)
	if type(value) ~= "table" then
		return true -- String links are highlight definitions
	end
	-- Check for typical highlight attributes
	local hl_keys = {
		"fg",
		"bg",
		"sp",
		"bold",
		"italic",
		"underline",
		"undercurl",
		"strikethrough",
		"reverse",
		"standout",
		"blend",
		"link",
	}
	for _, key in ipairs(hl_keys) do
		if value[key] ~= nil then
			return true
		end
	end
	return false -- It's a palette section or nested structure
end

--- Normalize user overrides into a table (or nil if invalid)
--- @param c table
--- @param user_overrides table|function|nil
--- @return table|nil
local function normalize(c, user_overrides)
	if type(user_overrides) == "function" then
		local colors = Config.get_base_colors()
		return user_overrides(c, colors)
	end

	if type(user_overrides) ~= "table" then
		return nil
	end

	return user_overrides
end

--- Apply global (top-level) highlight overrides
--- @param resolved table
--- @param user_overrides table
local function apply_global(resolved, user_overrides)
	for name, attrs in pairs(user_overrides) do
		if is_highlight_definition(attrs) then
			resolved[name] = attrs
		end
	end
end

--- Apply global light/intensity overrides
--- @param resolved table
--- @param user_overrides table
--- @param intensity number
local function apply_global_light(resolved, user_overrides, intensity)
	if user_overrides.light then
		merge_highlights(resolved, user_overrides.light)
	end

	local intensity_key = "light_" .. intensity
	if user_overrides[intensity_key] then
		merge_highlights(resolved, user_overrides[intensity_key])
	end
end

--- Apply palette-specific dark overrides
--- @param resolved table
--- @param palette_overrides table
local function apply_dark(resolved, palette_overrides)
	for name, attrs in pairs(palette_overrides) do
		if name ~= "light" and not name:match("^light_%d$") then
			resolved[name] = attrs
		end
	end
end

--- Apply palette-specific light/intensity overrides
--- @param resolved table
--- @param palette_overrides table
--- @param intensity number
local function apply_light(resolved, palette_overrides, intensity)
	if palette_overrides.light then
		merge_highlights(resolved, palette_overrides.light)
	end

	local intensity_key = "light_" .. intensity
	if palette_overrides[intensity_key] then
		merge_highlights(resolved, palette_overrides[intensity_key])
	end
end

--- Apply palette-specific overrides for the active palette variant
--- @param resolved table
--- @param user_overrides table
--- @param palette_variant string|nil
--- @param is_light_mode boolean
--- @param intensity number
local function apply_palette(resolved, user_overrides, palette_variant, is_light_mode, intensity)
	if not palette_variant then
		return
	end

	local palette_overrides = user_overrides[palette_variant]
	if type(palette_overrides) ~= "table" then
		return
	end

	if is_light_mode then
		apply_light(resolved, palette_overrides, intensity)
	else
		apply_dark(resolved, palette_overrides)
	end
end

--- Resolve multi-level highlight overrides with precedence system
--- @param c table The palette
--- @param palette_name string The palette name (e.g., "oasis_lagoon")
--- @param config table The config object
--- @return table resolved The resolved highlight overrides
function HighlightOverrides.resolve(c, palette_name, config)
	local LIGHT_MODE = c.light_mode or false
	local palette_variant = palette_name and palette_name:gsub("^oasis_", "") or nil
	local resolved = {}
	local user_overrides = normalize(c, config and config.highlight_overrides or {})
	if not user_overrides then
		return resolved
	end

	apply_global(resolved, user_overrides)

	local intensity = c.light_intensity or (config and config.light_intensity) or DEFAULT_LIGHT_INTENSITY
	if LIGHT_MODE then
		apply_global_light(resolved, user_overrides, intensity)
	end

	apply_palette(resolved, user_overrides, palette_variant, LIGHT_MODE, intensity)

	return resolved
end

return HighlightOverrides
