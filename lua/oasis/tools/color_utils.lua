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

-- TODO: Much of these new additions are just recreated functions from wcag_color_generator for no reason. We need to use those functions where applicable.

--TODO: For functions that generate a light_theme, that should be in it's own file in ./create_light_theme.lua

--- Convert RGB hex color to HSL
-- TODO: Consider using wcag_color_calculator's Color.from_hex() and Color:to_hsl() instead.
-- Note: Current implementation returns (degrees 0-360, percent 0-100, percent 0-100)
-- wcag_color_calculator uses (0-1, 0-1, 0-1) range. Would need conversion wrapper.
--- @param hex string Hex color (e.g., "#D9E6FA")
--- @return number, number, number Hue (0-360), Saturation (0-100), Lightness (0-100)
function M.rgb_to_hsl(hex)
	if not hex or hex == "NONE" then
		return 0, 0, 0
	end

	-- Remove # if present
	hex = hex:gsub("#", "")

	-- Convert hex to RGB (0-1 range)
	local r = tonumber(hex:sub(1, 2), 16) / 255
	local g = tonumber(hex:sub(3, 4), 16) / 255
	local b = tonumber(hex:sub(5, 6), 16) / 255

	local max = math.max(r, g, b)
	local min = math.min(r, g, b)
	local delta = max - min

	-- Calculate lightness
	local l = (max + min) / 2

	-- Calculate saturation
	local s = 0
	if delta ~= 0 then
		s = delta / (1 - math.abs(2 * l - 1))
	end

	-- Calculate hue
	local h = 0
	if delta ~= 0 then
		if max == r then
			h = 60 * (((g - b) / delta) % 6)
		elseif max == g then
			h = 60 * (((b - r) / delta) + 2)
		else
			h = 60 * (((r - g) / delta) + 4)
		end
	end

	-- Normalize hue to 0-360
	if h < 0 then
		h = h + 360
	end

	-- Return as degrees and percentages
	return h, s * 100, l * 100
end

--- Convert HSL to RGB hex color
-- TODO: Consider using wcag_color_calculator's Color.from_hsl() and Color:to_hex() instead.
-- Note: Current implementation takes (degrees 0-360, percent 0-100, percent 0-100)
-- wcag_color_calculator uses (0-1, 0-1, 0-1) range. Would need conversion wrapper.
--- @param h number Hue (0-360 degrees)
--- @param s number Saturation (0-100 percent)
--- @param l number Lightness (0-100 percent)
--- @return string Hex color (e.g., "#D9E6FA")
function M.hsl_to_rgb(h, s, l)
	-- Normalize inputs
	h = h % 360
	s = s / 100
	l = l / 100

	local c = (1 - math.abs(2 * l - 1)) * s -- Chroma
	local x = c * (1 - math.abs(((h / 60) % 2) - 1)) -- Second largest component (intermediate value)
	local m = l - c / 2 -- Lightness adjustment (adds back the "lightness" removed by chroma)

	local r, g, b = 0, 0, 0

	if h < 60 then
		r, g, b = c, x, 0
	elseif h < 120 then
		r, g, b = x, c, 0
	elseif h < 180 then
		r, g, b = 0, c, x
	elseif h < 240 then
		r, g, b = 0, x, c
	elseif h < 300 then
		r, g, b = x, 0, c
	else
		r, g, b = c, 0, x
	end

	-- Convert to 0-255 range and format as hex
	r = math.floor((r + m) * 255 + 0.5)
	g = math.floor((g + m) * 255 + 0.5)
	b = math.floor((b + m) * 255 + 0.5)

	return string.format("#%02x%02x%02x", r, g, b)
end

