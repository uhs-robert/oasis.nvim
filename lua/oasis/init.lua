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

--- Apply Oasis using a palette module name (no prefix).
--- Examples:
---   require('oasis').apply('oasis_midnight')
---   require('oasis').apply('oasis')
---@param palette_name string|nil
function M.apply(palette_name)
	local utils = require("oasis.utils")
	local bg = vim.o.background

	-- Use the provided `palette_name` or get one from the configuration
	if not palette_name then
		palette_name = config.get_palette_name()
	else
		local is_current_theme = (palette_name == M.styles.current)
		local last_theme_for_this_bg = M.styles[bg]

		-- Background change detected
		if is_current_theme and palette_name ~= last_theme_for_this_bg then
			-- Determine what the configured theme was for the OLD background
			local old_bg = bg == "light" and "dark" or "light"
			local cfg = config.get()
			local old_style_option = old_bg == "light" and cfg.light_style or cfg.dark_style

			-- Resolve "auto" for old background
			if old_style_option == "auto" then
				old_style_option = cfg.style
			end

			local old_configured_palette = "oasis_" .. old_style_option

			-- Check if user was on their configured theme for the old background
			if palette_name == old_configured_palette then
				-- User was on configured theme, switch to configured theme for new bg
				palette_name = config.get_palette_name()
			else
				-- User manually picked a different theme, try to maintain their choice
				local mode = utils.get_palette_mode(palette_name)
				if not (mode == "dual" or mode == bg) then
					-- Current theme incompatible, fall back to configured theme
					palette_name = config.get_palette_name()
				end
				-- else: keep current theme (it's compatible with the new background)
			end
		end
	end

	-- Check for theme compatibility and auto-adjust background if needed
	local mode = utils.get_palette_mode(palette_name)
	if not mode then
		vim.notify(string.format('Oasis: Palette "%s" not found.', palette_name), vim.log.levels.ERROR)
		return
	end

	-- Auto-adjust background to match theme mode
	if mode ~= "dual" and mode ~= bg then
		vim.o.background = mode
		bg = mode
	end

	-- Remember and apply
	M.styles.current = palette_name
	M.styles[bg] = palette_name

	-- Reset
	vim.cmd("highlight clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end

	-- Use a fresh palette load
	package.loaded["oasis.color_palettes." .. palette_name] = nil

	-- Load and extract palette.
	local c, err = utils.load_and_extract_palette("oasis.color_palettes." .. palette_name, nil)
	if not c then
		error(('Oasis: palette "%s" not found: %s'):format(palette_name, err))
	end

	vim.g.colors_name = palette_name:gsub("_", "-") -- Convert to hyphen for colorscheme file convention

	-- Apply palette overrides from config
	c = config.apply_palette_overrides(c, palette_name)

	-- Build and apply the colorscheme
	local build = require("oasis.theme_generator")
	build(c)

	-- Load and refresh plugin integrations
	pcall(require, "oasis.integrations.lualine")
	pcall(require, "oasis.integrations.tabby")
	require("oasis.integrations").refresh_all()
end

-- :Oasis <palette> command with completion from lua/oasis/color_palettes/*.lua
vim.api.nvim_create_user_command("Oasis", function(opts)
	M.apply(opts.args ~= "" and opts.args or nil)
end, {
	nargs = "?",
	complete = function()
		local utils = require("oasis.utils")
		local bg = vim.o.background
		local paths = vim.fn.globpath(vim.o.rtp, "lua/oasis/color_palettes/*.lua", false, true)
		local out = {}

		for _, p in ipairs(paths) do
			local name = p:match("[\\/]color_palettes[\\/](.+)%.lua$")
			if name and name ~= "init" then
				local mode = utils.get_palette_mode(name)
				if mode == "dual" or mode == bg then
					table.insert(out, name)
				end
			end
		end

		table.sort(out)
		return out
	end,
})

-- :OasisWCAG [palette] command to check WCAG contrast compliance
vim.api.nvim_create_user_command("OasisWCAG", function(opts)
	local wcag = require("oasis.tools.wcag_checker")
	if opts.args ~= "" then
		wcag.check_palette(opts.args)
	else
		wcag.check_all()
	end
end, {
	nargs = "?",
	complete = function()
		-- Glob all palette files on runtimepath
		local paths = vim.fn.globpath(vim.o.rtp, "lua/oasis/color_palettes/*.lua", false, true)
		local out = {}
		for _, p in ipairs(paths) do
			-- handle / or \ separators; capture the basename
			local name = p:match("[\\/]color_palettes[\\/](.+)%.lua$")
			if name and name ~= "init" then
				table.insert(out, name)
			end
		end
		table.sort(out)
		return out
	end,
})

-- :OasisTransparency command to toggle transparency mid-session
vim.api.nvim_create_user_command("OasisTransparency", function()
	M.toggle_transparency()
end, {
	desc = "Toggle transparency for Oasis theme",
})

-- :OasisThemedSyntax command to toggle themed syntax mid-session
vim.api.nvim_create_user_command("OasisThemedSyntax", function()
	M.toggle_themed_syntax()
end, {
	desc = "Toggle themed syntax using primary color for statements/keywords (dark themes only)",
})

-- :OasisIntensity command to show UI picker to select intensity mid-session
vim.api.nvim_create_user_command("OasisIntensity", function()
	M.cycle_intensity()
end, {
	desc = "Show UI picker for light background intensity (1-5)",
})

return M
