-- lua/oasis/tools/light_theme_generator.lua
-- Light theme generation utilities for Oasis
-- Generates light mode color palettes from dark mode palettes

local color_utils = require("oasis.tools.color_utils")

local M = {}

--- Apply light intensity transformation to a background color
--- @param base_color string Base color (typically dark mode fg.core)
--- @param intensity_level number Intensity level (1-5)
--- @return string Transformed hex color
function M.apply_light_intensity(base_color, intensity_level)
	if not base_color or intensity_level < 1 or intensity_level > 5 then
		return base_color
	end

	local h, s, l = color_utils.rgb_to_hsl(base_color)

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

	return color_utils.hsl_to_rgb(new_hue, new_sat, new_light)
end

--- Generate complete light mode background set from dark mode foreground
--- Derives all backgrounds (core, mantle, shadow, surface) from dark fg.core
--- @param dark_fg_core string Dark mode fg.core color (source of truth)
--- @param intensity_level number Light intensity (1-5)
--- @return table Background colors {core, mantle, shadow, surface}
function M.generate_light_backgrounds(dark_fg_core, intensity_level)
	-- Generate base bg.core using intensity formula
	local core = M.apply_light_intensity(dark_fg_core, intensity_level)

	-- Get HSL of core to derive related backgrounds
	local h, s, l = color_utils.rgb_to_hsl(core)

	-- Progressive darkening: core (lightest) → mantle → shadow → surface (darkest)
	-- Each step is 3% darker in lightness
	local mantle = color_utils.hsl_to_rgb(h, s, l - 3) -- 3% darker
	local shadow = color_utils.hsl_to_rgb(h, s, l - 6) -- 6% darker
	local surface = color_utils.hsl_to_rgb(h, s, l - 9) -- 9% darker

	return {
		core = core,
		mantle = mantle,
		shadow = shadow,
		surface = surface,
	}
end

--- Generate light mode foreground colors from dark mode
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
			local h, s, _ = color_utils.rgb_to_hsl(source_color)
			-- Reduce saturation for subtlety (50% of original)
			local new_s = s * 0.5
			result[key] = color_utils.hsl_to_rgb(h, new_s, target_l)

			-- Apply contrast target if specified
			local target_ratio = contrast_targets[key] or default_targets[key]
			if target_ratio then
				result[key] = color_utils.darken_to_contrast(result[key], light_bg_core, target_ratio)
			end
		end
	end

	return result
end

--- Generate light mode syntax colors from dark mode
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
				local h, s, _ = color_utils.rgb_to_hsl(source_color)

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
				result[key] = color_utils.hsl_to_rgb(new_h, new_s, target_l)

				-- Apply contrast target
				local target_ratio = contrast_targets[key] or default_targets[key] or 7.0
				result[key] = color_utils.darken_to_contrast(result[key], light_bg_core, target_ratio)
			end
		end
	end

	return result
end

--- Generate light mode UI colors from dark mode
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
			local h, s, _ = color_utils.rgb_to_hsl(dark_ui[key])
			local base_l = 30 - ((intensity_level - 1) * 2)
			result[key] = color_utils.hsl_to_rgb(h, s * 0.75, base_l)

			-- Apply contrast target
			local target_ratio = contrast_targets[key] or default_targets[key] or 7.0
			result[key] = color_utils.darken_to_contrast(result[key], light_bg.core, target_ratio)
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
		local h, s, _ = color_utils.rgb_to_hsl(dark_ui.match.bg or "#000000")
		-- Create a saturated mid-tone background
		local match_bg = color_utils.hsl_to_rgb(h, 70, 70)
		local match_fg = color_utils.hsl_to_rgb(h, 80, 15)
		result.match = { bg = match_bg, fg = match_fg }
	end

	-- Search colors
	if dark_ui.search then
		local h, s, _ = color_utils.rgb_to_hsl(dark_ui.search.bg or "#000000")
		result.search = {
			bg = color_utils.hsl_to_rgb(h, 65, 75),
			fg = color_utils.hsl_to_rgb(h, 85, 18),
		}
	end

	-- Current search (more prominent)
	if dark_ui.curSearch then
		local h, s, _ = color_utils.rgb_to_hsl(dark_ui.curSearch.bg or "#000000")
		result.curSearch = {
			bg = color_utils.hsl_to_rgb(h, 75, 65),
			fg = color_utils.hsl_to_rgb(h, 90, 12),
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
				local h, s, _ = color_utils.rgb_to_hsl(colors.fg)
				-- Darker, more saturated versions
				local diag_fg = color_utils.hsl_to_rgb(h, math.min(100, s * 1.2), 25)
				-- Ensure contrast
				diag_fg = color_utils.darken_to_contrast(diag_fg, light_bg.core, 7.0)
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
--- Note: These colors are decorative and intentionally may not meet WCAG compliance
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
		local h, s, _ = color_utils.rgb_to_hsl(dark_theme.primary)
		result.primary = color_utils.hsl_to_rgb(h, s * sat_factor, light_base)
	end

	-- Light primary (slightly lighter variant)
	if dark_theme.light_primary then
		local h, s, _ = color_utils.rgb_to_hsl(dark_theme.light_primary)
		result.light_primary = color_utils.hsl_to_rgb(h, s * sat_factor, light_base - 5)
	end

	-- Secondary color
	if dark_theme.secondary then
		local h, s, _ = color_utils.rgb_to_hsl(dark_theme.secondary)
		result.secondary = color_utils.hsl_to_rgb(h, s * sat_factor, light_base + 2)
	end

	-- Accent color
	if dark_theme.accent then
		local h, s, _ = color_utils.rgb_to_hsl(dark_theme.accent)
		result.accent = color_utils.hsl_to_rgb(h, s * sat_factor, light_base + 2)
	end

	-- Copy palette if it exists
	if dark_theme.palette then
		result.palette = dark_theme.palette
	end

	return result
end

return M
