-- lua/oasis/utils.lua
-- Common utilities for Oasis generator scripts

local M = {}

local DEPRECATED_PALETTES = {
	dawn = true,
	dawnlight = true,
	day = true,
	dusk = true,
	dust = true,
}

-- Provide minimal `vim` compatibility when running outside Neovim (e.g., plain lua extras)
-- Only fills missing pieces and never overrides an existing `vim` table/functions.
local function ensure_vim_compat()
	if _G.vim == nil then
		_G.vim = {}
	end

	local function extend_tables(behavior, deep, ...)
		local result = {}
		for i = 1, select("#", ...) do
			local t = select(i, ...)
			if type(t) == "table" then
				for k, v in pairs(t) do
					local has_key = result[k] ~= nil

					if has_key and behavior == "error" then
						error("key already present: " .. k)
					end

					if deep and type(result[k]) == "table" and type(v) == "table" then
						result[k] = extend_tables(behavior, true, result[k], v)
					elseif not has_key or behavior == "force" then
						result[k] = v
					end
				end
			end
		end
		return result
	end

	_G.vim.tbl_extend = _G.vim.tbl_extend
		or function(behavior, ...)
			return extend_tables(behavior, false, ...)
		end

	_G.vim.tbl_deep_extend = _G.vim.tbl_deep_extend
		or function(behavior, ...)
			return extend_tables(behavior, true, ...)
		end

	_G.vim.deepcopy = _G.vim.deepcopy or M.deepcopy
	_G.vim.g = _G.vim.g or {}
	_G.vim.o = _G.vim.o or {}
end

-- Internal helpers
--- Build a palette module name from a bare name or fully-qualified string
--- @param name string Bare palette name (e.g., "lagoon") or module path ("oasis.color_palettes.oasis_lagoon")
--- @return string module_name Fully-qualified module name
local function build_palette_module_name(name)
	-- Accept either a fully qualified module path or a bare palette name
	if name:match("^oasis%.color_palettes%.") then
		return name
	end

	local palette_name = name
	if not palette_name:match("^oasis_") then
		palette_name = "oasis_" .. palette_name
	end

	return "oasis.color_palettes." .. palette_name
end

--- Require a palette module safely
--- @param module_name string Fully-qualified module name
--- @return table|nil palette Loaded palette or nil on failure
--- @return string|nil err Error message when palette is nil
local function require_palette(module_name)
	local ok, palette = pcall(require, module_name)
	if not ok then
		return nil, "Failed to load palette: " .. palette
	end
	return palette, nil
end

--- Extract a specific variant from a palette, handling dual-mode automatically
--- @param palette table Palette table
--- @param mode string|nil Explicit mode to select ("dark" or "light")
--- @param fallback_mode string|nil Mode used when mode is nil (defaults to "dark")
--- @return table|nil extracted Palette variant or original palette for legacy tables
--- @return string|nil err Error message (currently nil, reserved for parity)
local function extract_palette_variant(palette, mode, fallback_mode)
	if M.is_dual_mode_palette(palette) then
		local selected_mode = mode or fallback_mode or "dark"
		return palette[selected_mode], nil
	end
	return palette, nil
end

--- Detect project root directory by looking for lua/oasis/color_palettes/
--- @return string|nil Project root path or nil if not found
function M.find_project_root()
	local handle = assert(io.popen("pwd"))
	local current = handle:read("*l")
	handle:close()

	for _ = 1, 4 do -- current dir + 3 parents
		local test_handle = assert(io.popen("test -d '" .. current .. "/lua/oasis/color_palettes' && echo found"))
		local found = test_handle:read("*l")
		test_handle:close()

		if found == "found" then
			return current
		end

		current = current:match("(.+)/[^/]+$")
		if not current then
			break
		end
	end

	return nil
end

--- Get list of available palette names from filesystem
--- @return table List of palette names without "oasis_" prefix, sorted alphabetically
--- Check if a palette is deprecated
--- @param name string Palette name with or without "oasis_" prefix
--- @return boolean
function M.is_palette_deprecated(name)
	local bare = name:gsub("^oasis_", "")
	return DEPRECATED_PALETTES[bare] == true
end

