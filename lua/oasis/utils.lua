-- lua/oasis/utils.lua
-- Common utilities for Oasis generator scripts

local M = {}

--- Detect project root directory by looking for lua/oasis/color_palettes/
--- @return string|nil Project root path or nil if not found
function M.find_project_root()
	-- Try current directory first
	local handle = assert(io.popen("test -d lua/oasis/color_palettes && pwd"))
	local result = handle:read("*l")
	handle:close()

	if result and result ~= "" then
		return result
	end

	-- Walk up directory tree
	handle = assert(io.popen("pwd"))
	local current = handle:read("*l")
	handle:close()

	-- Try up to 3 levels up
	for _ = 1, 3 do
		local test_path = current .. "/lua/oasis/color_palettes"
		local test_handle = assert(io.popen("test -d '" .. test_path .. "' && echo 'found'"))
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

--- Detect if a palette uses dual-mode structure (has .dark and .light keys)
--- @param palette table Palette table
--- @return boolean True if dual-mode palette
function M.is_dual_mode_palette(palette)
	return palette.dark ~= nil and palette.light ~= nil and type(palette.dark) == "table" and type(palette.light) == "table"
end

--- Load and extract palette based on current background mode
--- Handles both legacy flat palettes and dual-mode palettes automatically
--- @param palette_name string Palette module name (e.g., "oasis_lagoon")
--- @return table|nil, string|nil Extracted palette or nil, error message
function M.load_and_extract_palette(palette_name)
	-- Load the palette module
	local ok, palette = pcall(require, palette_name)
	if not ok then
		return nil, "Failed to load palette: " .. palette
	end

	-- If dual-mode, extract the appropriate mode based on background
	if M.is_dual_mode_palette(palette) then
		local mode = vim.o.background == "light" and "light" or "dark"
		return palette[mode], nil
	end

	-- Legacy flat palette - return as-is
	return palette, nil
end

--- Load a palette module by name
--- Accepts name with or without "oasis_" prefix
--- @param name string Palette name (e.g., "lagoon" or "oasis_lagoon")
--- @param mode string|nil "dark" or "light" (only used for dual-mode palettes, auto-detects if nil)
--- @return table|nil, string|nil Palette table or nil, error message
function M.load_palette(name, mode)
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

	-- If dual-mode palette, extract requested mode
	if M.is_dual_mode_palette(palette) then
		local selected_mode = mode or "dark" -- Default to dark if not specified
		return palette[selected_mode], nil
	end

	-- Legacy flat palette - return as-is
	return palette, nil
end

--- Write content to file
--- @param path string File path
--- @param content string Content to write
function M.write_file(path, content)
	local file = assert(io.open(path, "w"), "Could not open file for writing: " .. path)
	file:write(content)
	file:close()
end

--- Read file content
--- @param path string File path
--- @return string File content
function M.read_file(path)
	local file = assert(io.open(path, "r"), "Could not open file for reading: " .. path)
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

--- Find files matching a pattern using find command
--- @param pattern string Pattern to search for (e.g., "generate_*.lua")
--- @param directory? string Directory to search in (default: current directory)
--- @return table List of file paths
function M.find_files(pattern, directory)
	directory = directory or "."
	local cmd = string.format("find %s -type f -name '%s' 2>/dev/null | sort", directory, pattern)
	local handle = assert(io.popen(cmd), "Failed to execute find command")
	local result = handle:read("*a")
	handle:close()

	local files = {}
	for path in result:gmatch("[^\n]+") do
		if path ~= "" then
			table.insert(files, path)
		end
	end

	return files
end

--- Execute a shell command and capture output
--- @param command string Command to execute
--- @return string, boolean Output string, success boolean
function M.execute_command(command)
	local handle = assert(io.popen(command .. " 2>&1"), "Failed to execute command: " .. command)
	local output = handle:read("*a")
	local success = handle:close()
	return output, success
end

--- Deep copy a table (recursive)
--- @param orig any Value to copy
--- @return any Deep copy of the value
function M.deepcopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == "table" then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[M.deepcopy(orig_key)] = M.deepcopy(orig_value)
		end
		setmetatable(copy, M.deepcopy(getmetatable(orig)))
	else
		copy = orig
	end
	return copy
end

return M
