-- lua/oasis/wcag_checker.lua
-- WCAG Contrast Checker for Oasis Palettes
-- Analyzes color contrast ratios and WCAG compliance

local M = {}

-- Configuration: Number of color pairs that are intentionally designed to fail WCAG AAA
-- (e.g., muted/dim text, comments, borders)
-- AAA Target = Total Checks - NUMBER_OF_ACCEPTABLE_FAILS
local NUMBER_OF_ACCEPTABLE_FAILS = 4

--- Convert hex color to RGB values (0-255)
---@param hex string Hex color like "#1a1a1a" or "1a1a1a"
---@return number, number, number RGB values
local function hex_to_rgb(hex)
	if not hex or type(hex) ~= "string" then
		return 0, 0, 0
	end
	hex = hex:gsub("#", "")
	return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

--- Calculate relative luminance per WCAG formula
---@param r number Red (0-255)
---@param g number Green (0-255)
---@param b number Blue (0-255)
---@return number Relative luminance (0-1)
local function get_relative_luminance(r, g, b)
	-- Normalize to 0-1
	local rs, gs, bs = r / 255, g / 255, b / 255

	-- Apply gamma correction
	local function adjust(c)
		if c <= 0.03928 then
			return c / 12.92
		else
			return math.pow((c + 0.055) / 1.055, 2.4)
		end
	end

	local r_adj = adjust(rs)
	local g_adj = adjust(gs)
	local b_adj = adjust(bs)

	-- Calculate luminance using WCAG coefficients
	return 0.2126 * r_adj + 0.7152 * g_adj + 0.0722 * b_adj
end

--- Calculate contrast ratio between two colors
---@param color1 string Hex color
---@param color2 string Hex color
---@return number Contrast ratio (1-21)
function M.get_contrast_ratio(color1, color2)
	local r1, g1, b1 = hex_to_rgb(color1)
	local r2, g2, b2 = hex_to_rgb(color2)

	local l1 = get_relative_luminance(r1, g1, b1)
	local l2 = get_relative_luminance(r2, g2, b2)

	-- Ensure L1 is the lighter color
	local lighter = math.max(l1, l2)
	local darker = math.min(l1, l2)

	return (lighter + 0.05) / (darker + 0.05)
end

--- Get WCAG compliance level for a contrast ratio
---@param ratio number Contrast ratio
---@param large_text boolean Whether this is large text (18pt+/14pt+ bold)
---@return string Compliance level: "AAA", "AA", "AA Large", "Fail"
function M.get_compliance_level(ratio, large_text)
	if large_text then
		if ratio >= 4.5 then
			return "AAA"
		elseif ratio >= 3.0 then
			return "AA"
		else
			return "Fail"
		end
	else
		if ratio >= 7.0 then
			return "AAA"
		elseif ratio >= 4.5 then
			return "AA"
		else
			return "Fail"
		end
	end
end

--- Format contrast ratio with color coding
---@param ratio number Contrast ratio
---@param level string Compliance level
---@return string Formatted string with ratio and level
local function format_ratio(ratio, level)
	local emoji = {
		AAA = "✓✓✓",
		AA = "✓✓ ",
		["AA Large"] = "✓  ",
		Fail = "✗  ",
	}
	return string.format("%5.2f:1 %s %s", ratio, emoji[level] or "   ", level)
end