--- Apply light intensity transformation to a background color
-- TODO: Replace M.rgb_to_hsl() and M.hsl_to_rgb() with wcag_color_calculator's Color class methods
--- @param base_color string Base color (typically dark mode fg.core)
--- @param intensity_level number Intensity level (1-5)
--- @return string Transformed hex color
function M.apply_light_intensity(base_color, intensity_level)
	if not base_color or intensity_level < 1 or intensity_level > 5 then
		return base_color
	end

	local h, s, l = M.rgb_to_hsl(base_color)

	local new_hue, new_sat, new_light

	if intensity_level == 1 then
		-- Subtle: shift hue -11°, moderate saturation, very light
		new_hue = h - 11
		new_sat = 38
		new_light = 97
	elseif intensity_level == 2 then
		-- Base: original hue, max saturation
		new_hue = h
		new_sat = 100
		new_light = 94
	elseif intensity_level == 3 then
		-- Medium: original hue, max saturation
		new_hue = h
		new_sat = 100
		new_light = 90
	elseif intensity_level == 4 then
		-- Vibrant: slight negative hue shift, max saturation
		new_hue = h - 1
		new_sat = 100
		new_light = 87
	else -- intensity_level == 5
		-- Saturated: stronger negative hue shift, max saturation
		new_hue = h - 4
		new_sat = 100
		new_light = 84
	end

	return M.hsl_to_rgb(new_hue, new_sat, new_light)
end

--- Generate complete light mode background set from dark mode foreground
-- TODO: Replace M.rgb_to_hsl() and M.hsl_to_rgb() with wcag_color_calculator's Color class methods
--- Derives all backgrounds (core, mantle, shadow, surface) from dark fg.core
--- @param dark_fg_core string Dark mode fg.core color (source of truth)
--- @param intensity_level number Light intensity (1-5)
--- @return table Background colors {core, mantle, shadow, surface}
function M.generate_light_backgrounds(dark_fg_core, intensity_level)
	-- Generate base bg.core using intensity formula
	local core = M.apply_light_intensity(dark_fg_core, intensity_level)

	-- Get HSL of core to derive related backgrounds
	local h, s, l = M.rgb_to_hsl(core)

	-- Progressive darkening: core (lightest) → mantle → shadow → surface (darkest)
	-- Each step is 3% darker in lightness
	local mantle = M.hsl_to_rgb(h, s, l - 3) -- 3% darker
	local shadow = M.hsl_to_rgb(h, s, l - 6) -- 6% darker
	local surface = M.hsl_to_rgb(h, s, l - 9) -- 9% darker

	return {
		core = core,
		mantle = mantle,
		shadow = shadow,
		surface = surface,
	}
end

--- Calculate relative luminance for WCAG contrast calculations
-- TODO: Replace with wcag_color_calculator's relative_luminance() function.
-- Both implement the same WCAG 2.1 formula. Can use Color.from_hex() wrapper.
--- @param hex string Hex color (e.g., "#808080")
--- @return number Relative luminance (0-1)
function M.get_luminance(hex)
	if not hex or hex == "NONE" then
		return 0
	end

	hex = hex:gsub("#", "")
	local r = tonumber(hex:sub(1, 2), 16) / 255
	local g = tonumber(hex:sub(3, 4), 16) / 255
	local b = tonumber(hex:sub(5, 6), 16) / 255

	-- Apply sRGB gamma correction
	local function adjust(c)
		if c <= 0.03928 then
			return c / 12.92
		else
			return math.pow((c + 0.055) / 1.055, 2.4)
		end
	end

	r = adjust(r)
	g = adjust(g)
	b = adjust(b)

	return 0.2126 * r + 0.7152 * g + 0.0722 * b
end

--- Calculate WCAG contrast ratio between two colors
-- TODO: Replace with wcag_color_calculator.contrast_ratio(color1, color2).
-- Both implement the same WCAG 2.1 formula and accept hex strings.
--- @param color1 string First hex color
--- @param color2 string Second hex color
--- @return number Contrast ratio (1-21)
function M.get_contrast_ratio(color1, color2)
	local lum1 = M.get_luminance(color1)
	local lum2 = M.get_luminance(color2)

	local lighter = math.max(lum1, lum2)
	local darker = math.min(lum1, lum2)

	return (lighter + 0.05) / (darker + 0.05)
end

