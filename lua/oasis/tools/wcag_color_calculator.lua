-- lua/oasis/tools/wcag_color_calculator.lua
-- WCAG Color Calculator for Oasis Theme
-- Calculates AAA-compliant colors while maintaining hue and saturation

local M = {}

-- WCAG contrast ratio standards
M.STANDARDS = {
	AAA_NORMAL = 7.05, -- With a little wiggle room!
	AAA_LARGE = 4.5,
	AA_NORMAL = 4.5,
	AA_LARGE = 3.0,
}

---@class Color
---@field r number Red component (0-1)
---@field g number Green component (0-1)
---@field b number Blue component (0-1)
local Color = {}
Color.__index = Color

--- Create a new Color from RGB values (0-1)
---@param r number Red (0-1)
---@param g number Green (0-1)
---@param b number Blue (0-1)
---@return Color
function Color.new(r, g, b)
	local self = setmetatable({}, Color)
	self.r = r
	self.g = g
	self.b = b
	return self
end

--- Create a Color from hex string
---@param hex string Hex color like "#1a1a1a"
---@return Color
function Color.from_hex(hex)
	if not hex or type(hex) ~= "string" then
		return Color.new(0, 0, 0)
	end
	hex = hex:gsub("#", "")
	local r = tonumber(hex:sub(1, 2), 16) / 255
	local g = tonumber(hex:sub(3, 4), 16) / 255
	local b = tonumber(hex:sub(5, 6), 16) / 255
	return Color.new(r, g, b)
end

--- Convert Color to hex string
---@return string Hex color like "#1a1a1a"
function Color:to_hex()
	local function clamp(val)
		return math.max(0, math.min(255, math.floor(val * 255 + 0.5)))
	end
	return string.format("#%02x%02x%02x", clamp(self.r), clamp(self.g), clamp(self.b))
end

--- Convert RGB to HSL
---@return number, number, number Hue (0-1), Saturation (0-1), Lightness (0-1)
function Color:to_hsl()
	local max_val = math.max(self.r, self.g, self.b)
	local min_val = math.min(self.r, self.g, self.b)
	local delta = max_val - min_val

	local lightness = (max_val + min_val) / 2

	if delta == 0 then
		return 0, 0, lightness
	end

	-- Calculate saturation
	local saturation
	if lightness > 0.5 then
		saturation = delta / (2.0 - max_val - min_val)
	else
		saturation = delta / (max_val + min_val)
	end

	-- Calculate hue
	local hue
	if max_val == self.r then
		hue = ((self.g - self.b) / delta + (self.g < self.b and 6 or 0)) / 6
	elseif max_val == self.g then
		hue = ((self.b - self.r) / delta + 2) / 6
	else
		hue = ((self.r - self.g) / delta + 4) / 6
	end

	return hue, saturation, lightness
end

--- Create a Color from HSL values
---@param hue number Hue (0-1)
---@param saturation number Saturation (0-1)
---@param lightness number Lightness (0-1)
---@return Color
function Color.from_hsl(hue, saturation, lightness)
	if saturation == 0 then
		return Color.new(lightness, lightness, lightness)
	end

	local function hue_to_rgb(p, q, t)
		if t < 0 then
			t = t + 1
		end
		if t > 1 then
			t = t - 1
		end
		if t < 1 / 6 then
			return p + (q - p) * 6 * t
		end
		if t < 1 / 2 then
			return q
		end
		if t < 2 / 3 then
			return p + (q - p) * (2 / 3 - t) * 6
		end
		return p
	end

	local q
	if lightness < 0.5 then
		q = lightness * (1 + saturation)
	else
		q = lightness + saturation - lightness * saturation
	end
	local p = 2 * lightness - q

	local r = hue_to_rgb(p, q, hue + 1 / 3)
	local g = hue_to_rgb(p, q, hue)
	local b = hue_to_rgb(p, q, hue - 1 / 3)

	return Color.new(r, g, b)
end

--- Linearize RGB component for luminance calculation
---@param value number RGB component (0-1)
---@return number Linearized value
local function linearize_component(value)
	if value <= 0.03928 then
		return value / 12.92
	else
		return ((value + 0.055) / 1.055) ^ 2.4
	end