--- Analyze a single palette for WCAG compliance
---@param palette_name string Name of the palette (e.g., "oasis_lagoon")
---@return table Analysis results
function M.analyze_palette(palette_name)
	-- Load the palette
	local ok, palette = pcall(require, "oasis.color_palettes." .. palette_name)
	if not ok then
		return { error = "Failed to load palette: " .. palette_name }
	end

	local results = {
		name = palette_name,
		checks = {},
	}

	-- Helper to add a check result
	local function check(label, fg, bg, large_text)
		-- Skip if colors are missing or invalid
		if not fg or not bg or fg == "none" or bg == "none" then
			return
		end
		if type(fg) ~= "string" or type(bg) ~= "string" then
			return
		end

		local ratio = M.get_contrast_ratio(fg, bg)
		local level = M.get_compliance_level(ratio, large_text or false)
		table.insert(results.checks, {
			label = label,
			fg = fg,
			bg = bg,
			ratio = ratio,
			level = level,
			large_text = large_text or false,
		})
	end

	-- Critical checks: Main text readability
	check("Main Text (fg.core on bg.core)", palette.fg.core, palette.bg.core)
	check("Muted Text (fg.muted on bg.core)", palette.fg.muted, palette.bg.core)
	check("Dim Text (fg.dim on bg.core)", palette.fg.dim, palette.bg.core)
	check("Strong Text (fg.strong on bg.core)", palette.fg.strong, palette.bg.core)

	-- UI Elements
	check("Float Text (float.fg on float.bg)", palette.ui.float.fg, palette.ui.float.bg)
	check("Float Title (float.title on float.bg)", palette.ui.float.title, palette.ui.float.bg, true)
	check("Border (border on bg.core)", palette.ui.border, palette.bg.core)
	check("Title (title on bg.core)", palette.ui.title, palette.bg.core, true)
	check("Directory (dir on bg.core)", palette.ui.dir, palette.bg.core)
	check("Nontext (nontext on bg.core)", palette.ui.nontext, palette.bg.core)

	-- Syntax highlighting (Cold colors - Data)
	check("Parameters (parameter on bg.core)", palette.syntax.parameter, palette.bg.core)
	check("Identifiers (identifier on bg.core)", palette.syntax.identifier, palette.bg.core)
	check("Types (type on bg.core)", palette.syntax.type, palette.bg.core)
	check("Builtin Vars (builtinVar on bg.core)", palette.syntax.builtinVar, palette.bg.core)
	check("Strings (string on bg.core)", palette.syntax.string, palette.bg.core)
	check("Constants (constant on bg.core)", palette.syntax.constant, palette.bg.core)
	check("Builtin Constants (builtinConst on bg.core)", palette.syntax.builtinConst, palette.bg.core)

	-- Syntax highlighting (Warm colors - Control)
	check("Functions (func on bg.core)", palette.syntax.func, palette.bg.core)
	check("Builtin Functions (builtinFunc on bg.core)", palette.syntax.builtinFunc, palette.bg.core)
	check("Keywords (keyword on bg.core)", palette.syntax.keyword, palette.bg.core)
	check("Statements (statement on bg.core)", palette.syntax.statement, palette.bg.core)
	check("Operators (operator on bg.core)", palette.syntax.operator, palette.bg.core)
	check("Preproc (preproc on bg.core)", palette.syntax.preproc, palette.bg.core)

	-- Syntax highlighting (Neutral - Structure)
	check("Comments (comment on bg.core)", palette.syntax.comment, palette.bg.core)
	check("Brackets (bracket on bg.core)", palette.syntax.bracket, palette.bg.core)

	-- Diagnostics (critical for accessibility)
	check("Error Text (diag.error.fg on bg.core)", palette.ui.diag.error.fg, palette.bg.core)
	check("Warning Text (diag.warn.fg on bg.core)", palette.ui.diag.warn.fg, palette.bg.core)
	check("Info Text (diag.info.fg on bg.core)", palette.ui.diag.info.fg, palette.bg.core)
	check("Hint Text (diag.hint.fg on bg.core)", palette.ui.diag.hint.fg, palette.bg.core)

	-- Visual feedback (extract fg from table if needed)
	if palette.ui.search and palette.ui.search.fg then
		check("Search Text (search.fg on search.bg)", palette.ui.search.fg, palette.ui.search.bg)
	end
	check("Match (match on bg.core)", palette.ui.match, palette.bg.core)

	return results
end

--- Generate a summary of compliance levels
---@param results table Analysis results from analyze_palette
---@return table Summary with counts
local function get_summary(results)
	local summary = { AAA = 0, AA = 0, Fail = 0, total = 0 }
	for _, check in ipairs(results.checks) do
		summary.total = summary.total + 1
		if check.level == "AAA" then
			summary.AAA = summary.AAA + 1
		elseif check.level == "AA" then
			summary.AA = summary.AA + 1
		else
			summary.Fail = summary.Fail + 1
		end
	end
	return summary
end