--- Darken a color to meet target WCAG contrast ratio on light background
-- TODO: Replace with wcag_color_calculator.adjust_for_target(color, bg_color, target_ratio, max_iterations).
-- Both implement the same binary search algorithm for lightness adjustment.
-- wcag_color_calculator version is more robust and handles both lightening and darkening.
--- @param color string Source hex color
--- @param bg_color string Background hex color
--- @param target_ratio number Target contrast ratio (e.g., 7.0 for AAA)
--- @param max_iterations? number Maximum adjustment iterations (default: 50)
--- @return string Darkened hex color meeting target ratio
function M.darken_to_contrast(color, bg_color, target_ratio, max_iterations)
	max_iterations = max_iterations or 50
	local h, s, l = M.rgb_to_hsl(color)

	-- Binary search for optimal lightness
	local low_l = 0
	local high_l = 100
	local result_l = l

	for _ = 1, max_iterations do
		local test_l = (low_l + high_l) / 2
		local test_color = M.hsl_to_rgb(h, s, test_l)
		local ratio = M.get_contrast_ratio(test_color, bg_color)

		if math.abs(ratio - target_ratio) < 0.1 then
			result_l = test_l
			break
		elseif ratio < target_ratio then
			-- Need more contrast (darker)
			high_l = test_l
		else
			-- Too much contrast (lighter)
			low_l = test_l
		end
		result_l = test_l
	end

	return M.hsl_to_rgb(h, s, result_l)
end

--- Generate light mode foreground colors from dark mode
-- TODO: Move to lua/oasis/tools/create_light_theme.lua
-- TODO: Replace M.darken_to_contrast() calls with wcag_color_calculator.adjust_for_target()
-- TODO: Replace M.rgb_to_hsl() and M.hsl_to_rgb() with wcag_color_calculator's Color class methods
--- @param dark_fg table Dark mode fg colors {core, strong, muted, dim, comment}
--- @param light_bg_core string Light mode background core color
--- @param intensity_level number Intensity level (1-5) for subtle variations
--- @param contrast_targets? table Optional contrast ratio targets per element {strong=7.0, core=7.0, muted=4.5, dim=3.0, comment=4.5}
--- @return table Light mode foreground colors
function M.generate_light_foregrounds(dark_fg, light_bg_core, intensity_level, contrast_targets)
	-- Default contrast targets (can be overridden)
	local default_targets = {
		strong = 7.0, -- AAA
		core = 7.0, -- AAA
		muted = 4.5, -- AA
		comment = 4.0, -- AA (muted, blends with background)
		dim = 3.0, -- Minimal
	}
	contrast_targets = contrast_targets or default_targets

	-- Base lightness values adjusted by intensity
	-- Intensity 1=subtle (lighter), 5=maximum (darker)
	local intensity_factor = (intensity_level - 1) * 0.05 -- 0 to 0.2 adjustment

	local base_lightness = {
		strong = 18 - (intensity_factor * 10), -- 18% to 16%
		core = 24 - (intensity_factor * 8), -- 24% to 20.4%
		muted = 42 - (intensity_factor * 12), -- 42% to 37.6%
		dim = 58 - (intensity_factor * 10), -- 58% to 54%
		comment = 38 - (intensity_factor * 8), -- 38% to 34.4%
	}

	local result = {}

	-- Generate each foreground color with appropriate lightness
	for key, target_l in pairs(base_lightness) do
		local source_color = dark_fg[key]
		if source_color then
			local h, s, _ = M.rgb_to_hsl(source_color)
			-- Reduce saturation for subtlety (50% of original)
			local new_s = s * 0.5
			result[key] = M.hsl_to_rgb(h, new_s, target_l)

			-- Apply contrast target if specified
			local target_ratio = contrast_targets[key] or default_targets[key]
			if target_ratio then
				result[key] = M.darken_to_contrast(result[key], light_bg_core, target_ratio)
			end
		end
	end

	return result
end