end

--- Calculate relative luminance per WCAG formula
---@param color Color
---@return number Relative luminance (0-1)
local function relative_luminance(color)
	local r = linearize_component(color.r)
	local g = linearize_component(color.g)
	local b = linearize_component(color.b)
	return 0.2126 * r + 0.7152 * g + 0.0722 * b
end

--- Calculate contrast ratio between two colors
---@param color1 Color|string First color (Color object or hex string)
---@param color2 Color|string Second color (Color object or hex string)
---@return number Contrast ratio
function M.contrast_ratio(color1, color2)
	if type(color1) == "string" then
		color1 = Color.from_hex(color1)
	end
	if type(color2) == "string" then
		color2 = Color.from_hex(color2)
	end

	local l1 = relative_luminance(color1)
	local l2 = relative_luminance(color2)
	local lighter = math.max(l1, l2)
	local darker = math.min(l1, l2)
	return (lighter + 0.05) / (darker + 0.05)
end

--- Get compliance level for a contrast ratio
---@param ratio number Contrast ratio
---@param large_text? boolean Whether text is large (18pt+ or 14pt+ bold)
---@return string Compliance level: "AAA", "AA", "Fail"
function M.get_compliance_level(ratio, large_text)
	local threshold = large_text and M.STANDARDS.AAA_LARGE or M.STANDARDS.AAA_NORMAL
	if ratio >= threshold then
		return "AAA"
	end
	threshold = large_text and M.STANDARDS.AA_LARGE or M.STANDARDS.AA_NORMAL
	if ratio >= threshold then
		return "AA"
	end
	return "Fail"
end

--- Adjust color lightness to meet target contrast ratio using binary search
---@param hex_color string Foreground color in hex
---@param background_hex string Background color in hex
---@param target_ratio number Target contrast ratio (default: AAA_NORMAL)
---@param max_iterations? number Maximum iterations for binary search (default: 100)
---@return string, number Adjusted hex color and achieved contrast ratio
function M.adjust_for_target(hex_color, background_hex, target_ratio, max_iterations)
	target_ratio = target_ratio or M.STANDARDS.AAA_NORMAL
	max_iterations = max_iterations or 100

	local color = Color.from_hex(hex_color)
	local background = Color.from_hex(background_hex)
	local hue, saturation, _ = color:to_hsl()
	local _, _, bg_lightness = background:to_hsl()

	-- Determine search direction based on background
	local search_lighter = bg_lightness < 0.5

	-- Binary search state
	local min_l = 0.0
	local max_l = 1.0
	local best_color = hex_color
	local best_ratio = M.contrast_ratio(color, background)

	for _ = 1, max_iterations do
		-- Check if search range is valid
		if math.abs(max_l - min_l) < 0.001 then
			break
		end

		local test_l = (min_l + max_l) / 2
		local test_color = Color.from_hsl(hue, saturation, test_l)
		local test_hex = test_color:to_hex()
		local test_ratio = M.contrast_ratio(test_color, background)

		-- Found target within tolerance
		if math.abs(test_ratio - target_ratio) < 0.01 then
			return test_hex, test_ratio
		end

		-- Update search boundaries
		local needs_more_contrast = test_ratio < target_ratio
		if search_lighter == needs_more_contrast then
			min_l = test_l
		else
			max_l = test_l
		end

		-- Update best color when we have sufficient contrast
		if not needs_more_contrast then
			best_color = test_hex
			best_ratio = test_ratio
		end
	end

	return best_color, best_ratio
end

