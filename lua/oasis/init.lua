-- lua/oasis/init.lua
local M = {}
local config = require("oasis.config")

--- Track current and remembered styles for light/dark switching
---@type {current?: string, light?: string, dark?: string}
M.styles = {}

--- Setup Oasis with user configuration
--- Note: This only configures Oasis. To apply the theme, use :colorscheme oasis
--- Examples:
---   require('oasis').setup({
---     style = "lagoon",
---     dark_style = "auto",
---     light_style = "auto",
---     palette_overrides = { oasis_desert = { syntax = { comment = "#87CEEB" } } },
---     highlight_overrides = { Comment = { fg = "#AABBCC" } }
---   })
---   vim.cmd.colorscheme('oasis')  -- Apply the theme
---@param user_config table|nil User configuration
function M.setup(user_config)
	config.setup(user_config)
end

--- Toggle transparency and reapply the current theme
--- Examples:
---   require('oasis').toggle_transparency()
---   :OasisTransparency
function M.toggle_transparency()
	local cfg = config.get()
	cfg.transparent = not cfg.transparent
	M.apply(M.styles.current)
	local status = cfg.transparent and "enabled" or "disabled"
	vim.notify(string.format("Oasis transparency %s", status), vim.log.levels.INFO)
end

--- Toggle themed_syntax and reapply the current theme
--- Examples:
---   require('oasis').toggle_themed_syntax()
---   :OasisThemedSyntax
function M.toggle_themed_syntax()
	local cfg = config.get()
	cfg.themed_syntax = not cfg.themed_syntax
	M.apply(M.styles.current)
	local status = cfg.themed_syntax and "enabled" or "disabled"
	vim.notify(string.format("Oasis themed syntax %s", status), vim.log.levels.INFO)
end

--- Select light intensity via UI picker or cycle through light intensity (1→2→3→4→5→1→2...)
--- Examples:
---   require('oasis').cycle_intensity(true|nil) -- Shows UI picker
---   require('oasis').cycle_intensity(false)    -- Cycles intensity
---   :OasisIntensity                            -- Shows UI picker
---@param show_picker boolean|nil If true or nil, shows a UI picker; else if false, cycles
function M.cycle_intensity(show_picker)
	local cfg = config.get()

	if show_picker ~= false then
		local option_names = { "Very Low", "Low", "Medium", "High", "Very High" }
		vim.ui.select(option_names, {
			prompt = "Select Oasis Light Intensity (1-5)",
			initial = option_names[cfg.light_intensity],
		}, function(selected_name)
			if selected_name then
				local selected_intensity_number
				for i, name in ipairs(option_names) do
					if name == selected_name then
						selected_intensity_number = i
						break
					end
				end
				cfg.light_intensity = selected_intensity_number
				M.apply(M.styles.current)
				vim.notify(string.format("Oasis light intensity: %d/5", cfg.light_intensity), vim.log.levels.INFO)
			else
				vim.notify("Oasis light intensity selection cancelled", vim.log.levels.INFO)
			end
		end)
	else -- Increment and wrap around
		local next_intensity = cfg.light_intensity + 1
		if next_intensity > 5 then
			next_intensity = 1
		end

		cfg.light_intensity = next_intensity
		M.apply(M.styles.current)
		vim.notify(string.format("Oasis light intensity: %d/5", next_intensity), vim.log.levels.INFO)
	end
end

--- Resolve palette name based on config and background changes
---@param palette_name string|nil User-provided palette name
---@param bg string Current background ("light" or "dark")
---@return string resolved_palette The palette name to use
local function resolve_palette_name(palette_name, bg)
	local utils = require("oasis.utils")
	local resolved_palette = palette_name or config.get_palette_name() or "oasis_lagoon"
	local is_current_theme = (resolved_palette == M.styles.current)
	local last_theme_for_this_bg = M.styles[bg]

	-- Background change detected - handle theme switching logic
	if is_current_theme and resolved_palette ~= last_theme_for_this_bg then
		local old_bg = bg == "light" and "dark" or "light"
		local cfg = config.get()
		local old_style_option = old_bg == "light" and cfg.light_style or cfg.dark_style

		-- Resolve "auto" for old background
		if old_style_option == "auto" then
			old_style_option = cfg.style
		end

		-- Check if user was on their configured theme for the old background
		local old_configured_palette = "oasis_" .. old_style_option
		local should_use_config = resolved_palette == old_configured_palette
		if should_use_config then
			return config.get_palette_name() or "oasis_lagoon"
		else
			local mode = utils.get_palette_mode(resolved_palette)
			if not (mode == "dual" or mode == bg) then
				return config.get_palette_name() or "oasis_lagoon" -- error: fallback to configured theme
			end
			-- else: keep current theme
		end
	end

	return resolved_palette
end

--- Ensure palette is compatible with background and auto-adjust if needed
---@param palette_name string Palette name to check
---@return string|nil mode The palette mode ("light", "dark", or "dual"), or nil if not found
---@return string bg The (possibly adjusted) background
local function ensure_palette_compatibility(palette_name)
	local utils = require("oasis.utils")
	local bg = vim.o.background

	local mode = utils.get_palette_mode(palette_name)
	if not mode then
		vim.notify(string.format('Oasis: Palette "%s" not found.', palette_name), vim.log.levels.ERROR)
		return nil, bg
	end

	-- Auto-adjust background to match theme mode (for legacy light themes without dual mode)
	if mode ~= "dual" and mode ~= bg then
		vim.o.background = mode
		bg = mode
	end

	return mode, bg
end

--- Remember current style choices for light/dark switching
---@param palette_name string Palette to remember
---@param bg string Current background
local function remember_style(palette_name, bg)
	M.styles.current = palette_name
	M.styles[bg] = palette_name
end

--- Reset existing highlights
local function reset_highlights()
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
end

--- Load palette module with overrides applied
---@param palette_name string Palette name to load
---@return table palette The loaded palette (errors if not found)
local function load_palette_module(palette_name)
	local utils = require("oasis.utils")

	-- Use a fresh palette load
	package.loaded["oasis.color_palettes." .. palette_name] = nil

	-- Load and extract palette
	local palette, err = utils.load_and_extract_palette("oasis.color_palettes." .. palette_name, nil)
	if not palette then
		error(('Oasis: palette "%s" not found: %s'):format(palette_name, err))
	end

	vim.g.colors_name = palette_name:gsub("_", "-")

	return config.apply_palette_overrides(palette, palette_name)
end

--- Apply theme and refresh plugin integrations
---@param palette table The color palette to apply
local function apply_theme(palette)
	local build = require("oasis.theme_generator")
	build(palette)

	-- Load and refresh plugin integrations
	pcall(require, "oasis.integrations.lualine")
	pcall(require, "oasis.integrations.tabby")
	require("oasis.integrations").refresh_all()
end

--- Apply Oasis using a palette module name (no prefix).
--- Examples:
---   require('oasis').apply('oasis_midnight')
---   require('oasis').apply('oasis')
---@param palette_name string|nil
function M.apply(palette_name)
	local bg = vim.o.background

	palette_name = resolve_palette_name(palette_name, bg)

	local mode, adjusted_bg = ensure_palette_compatibility(palette_name)
	if not mode then
		return -- Error already notified
	end
	bg = adjusted_bg

	remember_style(palette_name, bg)
	reset_highlights()
	local palette = load_palette_module(palette_name)
	apply_theme(palette)
end

-- Setup API commands
require("oasis.api").setup(M)

return M