--- Generate light mode syntax colors from dark mode
-- TODO: Move to lua/oasis/tools/create_light_theme.lua
-- TODO: Replace M.darken_to_contrast() calls with wcag_color_calculator.adjust_for_target()
-- TODO: Replace M.rgb_to_hsl() and M.hsl_to_rgb() with wcag_color_calculator's Color class methods
--- @param dark_syntax table Dark mode syntax colors
--- @param light_bg_core string Light mode background core color
--- @param intensity_level number Intensity level (1-5)
--- @param contrast_targets? table Optional contrast ratio targets per syntax element
--- @return table Light mode syntax colors
function M.generate_light_syntax(dark_syntax, light_bg_core, intensity_level, contrast_targets)
	-- Default contrast targets for syntax elements
	local default_targets = {
		-- Highest Contract (AAA++)
		constant = 10.0,
		parameter = 8.5,

		-- High contrast (AAA+)
		type = 7.5,
		string = 7.5,
		func = 7.5,
		keyword = 7.5,

		-- Standard AAA
		identifier = 7.0,
		builtinVar = 7.0,
		regex = 7.0,
		builtinConst = 7.0,
		builtinFunc = 7.0,
		statement = 7.0,
		exception = 7.0,
		special = 7.0,
		operator = 7.0,
		punctuation = 7.0,
		preproc = 7.0,
		delimiter = 7.0,

		-- Muted (AA) - blend with background
		bracket = 4.5,
		comment = 4.5,

		-- Dim (A) - Faded into background
		nontext = 3.0,
	}
	contrast_targets = contrast_targets or default_targets

	local result = {}

	-- Intensity affects base lightness (1=lighter/subtle, 5=darker/vibrant)
	local base_lightness = 28 - ((intensity_level - 1) * 2) -- 28% to 20%

	-- Color category adjustments for better semantic grouping
	local category_adjustments = {
		-- Cold colors (data): slightly lighter, more readable
		cold = { l_offset = 4, s_factor = 0.75 },
		-- Warm colors (control): slightly darker, more prominent
		warm = { l_offset = -2, s_factor = 0.80 },
		-- Neutral colors: medium
		neutral = { l_offset = 0, s_factor = 0.65 },
	}

	-- Classify syntax elements by category
	local categories = {
		cold = { "parameter", "identifier", "type", "builtinVar", "string", "regex", "builtinConst", "constant" },
		warm = {
			"func",
			"builtinFunc",
			"statement",
			"exception",
			"keyword",
			"special",
			"operator",
			"punctuation",
			"preproc",
		},
		neutral = { "bracket", "comment", "delimiter" },
	}

	-- Generate colors for each category
	for category, keys in pairs(categories) do
		local adj = category_adjustments[category]

		for _, key in ipairs(keys) do
			local source_color = dark_syntax[key]
			if source_color then
				local h, s, _ = M.rgb_to_hsl(source_color)

				-- Apply category-specific adjustments
				local target_l = base_lightness + adj.l_offset
				local new_s = s * adj.s_factor

				-- Allow slight hue shifts for better light-mode appearance
				-- Shift blues/purples slightly warmer, oranges/reds slightly cooler
				local hue_shift = 0
				if h >= 200 and h <= 280 then
					-- Blues/purples: shift 3° warmer
					hue_shift = 3
				elseif h >= 0 and h <= 60 then
					-- Reds/oranges: shift 2° cooler
					hue_shift = -2
				end

				local new_h = (h + hue_shift) % 360
				result[key] = M.hsl_to_rgb(new_h, new_s, target_l)

				-- Apply contrast target
				local target_ratio = contrast_targets[key] or default_targets[key] or 7.0
				result[key] = M.darken_to_contrast(result[key], light_bg_core, target_ratio)
			end
		end
	end

	return result
end