--- Get list of available palette names from filesystem
--- @param include_deprecated boolean|nil Include deprecated palettes when true
--- @return table List of palette names without "oasis_" prefix, sorted alphabetically
function M.get_palette_names(include_deprecated)
	local allow_deprecated = include_deprecated == true
	local handle = assert(io.popen("ls lua/oasis/color_palettes/oasis_*.lua 2>/dev/null"))
	local result = handle:read("*a")
	handle:close()

	local files = {}
	for file in result:gmatch("[^\n]+") do
		local name = file:match("oasis_(%w+)%.lua")
		if name and (allow_deprecated or not M.is_palette_deprecated(name)) then
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
	return palette.dark ~= nil
		and palette.light ~= nil
		and type(palette.dark) == "table"
		and type(palette.light) == "table"
end

--- Get the mode of a palette ('light', 'dark', or 'dual') by inspecting it.
--- @param palette_name string Palette name (e.g., "oasis_lagoon")
--- @return string|nil mode ('light', 'dark', 'dual') or nil if palette not found
--- @return string|nil err Error message when mode is nil
function M.get_palette_mode(palette_name)
	local palette_module = build_palette_module_name(palette_name)
	local palette, err = require_palette(palette_module)
	if not palette then
		return nil, err
	end

	if M.is_dual_mode_palette(palette) then
		return "dual"
	elseif palette.light_mode == true then
		return "light"
	else
		return "dark"
	end
end

--- Load and extract palette based on current background mode
--- Handles both legacy flat palettes and dual-mode palettes automatically
--- @param palette_name string Palette module name (e.g., "oasis_lagoon")
--- @param explicit_mode string|nil Force a specific mode ("dark" or "light"), overrides background detection
--- @return table|nil, string|nil Extracted palette or nil, error message
function M.load_and_extract_palette(palette_name, explicit_mode)
	local palette, err = require_palette(palette_name)
	if not palette then
		return nil, err
	end

	local auto_mode = (vim.o.background == "light" and "light" or "dark")
	return extract_palette_variant(palette, explicit_mode, auto_mode)
end

--- Load a palette module by name
--- Accepts name with or without "oasis_" prefix
--- @param name string Palette name (e.g., "lagoon" or "oasis_lagoon")
--- @param mode string|nil "dark" or "light" (only used for dual-mode palettes, auto-detects if nil)
--- @return table|nil, string|nil Palette table or nil, error message
function M.load_palette(name, mode)
	-- Add project root to package path
	package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"

	local module_name = build_palette_module_name(name)
	local palette, err = require_palette(module_name)
	if not palette then
		return nil, err
	end

	return extract_palette_variant(palette, mode, "dark")
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
	local capitalized = str:gsub("^%l", string.upper)
	return capitalized
end

--- Format variant name for display (e.g., "lagoon_dark" -> "Oasis Lagoon Dark")
--- @param variant_name string Variant name (e.g., "lagoon_dark", "lagoon_light_3", "dawn")
--- @return string Formatted display name
function M.format_display_name(variant_name)
	-- Strip optional oasis_ prefix to keep display names clean
	local function normalize_base(base)
		base = base:gsub("^oasis_", "")

		-- Title-case underscore-delimited words (e.g., "sea_breeze" -> "Sea Breeze")
		local words = {}
		for word in base:gmatch("[^_]+") do
			table.insert(words, M.capitalize(word))
		end

		return table.concat(words, " ")
	end

	-- Extract parts: base_name, mode (dark/light), intensity (1-5)
	local base_name, intensity

	-- Try to match dark variant
	base_name, _ = variant_name:match("^(.-)_(dark)$")
	if base_name then
		local display_base = normalize_base(base_name)
		return "Oasis " .. display_base .. " Dark"
	end

	-- Try to match light variant with intensity
	base_name, _, intensity = variant_name:match("^(.-)_(light)_(%d+)$")
	if base_name then
		local display_base = normalize_base(base_name)
		return "Oasis " .. display_base .. " Light " .. intensity
	end

	-- Standalone palette (no suffix)
	local display_base = normalize_base(variant_name)
	return "Oasis " .. display_base
end

