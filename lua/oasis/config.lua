-- lua/oasis/config.lua

local M = {}

-- Default configuration
M.defaults = {
	style = nil, -- Shorthand palette name (e.g., "lagoon" -> "oasis_lagoon")
	dark_style = "lagoon", -- Shorthand palette name for dark mode
	light_style = "day", -- Shorthand palette name for light mode
	use_legacy_comments = false,
	palette_overrides = {},
	highlight_overrides = {},

	-- Text styling toggles
	styles = {
		bold = true,          -- Enable/disable bold text
		italic = true,        -- Enable/disable italic text
		underline = true,     -- Enable/disable underline
		undercurl = true,     -- Enable/disable undercurl (diagnostics, spell)
		strikethrough = true, -- Enable/disable strikethrough
	},

	-- Additional toggles
	terminal_colors = true,   -- Enable/disable terminal color setting
	transparent = false,      -- Make backgrounds transparent (NONE)
}

-- Current active configuration
M.options = vim.deepcopy(M.defaults)

--- Deep merge two tables
---@param base table The base table
---@param override table The table to merge on top
---@return table merged The merged result
local function deep_merge(base, override)
	local result = vim.deepcopy(base)

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
---@return string palette_name Full palette name (e.g., "oasis_lagoon"), always returns a valid palette
function M.get_palette_name()
	if M.options.style then
		return "oasis_" .. M.options.style
	end

	-- If style is not set, use dark_style/light_style based on background
	local bg = vim.o.background
	if bg == "light" and M.options.light_style then
		return "oasis_" .. M.options.light_style
	elseif M.options.dark_style then
		return "oasis_" .. M.options.dark_style
	end

	-- Final fallback: check vim.o.background and return appropriate default
	return bg == "light" and "oasis_day" or "oasis_lagoon"
end

--- Apply palette overrides to a loaded palette
---@param palette table The base palette
---@param palette_name string The name of the palette (e.g., "oasis_desert")
---@return table palette The palette with overrides applied
function M.apply_palette_overrides(palette, palette_name)
	local result = vim.deepcopy(palette)

	-- Apply desert legacy comment color override if enabled
	local use_legacy_comments = M.options.useLegacyComments or M.options.use_legacy_comments
	if use_legacy_comments and palette_name == "oasis_desert" then
		result.syntax = result.syntax or {}
		result.syntax.comment = "#87CEEB"
	end

	-- Apply user palette overrides
	if M.options.palette_overrides[palette_name] then
		result = deep_merge(result, M.options.palette_overrides[palette_name])
	end

	return result
end

return M
