-- lua/oasis/utils.lua
-- Common utilities for Oasis generator scripts

local M = {}

--- Detect project root directory by looking for lua/oasis/color_palettes/
--- @return string|nil Project root path or nil if not found
function M.find_project_root()
	-- Try current directory first
	local handle = io.popen("test -d lua/oasis/color_palettes && pwd")
	local result = handle:read("*l")
	handle:close()

	if result and result ~= "" then
		return result
	end

	-- Walk up directory tree
	handle = io.popen("pwd")
	local current = handle:read("*l")
	handle:close()

	-- Try up to 3 levels up
	for _ = 1, 3 do
		local test_path = current .. "/lua/oasis/color_palettes"
		local test_handle = io.popen("test -d '" .. test_path .. "' && echo 'found'")
		local test_result = test_handle:read("*l")
		test_handle:close()

		if test_result == "found" then
			return current
		end

		-- Go up one level
		current = current:match("(.+)/[^/]+$")
		if not current then
			break
		end
	end

	return nil
end

--- Get list of available palette names from filesystem
--- @return table List of palette names without "oasis_" prefix, sorted alphabetically
function M.get_palette_names()
	local handle = assert(io.popen("ls lua/oasis/color_palettes/oasis_*.lua 2>/dev/null"))
	local result = handle:read("*a")
	handle:close()

	local files = {}
	for file in result:gmatch("[^\n]+") do
		local name = file:match("oasis_(%w+)%.lua")
		if name then
			table.insert(files, name)
		end
	end

	table.sort(files)
	return files
end

--- Load a palette module by name
--- Accepts name with or without "oasis_" prefix
--- @param name string Palette name (e.g., "lagoon" or "oasis_lagoon")
--- @return table|nil, string|nil Palette table or nil, error message
function M.load_palette(name)
	-- Add project root to package path
	package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"

	-- Normalize name - add "oasis_" prefix if missing
	local palette_name = name
	if not name:match("^oasis_") then
		palette_name = "oasis_" .. name
	end

	local ok, palette = pcall(require, "oasis.color_palettes." .. palette_name)

	if not ok then
		return nil, "Failed to load palette: " .. palette
	end

	return palette
end

--- Write content to file with error handling
--- @param path string File path
--- @param content string Content to write
--- @return boolean, string|nil Success status, error message if failed
function M.write_file(path, content)
	local file = io.open(path, "w")
	if not file then
		return false, "Could not open file for writing: " .. path
	end

	file:write(content)
	file:close()
	return true
end

--- Read file content with error handling
--- @param path string File path
--- @return string|nil, string|nil Content or nil, error message if failed
function M.read_file(path)
	local file = io.open(path, "r")
	if not file then
		return nil, "Could not open file for reading: " .. path
	end

	local content = file:read("*a")
	file:close()
	return content
end

--- Capitalize first letter of string
--- @param str string Input string
--- @return string String with first letter capitalized
function M.capitalize(str)
	return str:gsub("^%l", string.upper)
end

return M