--- Find files matching a pattern using find command
--- @param pattern string Pattern to search for (e.g., "generate_*.lua")
--- @param directory? string Directory to search in (default: current directory)
--- @return table List of file paths
function M.find_files(pattern, directory)
	directory = directory or "."
	local cmd = string.format("find %s -type f -name '%s' 2>/dev/null | sort", directory, pattern)
	local result = M.execute_command(cmd)
	result = type(result) == "string" and result or ""

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
--- @return string output Command output (stdout + stderr)
--- @return boolean success True when exit code is zero, false otherwise
function M.execute_command(command)
	local handle = assert(io.popen(command .. " 2>&1"), "Failed to execute command: " .. command)
	local output = handle:read("*a")
	local ok = handle:close()
	return output, ok == true
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

-- Initialize compatibility shims once utilities are defined
ensure_vim_compat()

--- Internal iterator over palettes with optional light intensity sweep
--- @param callback function Function(name, palette, mode, intensity) invoked per variant
--- @param include_light_intensity boolean When true, generate 5 light intensity variants; otherwise single light
--- @return number success_count
--- @return number error_count
local function iterate_palettes(callback, include_light_intensity, opts)
	opts = opts or {}
	local include_deprecated = opts.include_deprecated == true
	local allow_legacy = opts.allow_legacy == true

	local palette_names = M.get_palette_names(include_deprecated)
	local success_count = 0
	local error_count = 0

	for _, name in ipairs(palette_names) do
		local ok, raw_palette = pcall(require, "oasis.color_palettes.oasis_" .. name)
		if not ok then
			print(string.format("✗ Failed to load palette: %s", name))
			error_count = error_count + 1
			goto continue
		end

		if M.is_dual_mode_palette(raw_palette) then
			local ok_cb, err = pcall(callback, name, raw_palette.dark, "dark", nil)
			if ok_cb then
				success_count = success_count + 1
			else
				print(string.format("✗ Error processing %s.dark: %s", name, err or "unknown error"))
				error_count = error_count + 1
			end

			if include_light_intensity then
				for intensity = 1, 5 do
					local light_palette = M.generate_light_palette_at_intensity(name, intensity)
					if light_palette then
						ok_cb, err = pcall(callback, name, light_palette, "light", intensity)
						if ok_cb then
							success_count = success_count + 1
						else
							print(
								string.format(
									"✗ Error processing %s.light_%d: %s",
									name,
									intensity,
									err or "unknown error"
								)
							)
							error_count = error_count + 1
						end
					else
						print(
							string.format(
								"✗ Failed to generate light palette for %s at intensity %d",
								name,
								intensity
							)
						)
						error_count = error_count + 1
					end
				end
			else
				local ok_light, err_light = pcall(callback, name, raw_palette.light, "light", nil)
				if ok_light then
					success_count = success_count + 1
				else
					print(string.format("✗ Error processing %s.light: %s", name, err_light or "unknown error"))
					error_count = error_count + 1
				end
			end
		else
			if allow_legacy then
				local ok_cb, err = pcall(callback, name, raw_palette, nil, nil)
				if ok_cb then
					success_count = success_count + 1
				else
					print(string.format("✗ Error processing %s: %s", name, err or "unknown error"))
					error_count = error_count + 1
				end
			else
				print(string.format("↷ Skipping legacy palette (deprecated): %s", name))
			end
		end

		::continue::
	end

	return success_count, error_count
end

--- Iterate over palette modes (dark + light for dual-mode; single call for legacy)
--- @param callback function Function(name, palette, mode) called per variant
--- @param opts table|nil Options: include_deprecated (bool), allow_legacy (bool)
--- @return number success_count
--- @return number error_count
function M.for_each_palette_mode(callback, opts)
	return iterate_palettes(callback, false, opts)
end

--- Generate light palette at specific intensity level
--- @param name string Base palette name (e.g., "lagoon")
--- @param intensity number Intensity level (1-5)
--- @return table|nil Palette with light mode at specified intensity, or nil on error
function M.generate_light_palette_at_intensity(name, intensity)
	local config = require("oasis.config")

	-- Load the raw palette module
	local ok, raw_palette = pcall(require, "oasis.color_palettes.oasis_" .. name)
	if not ok then
		return nil
	end

	-- Only works for dual-mode palettes
	if not M.is_dual_mode_palette(raw_palette) then
		return nil
	end

	-- Save original intensity and set new one
	-- Must modify config.options (not defaults) since palettes call config.get()
	local original_intensity = config.options.light_intensity
	config.options.light_intensity = intensity

	-- Clear the palette from cache and reload with new intensity
	package.loaded["oasis.color_palettes.oasis_" .. name] = nil
	ok, raw_palette = pcall(require, "oasis.color_palettes.oasis_" .. name)

	-- Restore original intensity and clear cache again
	config.options.light_intensity = original_intensity
	package.loaded["oasis.color_palettes.oasis_" .. name] = nil

	if not ok then
		return nil
	end

	return raw_palette.light