--- Calculate AAA-compliant versions of multiple colors
---@param colors table<string, string|table> Map of color names to hex strings or {hex, target}
---@param background_hex string Background color
---@return table Results with original, new, current_ratio, new_ratio for each color
function M.calculate_batch(colors, background_hex)
	local results = {}

	for name, color_data in pairs(colors) do
		local original_hex, target
		if type(color_data) == "table" then
			original_hex = color_data.hex or color_data[1]
			target = color_data.target or color_data[2] or M.STANDARDS.AAA_NORMAL
		else
			original_hex = color_data
			target = M.STANDARDS.AAA_NORMAL
		end

		local current_ratio = M.contrast_ratio(original_hex, background_hex)
		local new_hex, new_ratio = M.adjust_for_target(original_hex, background_hex, target)

		results[name] = {
			original = original_hex,
			new = new_hex,
			current_ratio = current_ratio,
			new_ratio = new_ratio,
			target = target,
		}
	end

	return results
end

--- Format and print results table
---@param results table Results from calculate_batch
---@param background_hex string Background color used
---@param title? string Optional title
function M.print_results(results, background_hex, title)
	print("\n" .. string.rep("=", 80))
	print(title or ("AAA Color Calculations for background: " .. background_hex))
	print(string.rep("=", 80) .. "\n")

	-- Calculate max name length for alignment
	local max_name_len = 0
	for name, _ in pairs(results) do
		max_name_len = math.max(max_name_len, #name)
	end

	-- Sort by name and print
	local sorted_names = {}
	for name, _ in pairs(results) do
		table.insert(sorted_names, name)
	end
	table.sort(sorted_names)

	for _, name in ipairs(sorted_names) do
		local data = results[name]
		local status = data.current_ratio >= data.target and "✓" or "✗"
		local padding = string.rep(" ", max_name_len - #name)

		print(
			string.format(
				"%s:%s %s → %s (%5.2f:1 → %5.2f:1) %s",
				name,
				padding,
				data.original,
				data.new,
				data.current_ratio,
				data.new_ratio,
				status
			)
		)
	end
	print()
end

--- Load a palette and extract colors for WCAG checking
---@param palette_name string Palette name like "oasis_lagoon"
---@return table|nil, string|nil Palette colors or nil, error message
function M.load_palette(palette_name)
	-- Ensure palette name has oasis_ prefix
	if not palette_name:match("^oasis_") then
		palette_name = "oasis_" .. palette_name
	end

	local ok, palette = pcall(require, "oasis.color_palettes." .. palette_name)
	if not ok then
		return nil, "Failed to load palette: " .. palette_name
	end

	return palette, nil
end

--- Load a palette with specific config options temporarily
---@param palette_name string Palette name like "oasis_lagoon"
---@param temp_config table Temporary config options to apply
---@return table|nil, string|nil Palette colors or nil, error message
function M.load_palette_with_config(palette_name, temp_config)
	-- Ensure palette name has oasis_ prefix
	if not palette_name:match("^oasis_") then
		palette_name = "oasis_" .. palette_name
	end

	-- Save current config
	local config = require("oasis.config")
	local original_config = vim.deepcopy(config.get())

	-- Apply temporary config
	for key, value in pairs(temp_config) do
		config.options[key] = value
	end

	-- Clear palette cache to force reload with new config
	package.loaded["oasis.color_palettes." .. palette_name] = nil

	-- Load palette with new config
	local ok, palette = pcall(require, "oasis.color_palettes." .. palette_name)

	-- Restore original config
	config.options = original_config

	-- Clear cache again to ensure next load uses current config
	package.loaded["oasis.color_palettes." .. palette_name] = nil

	if not ok then
		return nil, "Failed to load palette: " .. palette_name
	end

	return palette, nil
end

--- Extract colors from palette for WCAG testing
---@param palette table Loaded palette
---@return table Colors map for batch processing
function M.extract_colors_from_palette(palette)
	local colors = {}

	-- Syntax colors
	if palette.syntax then
		for key, value in pairs(palette.syntax) do
			if type(value) == "string" and value:match("^#") then
				colors["syntax." .. key] = value
			end
		end
	end

	-- Theme colors
	if palette.theme then
		for key, value in pairs(palette.theme) do
			if type(value) == "string" and value:match("^#") then
				colors["theme." .. key] = value
			end
		end
	end

	-- Foreground colors
	if palette.fg then
		for key, value in pairs(palette.fg) do
			if type(value) == "string" and value:match("^#") then
				colors["fg." .. key] = value
			end
		end
	end

	-- UI colors
	if palette.ui then
		for key, value in pairs(palette.ui) do
			if type(value) == "string" and value:match("^#") then
				colors["ui." .. key] = value
			end
		end
	end

	-- Terminal colors
	if palette.terminal then
		for key, value in pairs(palette.terminal) do
			if type(value) == "string" and value:match("^#") then
				colors["terminal." .. key] = value
			end
		end
	end

	return colors
end

--- Analyze a palette for WCAG compliance
---@param palette_name string Palette name like "oasis_lagoon"
---@param target_ratio? number Default target contrast ratio (default: AAA_NORMAL)
---@param custom_targets? table<string, number> Custom targets for specific colors (e.g., { ["fg.comment"] = 4.5 })
---@return table|nil, string|nil Results or nil, error message
function M.analyze_palette(palette_name, target_ratio, custom_targets)
	target_ratio = target_ratio or M.STANDARDS.AAA_NORMAL
	custom_targets = custom_targets or {}

	local palette, err = M.load_palette(palette_name)
	if not palette then
		return nil, err
	end

	local background = palette.bg and palette.bg.core or "#000000"
	local colors = M.extract_colors_from_palette(palette)

	if next(colors) == nil then
		return nil, "No colors found in palette"
	end

	-- Apply custom targets to specific colors
	for color_name, hex_value in pairs(colors) do
		if custom_targets[color_name] then
			-- Convert to table format with custom target
			colors[color_name] = { hex = hex_value, target = custom_targets[color_name] }
		end
	end

	local results = M.calculate_batch(colors, background)
	return results, nil
end

--- Process a palette and print results
---@param palette_name string Palette name
---@param target_ratio? number Default target contrast ratio
---@param custom_targets? table<string, number> Custom targets for specific colors
function M.check_palette(palette_name, target_ratio, custom_targets)
	local results, err = M.analyze_palette(palette_name, target_ratio, custom_targets)
	if not results then
		print("Error: " .. err)
		return
	end

	local palette, _ = M.load_palette(palette_name)
	local background = (palette and palette.bg and palette.bg.core) or "#000000"

	M.print_results(results, background, "WCAG AAA: Actual Calculations for `" .. palette_name .. "`")
end

--- Analyze a palette with specific config options (e.g., themed_syntax)
---@param palette_name string Palette name like "oasis_lagoon"
---@param config_opts table Config options to apply (e.g., {themed_syntax = true})
---@param target_ratio? number Default target contrast ratio (default: AAA_NORMAL)
---@param custom_targets? table<string, number> Custom targets for specific colors
---@return table|nil, string|nil Results or nil, error message
function M.analyze_palette_with_config(palette_name, config_opts, target_ratio, custom_targets)
	target_ratio = target_ratio or M.STANDARDS.AAA_NORMAL
	custom_targets = custom_targets or {}

	local palette, err = M.load_palette_with_config(palette_name, config_opts)
	if not palette then
		return nil, err
	end

	local background = palette.bg and palette.bg.core or "#000000"
	local colors = M.extract_colors_from_palette(palette)

	if next(colors) == nil then
		return nil, "No colors found in palette"
	end

	-- Apply custom targets to specific colors
	for color_name, hex_value in pairs(colors) do
		if custom_targets[color_name] then
			-- Convert to table format with custom target
			colors[color_name] = { hex = hex_value, target = custom_targets[color_name] }
		end
	end

	local results = M.calculate_batch(colors, background)
	return results, nil
end

--- Check palette with specific config options and print results
---@param palette_name string Palette name
---@param config_opts table Config options (e.g., {themed_syntax = true})
---@param target_ratio? number Default target contrast ratio
---@param custom_targets? table<string, number> Custom targets for specific colors
function M.check_palette_with_config(palette_name, config_opts, target_ratio, custom_targets)
	local results, err = M.analyze_palette_with_config(palette_name, config_opts, target_ratio, custom_targets)
	if not results then
		print("Error: " .. err)
		return
	end

	local palette, _ = M.load_palette_with_config(palette_name, config_opts)
	local background = (palette and palette.bg and palette.bg.core) or "#000000"

	-- Build title with config options
	local title = "WCAG AAA: Actual Calculations for `" .. palette_name .. "`"
	if config_opts.themed_syntax then
		title = title .. " (themed_syntax = true)"
	end

	M.print_results(results, background, title)
end

-- Preset color collections for Oasis themes (reference colors to test)
M.PRESETS = {
	-- Custom target overrides for light themes
	LIGHT_TARGETS = {
		["fg.core"] = M.STANDARDS.AAA_NORMAL + 2,
		["syntax.punctuation"] = M.STANDARDS.AAA_NORMAL + 1,
		["syntax.operator"] = M.STANDARDS.AAA_NORMAL + 0.5,
		["syntax.conditional"] = M.STANDARDS.AAA_NORMAL + 1,
		["fg.comment"] = M.STANDARDS.AA_NORMAL,
		["syntax.comment"] = M.STANDARDS.AA_NORMAL,
		["fg.dim"] = M.STANDARDS.AA_NORMAL + 1.75,
		["ui.nontext"] = M.STANDARDS.AA_NORMAL + 1.75,
		["fg.muted"] = M.STANDARDS.AA_NORMAL + 2.25,
	},

	-- Custom target overrides for dark themes
	DARK_TARGETS = {
		["fg.comment"] = M.STANDARDS.AA_NORMAL - 0.64,
		["syntax.comment"] = M.STANDARDS.AA_NORMAL - 0.65,
		["fg.dim"] = M.STANDARDS.AA_NORMAL - 1.75,
		["ui.nontext"] = M.STANDARDS.AA_NORMAL - 1.75,
		["fg.muted"] = M.STANDARDS.AA_NORMAL - 2.25,
	},

	-- Base "typical" colors - reference palette for testing
	BASE_COLORS = {
		-- Syntax - Cold (Data)
		parameter = "#C28EFF",
		identifier = "#FFD393",
		type = "#81C0B6",
		builtinVar = "#61AEFF",
		string = "#53D390",
		regex = "#96EA7F",
		builtinConst = "#5ABAAE",

		-- Syntax - Warm (Control/Flow)
		constant = "#F8944D",
		func = "#F8B471",
		builtinFunc = "#F49F15",
		builtinFuncAlt = "#E67451",
		statement = "#F0E68C",
		exception = "#ED7777",
		conditional = "#BDB76B",
		special = "#FFA852",
		operator = "#FFA0A0",
		punctuation = "#F09595",
		preproc = "#38D0EF",

		-- Syntax - Neutral
		bracket = "#B5ADA0",

		-- UI
		theme_primary = "#CD5C5C",
		match = "#FFA247",
		dir = "#87CEEB",

		-- Diagnostics
		error = "#D06666",
		warn = "#EEEE00",
		info = "#87CEEB",
		hint = "#8FD1C7",
	},
}

-- Light palette = base + light-only tweaks
M.PRESETS.LIGHT_COLORS = {}
for k, v in pairs(M.PRESETS.BASE_COLORS) do
	M.PRESETS.LIGHT_COLORS[k] = v
end
M.PRESETS.LIGHT_COLORS.identifier = "#6E7D8D"
M.PRESETS.LIGHT_COLORS.theme_primary = { hex = M.PRESETS.BASE_COLORS.theme_primary, target = 5.0 }
M.PRESETS.LIGHT_COLORS.operator = { hex = M.PRESETS.BASE_COLORS.operator, target = 9.0 }
M.PRESETS.LIGHT_COLORS.punctuation = { hex = M.PRESETS.BASE_COLORS.punctuation, target = 8.0 }

-- Dark palette = base + dark-only tweaks
M.PRESETS.DARK_COLORS = {}
for k, v in pairs(M.PRESETS.BASE_COLORS) do
	M.PRESETS.DARK_COLORS[k] = v
end
M.PRESETS.DARK_COLORS.theme_primary = { hex = M.PRESETS.BASE_COLORS.theme_primary, target = 5.0 }
M.PRESETS.DARK_COLORS.operator = { hex = M.PRESETS.BASE_COLORS.operator, target = 9.0 }
M.PRESETS.DARK_COLORS.punctuation = { hex = M.PRESETS.BASE_COLORS.punctuation, target = 8.0 }

--- Discover all available palettes dynamically from filesystem
---@return table, table Light palette names, Dark palette names
function M.discover_palettes()
	local light_palettes = {}
	local dark_palettes = {}

	-- Try to find the actual palette directory
	local search_paths = {
		"lua/oasis/color_palettes",
		"../oasis/color_palettes",
		"./lua/oasis/color_palettes",
	}

	-- Read directory listing - try different methods
	local palette_files = {}
	local found_dir = false

	for _, path in ipairs(search_paths) do
		local handle = io.popen("ls " .. path .. " 2>/dev/null")
		if handle then
			local result = handle:read("*a")
			handle:close()
			if result and result ~= "" then
				found_dir = true
				for file in result:gmatch("[^\n]+") do
					if file:match("^oasis_.*%.lua$") then
						local name = file:gsub("%.lua$", "")
						palette_files[#palette_files + 1] = name
					end
				end
				break
			end
		end
	end

	-- If we couldn't find files, return empty lists (fail gracefully)
	if not found_dir or #palette_files == 0 then
		return light_palettes, dark_palettes
	end

	-- Load each palette and check if it's light or dark
	for _, palette_name in ipairs(palette_files) do
		local palette, _ = M.load_palette(palette_name)
		if palette then
			if palette.light_mode then
				light_palettes[#light_palettes + 1] = palette_name
			else
				dark_palettes[#dark_palettes + 1] = palette_name
			end
		end
	end

	-- Sort alphabetically
	table.sort(light_palettes)
	table.sort(dark_palettes)

	return light_palettes, dark_palettes
end

--- Check preset colors against a specific theme (loads actual bg.core from palette)
---@param palette_name string Full palette name like "oasis_lagoon"
---@param color_set table Color set to test (LIGHT_COLORS or DARK_COLORS)
---@return table|nil, string|nil, string|nil Results
function M.check_preset_theme(palette_name, color_set)
	-- Load actual palette to get real bg.core
	local palette, err = M.load_palette(palette_name)
	if not palette then
		return nil, err, nil
	end

	local background = palette.bg and palette.bg.core or "#000000"
	local results = M.calculate_batch(color_set, background)
	return results, nil, background
end

--- Check all preset themes (light and dark) with actual palette backgrounds
function M.check_all_presets()
	print("\n" .. string.rep("=", 80))
	print("WCAG AAA Preset Color Assessment for Oasis Themes")
	print("(Testing reference colors against actual palette backgrounds)")
	print(string.rep("=", 80))

	-- Dynamically discover all palettes
	local light_palettes, dark_palettes = M.discover_palettes()

	if #light_palettes > 0 then
		print("\n" .. string.rep("-", 80))
		print("LIGHT THEMES (Preset Colors)")
		print(string.rep("-", 80))

		for _, palette_name in ipairs(light_palettes) do
			local results, err, background = M.check_preset_theme(palette_name, M.PRESETS.LIGHT_COLORS)
			if results and background then
				M.print_results(results, background, palette_name .. " - " .. background)
			else
				print("Error loading " .. palette_name .. ": " .. (err or "unknown error"))
			end
		end
	end

	if #dark_palettes > 0 then
		print("\n" .. string.rep("-", 80))
		print("DARK THEMES (Preset Colors)")
		print(string.rep("-", 80))

		for _, palette_name in ipairs(dark_palettes) do
			local results, err, background = M.check_preset_theme(palette_name, M.PRESETS.DARK_COLORS)
			if results and background then
				M.print_results(results, background, palette_name .. " - " .. background)
			else
				print("Error loading " .. palette_name .. ": " .. (err or "unknown error"))
			end
		end
	end

	if #light_palettes == 0 and #dark_palettes == 0 then
		print("\nWarning: No palettes found. Make sure you're running from the project root.")
	end
end

-- Export Color class for external use
M.Color = Color

return M