--- Generate light mode UI colors from dark mode
-- TODO: Move to lua/oasis/tools/create_light_theme.lua
-- TODO: Replace M.darken_to_contrast() calls with wcag_color_calculator.adjust_for_target()
-- TODO: Replace M.rgb_to_hsl() and M.hsl_to_rgb() with wcag_color_calculator's Color class methods
--- @param dark_ui table Dark mode UI colors
--- @param light_bg table Light mode background colors {core, mantle, shadow, surface}
--- @param intensity_level number Intensity level (1-5)
--- @param contrast_targets? table Optional contrast ratio targets per UI element
--- @return table Light mode UI colors
function M.generate_light_ui(dark_ui, light_bg, intensity_level, contrast_targets)
	-- Default contrast targets for UI elements
	local default_targets = {
		lineNumber = 7.0,
		dir = 7.0,
		title = 7.0,
		border = 7.0,
		nontext = 3.0,
	}
	contrast_targets = contrast_targets or default_targets

	local result = {}

	-- Simple elements
	local simple_elements = {
		"lineNumber",
		"dir",
		"title",
		"border",
		"nontext",
	}

	for _, key in ipairs(simple_elements) do
		if dark_ui[key] and type(dark_ui[key]) == "string" then
			local h, s, _ = M.rgb_to_hsl(dark_ui[key])
			local base_l = 30 - ((intensity_level - 1) * 2)
			result[key] = M.hsl_to_rgb(h, s * 0.75, base_l)

			-- Apply contrast target
			local target_ratio = contrast_targets[key] or default_targets[key] or 7.0
			result[key] = M.darken_to_contrast(result[key], light_bg.core, target_ratio)
		end
	end

	-- CursorLine uses background variant
	result.cursorLine = light_bg.mantle

	-- Visual selection (bg = surface for subtle highlight)
	if dark_ui.visual then
		result.visual = { bg = light_bg.surface, fg = "none" }
	end

	-- Match (high contrast bg with dark fg)
	if dark_ui.match then
		local h, s, _ = M.rgb_to_hsl(dark_ui.match.bg or "#000000")
		-- Create a saturated mid-tone background
		local match_bg = M.hsl_to_rgb(h, 70, 70)
		local match_fg = M.hsl_to_rgb(h, 80, 15)
		result.match = { bg = match_bg, fg = match_fg }
	end

	-- Search colors
	if dark_ui.search then
		local h, s, _ = M.rgb_to_hsl(dark_ui.search.bg or "#000000")
		result.search = {
			bg = M.hsl_to_rgb(h, 65, 75),
			fg = M.hsl_to_rgb(h, 85, 18),
		}
	end

	-- Current search (more prominent)
	if dark_ui.curSearch then
		local h, s, _ = M.rgb_to_hsl(dark_ui.curSearch.bg or "#000000")
		result.curSearch = {
			bg = M.hsl_to_rgb(h, 75, 65),
			fg = M.hsl_to_rgb(h, 90, 12),
		}
	end

	-- Float window
	if dark_ui.float then
		result.float = {
			title = result.title or light_bg.core,
			fg = result.title or light_bg.core,
			bg = light_bg.surface,
			border = {
				fg = result.border or light_bg.core,
				bg = light_bg.mantle,
			},
		}
	end

	-- Diagnostics (keep vibrant but ensure readability)
	if dark_ui.diag then
		result.diag = {}
		for level, colors in pairs(dark_ui.diag) do
			if type(colors) == "table" and colors.fg then
				local h, s, _ = M.rgb_to_hsl(colors.fg)
				-- Darker, more saturated versions
				local diag_fg = M.hsl_to_rgb(h, math.min(100, s * 1.2), 25)
				-- Ensure contrast
				diag_fg = M.darken_to_contrast(diag_fg, light_bg.core, 7.0)
				result.diag[level] = {
					fg = diag_fg,
					bg = light_bg.core,
				}
			end
		end
	end

	return result
end

--- Generate light mode theme colors from dark mode (vibrant, decorative)
-- TODO: Move to lua/oasis/tools/create_light_theme.lua
-- TODO: Replace M.rgb_to_hsl() and M.hsl_to_rgb() with wcag_color_calculator's Color class methods
-- Note: These colors are decorative and intentionally may not meet WCAG compliance
--- These colors can fail WCAG compliance as they're decorative only
--- @param dark_theme table Dark mode theme colors {primary, light_primary, secondary, accent}
--- @param intensity_level number Intensity level (1-5)
--- @return table Light mode theme colors (vibrant)
function M.generate_light_theme(dark_theme, intensity_level)
	local result = {}

	-- Theme colors should maintain vibrancy like dark mode
	-- Intensity affects saturation and lightness
	local sat_factor = 0.9 + (intensity_level * 0.02) -- 0.92 to 1.0
	local light_base = 35 - (intensity_level * 2) -- 33% to 25%

	-- Primary color (most important, darkest, most saturated)
	if dark_theme.primary then
		local h, s, _ = M.rgb_to_hsl(dark_theme.primary)
		result.primary = M.hsl_to_rgb(h, s * sat_factor, light_base)
	end

	-- Light primary (slightly lighter variant)
	if dark_theme.light_primary then
		local h, s, _ = M.rgb_to_hsl(dark_theme.light_primary)
		result.light_primary = M.hsl_to_rgb(h, s * sat_factor, light_base - 5)
	end

	-- Secondary color
	if dark_theme.secondary then
		local h, s, _ = M.rgb_to_hsl(dark_theme.secondary)
		result.secondary = M.hsl_to_rgb(h, s * sat_factor, light_base + 2)
	end

	-- Accent color
	if dark_theme.accent then
		local h, s, _ = M.rgb_to_hsl(dark_theme.accent)
		result.accent = M.hsl_to_rgb(h, s * sat_factor, light_base + 2)
	end

	-- Copy palette if it exists
	if dark_theme.palette then
		result.palette = dark_theme.palette
	end

	return result
end

return M