end

--- Iterate over all palette modes with intensity variants for dual-mode palettes
--- For dual-mode palettes, generates 1 dark variant + 5 light intensity variants
--- For legacy palettes, calls callback once as before
--- @param callback function Function(name, palette, mode, intensity) called for each variant
---                        - name: base palette name (e.g., "lagoon")
---                        - palette: extracted palette table
---                        - mode: "dark", "light", or nil for legacy palettes
---                        - intensity: 1-5 for light mode, nil for dark mode or legacy palettes
--- @param opts table|nil Options: include_deprecated (bool), allow_legacy (bool)
--- @return number, number Success count, error count
function M.for_each_palette_variant(callback, opts)
	return iterate_palettes(callback, true, opts)
end

--- Build output path for a palette variant
--- All themes go in themes/<palette>/ folders for consistent organization
--- @param base_dir string Base directory (e.g., "extras/alacritty")
--- @param extension string File extension (e.g., "toml", "conf")
--- @param name string Palette name (e.g., "lagoon", "dawn")
--- @param mode string|nil "dark", "light", or nil for standalone palettes
--- @param intensity number|nil Intensity level 1-5 for light mode
--- @return string output_path Full path to output file
--- @return string variant_name Name used in the file (e.g., "lagoon_dark", "dawn")
--- @return string subdir Relative directory under themes/ (e.g., "dark", "light/3")
function M.build_variant_path(base_dir, extension, name, mode, intensity)
	local variant_name
	local subdir

	if mode then
		-- Dual-mode palette
		if mode == "dark" then
			variant_name = name .. "_dark"
			subdir = "dark"
		else
			if not intensity then
				error("Light mode requires an intensity value (1-5)")
			end
			variant_name = name .. "_light_" .. intensity
			subdir = string.format("light/%d", intensity)
		end
	else
		-- Standalone palette (e.g., dawn, day, desert)
		variant_name = name
		subdir = "legacy"
	end

	-- All themes go in themes/<mode>/ (or light/<intensity>) for consistent organization
	local output_dir = string.format("%s/themes/%s", base_dir, subdir)
	os.execute("mkdir -p " .. output_dir)

	local filename
	if extension ~= nil and extension ~= "" then
		filename = string.format("oasis_%s.%s", variant_name, extension)
	else
		filename = string.format("oasis_%s", variant_name)
	end

	local output_path = string.format("%s/%s", output_dir, filename)

	return output_path, variant_name, subdir
end

--- Build a human-friendly output path using the display name (spaces, title case)
--- Keeps directory layout the same but drops underscores from the file name.
--- @param base_dir string Base directory (e.g., "extras/lua-theme")
--- @param extension string File extension (e.g., "lua", "json")
--- @param name string Palette name (e.g., "lagoon")
--- @param mode string|nil "dark", "light", or nil for standalone palettes
--- @param intensity number|nil Intensity level 1-5 for light mode
--- @return string output_path Full path to output file with display name
--- @return string variant_name Internal variant name (e.g., "lagoon_dark")
--- @return string display_name Human-friendly name (e.g., "Oasis Lagoon Dark")
function M.build_display_variant_path(base_dir, extension, name, mode, intensity)
	-- Reuse build_variant_path for variant naming and directory creation
	local _, variant_name, subdir = M.build_variant_path(base_dir, extension, name, mode, intensity)
	local display_name = M.format_display_name(variant_name)

	local output_dir = string.format("%s/themes/%s", base_dir, subdir)
	os.execute("mkdir -p " .. output_dir)

	local filename
	if extension ~= nil and extension ~= "" then
		filename = string.format("%s.%s", display_name, extension)
	else
		filename = display_name
	end
	local output_path = string.format("%s/%s", output_dir, filename)

	return output_path, variant_name, display_name
end

return M
