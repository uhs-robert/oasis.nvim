-- lua/oasis/config.lua

local M = {}

-- Default configuration
M.defaults = {
	useLegacyComments = false,
	palette_overrides = {},
	highlight_overrides = {},
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

--- Apply palette overrides to a loaded palette
---@param palette table The base palette
---@param palette_name string The name of the palette (e.g., "oasis_desert")
---@return table palette The palette with overrides applied
function M.apply_palette_overrides(palette, palette_name)
	local result = vim.deepcopy(palette)

	-- Apply legacy comment color if enabled
	if M.options.useLegacyComments and palette_name == "oasis_desert" then
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
