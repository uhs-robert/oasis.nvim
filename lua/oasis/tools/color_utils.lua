-- lua/oasis/tools/color_utils.lua
-- Color manipulation utilities for theme generation

local M = {}

--- Add alpha channel to hex color
--- @param color string Hex color (e.g., "#1a1a1a")
--- @param alpha string Alpha as 2-digit hex (e.g., "3d" for ~24% opacity)
--- @return string Hex color with alpha channel (e.g., "#1a1a1a3d")
function M.with_alpha(color, alpha)
	if not color or color == "NONE" or color == "" then
		return "#00000000"
	end
	-- Remove any existing alpha
	local hex = color:match("^#?(%x+)")
	if not hex then
		return "#00000000"
	end
	if #hex == 8 then
		hex = hex:sub(1, 6)
	end
	return "#" .. hex .. alpha
end

--- Adjust color brightness by multiplying RGB values
--- @param color string Hex color (e.g., "#808080")
--- @param factor number Multiplier (>1 for lighter, <1 for darker)
--- @return string Adjusted hex color
function M.adjust_brightness(color, factor)
	if not color or color == "NONE" then
		return color
	end

	local hex = color:match("^#?(%x%x)(%x%x)(%x%x)")
	if not hex then
		return color
	end

	local r, g, b = color:match("^#?(%x%x)(%x%x)(%x%x)")
	r = tonumber(r, 16)
	g = tonumber(g, 16)
	b = tonumber(b, 16)

	r = math.floor(math.min(255, math.max(0, r * factor)))
	g = math.floor(math.min(255, math.max(0, g * factor)))
	b = math.floor(math.min(255, math.max(0, b * factor)))

	return string.format("#%02x%02x%02x", r, g, b)
end

--- Convert hex color to RGB decimal format "R,G,B"
--- @param hex string Hex color (e.g., "#808080" or "808080")
--- @return string RGB decimal string (e.g., "128,128,128")
function M.hex_to_rgb(hex)
	if not hex or hex == "NONE" then
		return "0,0,0"
	end

	-- Remove # if present
	hex = hex:gsub("#", "")

	-- Convert hex to RGB
	local r = tonumber(hex:sub(1, 2), 16)
	local g = tonumber(hex:sub(3, 4), 16)
	local b = tonumber(hex:sub(5, 6), 16)

	return string.format("%d,%d,%d", r, g, b)
end

--- Escape string for JSON encoding
--- @param str string Input string
--- @return string JSON-escaped string
function M.json_escape(str)
	if type(str) ~= "string" then
		return str
	end
	return str:gsub("\\", "\\\\"):gsub('"', '\\"'):gsub("\n", "\\n"):gsub("\r", "\\r"):gsub("\t", "\\t")
end

--- Simple JSON encoder for theme generation
--- Converts Lua tables to formatted JSON with proper indentation
--- @param obj table|string|number|boolean|nil Object to encode
--- @param indent? number Indentation level (default: 0)
--- @return string JSON-encoded string
function M.encode_json(obj, indent)
	indent = indent or 0
	local indent_str = string.rep("  ", indent)
	local next_indent_str = string.rep("  ", indent + 1)

	if type(obj) == "string" then
		return '"' .. M.json_escape(obj) .. '"'
	elseif type(obj) == "number" or type(obj) == "boolean" then
		return tostring(obj)
	elseif type(obj) == "nil" then
		return "null"
	elseif type(obj) == "table" then
		-- Check if it's an array
		local is_array = false
		local max_index = 0
		for k, _ in pairs(obj) do
			if type(k) == "number" and k > 0 then
				is_array = true
				max_index = math.max(max_index, k)
			else
				is_array = false
				break
			end
		end

		if is_array and max_index == #obj then
			-- Array
			local parts = {}
			for i = 1, #obj do
				table.insert(parts, next_indent_str .. M.encode_json(obj[i], indent + 1))
			end
			if #parts == 0 then
				return "[]"
			end
			return "[\n" .. table.concat(parts, ",\n") .. "\n" .. indent_str .. "]"
		else
			-- Object
			local parts = {}
			local keys = {}
			for k in pairs(obj) do
				table.insert(keys, k)
			end
			table.sort(keys)

			for _, k in ipairs(keys) do
				local v = obj[k]
				local key_str = '"' .. M.json_escape(tostring(k)) .. '"'
				local value_str = M.encode_json(v, indent + 1)
				table.insert(parts, next_indent_str .. key_str .. ": " .. value_str)
			end

			if #parts == 0 then
				return "{}"
			end
			return "{\n" .. table.concat(parts, ",\n") .. "\n" .. indent_str .. "}"
		end
	end

	return "null"
end

return M