--- Print analysis results for a single palette
---@param results table Analysis results
function M.print_palette_results(results)
	if results.error then
		print("Error: " .. results.error)
		return
	end

	print("\n" .. string.rep("=", 80))
	print("  " .. results.name:upper())
	print(string.rep("=", 80))

	local summary = get_summary(results)
	local aaa_pct = (summary.AAA / summary.total) * 100
	local aa_pct = (summary.AA / summary.total) * 100
	local aaa_target = summary.total - NUMBER_OF_ACCEPTABLE_FAILS
	local target_status = summary.AAA >= aaa_target and "✓" or "✗"

	print(
		string.format(
			"\nSummary: %d/%d AAA (%.0f%%), %d/%d AA (%.0f%%), %d Failed",
			summary.AAA,
			summary.total,
			aaa_pct,
			summary.AA,
			summary.total,
			aa_pct,
			summary.Fail
		)
	)

	print(
		string.format(
			"AAA Target: %d/%d %s (Acceptable Fails: %d)",
			summary.AAA,
			aaa_target,
			target_status,
			NUMBER_OF_ACCEPTABLE_FAILS
		)
	)

	print("\nDetailed Results:")
	print(string.rep("-", 80))

	for _, check in ipairs(results.checks) do
		print(string.format("%-45s %s", check.label, format_ratio(check.ratio, check.level)))
	end
end

--- Analyze all Oasis palettes
---@return table Array of analysis results
function M.analyze_all()
	local palettes = {
		-- Dark themes
		"oasis_night",
		"oasis_midnight",
		"oasis_abyss",
		"oasis_starlight",
		"oasis_desert",
		"oasis_sol",
		"oasis_canyon",
		"oasis_dune",
		"oasis_cactus",
		"oasis_mirage",
		"oasis_lagoon",
		"oasis_twilight",
		"oasis_rose",
		-- Light themes
		"oasis_dawn",
		"oasis_dawnlight",
		"oasis_day",
		"oasis_dusk",
		"oasis_dust",
	}

	local all_results = {}
	for _, palette_name in ipairs(palettes) do
		table.insert(all_results, M.analyze_palette(palette_name))
	end

	return all_results
end

--- Print comparison table of all palettes
---@param all_results table Array of analysis results
function M.print_comparison_table(all_results)
	-- Sort results by AAA count (descending)
	local sorted_results = {}
	for _, results in ipairs(all_results) do
		if not results.error then
			table.insert(sorted_results, results)
		end
	end

	table.sort(sorted_results, function(a, b)
		local summary_a = get_summary(a)
		local summary_b = get_summary(b)
		return summary_a.AAA > summary_b.AAA
	end)

	print("\n" .. string.rep("=", 100))
	print("  WCAG COMPLIANCE COMPARISON - ALL PALETTES")
	print(string.rep("=", 100))
	print(
		string.format("\n%-25s %8s %8s %8s %8s %8s %12s", "Palette", "AAA", "AA", "Fail", "AAA %", "AA %", "AAA Target")
	)
	print(string.rep("-", 100))

	for _, results in ipairs(sorted_results) do
		local summary = get_summary(results)
		local aaa_pct = (summary.AAA / summary.total) * 100
		local aa_pct = (summary.AA / summary.total) * 100
		local aaa_target = summary.total - NUMBER_OF_ACCEPTABLE_FAILS
		local target_status = summary.AAA >= aaa_target and "✓" or "✗"
		local target_display = string.format("%d/%d %s", summary.AAA, aaa_target, target_status)

		print(
			string.format(
				"%-25s %8d %8d %8d %7.0f%% %7.0f%% %12s",
				results.name,
				summary.AAA,
				summary.AA,
				summary.Fail,
				aaa_pct,
				aa_pct,
				target_display
			)
		)
	end
end

--- Main function to check all palettes and print report
function M.check_all()
	print("\n🔍 Analyzing WCAG Contrast Compliance for Oasis Palettes...")

	local all_results = M.analyze_all()

	-- Print comparison table first
	M.print_comparison_table(all_results)

	-- Coach user on getting detailed results
	print("\n" .. string.rep("=", 80))
	print("\nDetailed results available. Run with palette name for specifics:")
	print("  :lua require('oasis.wcag_checker').check_palette('oasis_lagoon')")
	print("  :lua require('oasis.wcag_checker').print_palette_results(")
	print("    require('oasis.wcag_checker').analyze_palette('oasis_lagoon'))")
end

--- Check a specific palette
---@param palette_name string Name of the palette
function M.check_palette(palette_name)
	local results = M.analyze_palette(palette_name)
	M.print_palette_results(results)
end

return M
