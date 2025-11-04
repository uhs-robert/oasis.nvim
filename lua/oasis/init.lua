-- lua/oasis/init.lua
local M = {}
local config = require("oasis.config")

-- Track the expected background value to prevent circular triggering
-- When we set background ourselves, we store the value here so we can ignore that specific OptionSet event
local expected_background_value = nil

--- Check if this background value change was triggered by Oasis itself
---@param new_value string The new background value to check
---@return boolean
function M.is_manual_bg_change(new_value)
	local result = expected_background_value == new_value
	if result then
		expected_background_value = nil
	end
	return result
end

--- Setup Oasis with user configuration
--- Note: This only configures Oasis. To apply the theme, use :colorscheme oasis
--- Examples:
---   require('oasis').setup({
---     style = "lagoon",  -- Shorthand for "oasis_lagoon"
---     dark_style = "lagoon",
---     light_style = "dawn",
---     useLegacyComments = true,
---     palette_overrides = { oasis_desert = { syntax = { comment = "#87CEEB" } } },
---     highlight_overrides = { Comment = { fg = "#AABBCC" } }
---   })
---   vim.cmd.colorscheme('oasis')  -- Apply the theme
---@param user_config table|nil User configuration
function M.setup(user_config)
	config.setup(user_config)
end

--- Apply Oasis using a palette module name (no prefix).
--- Examples:
---   require('oasis').apply('oasis_midnight')
---   require('oasis').apply('oasis')         -- default
---@param palette_name string|nil
---@param opts table|nil Options table with skip_background_set flag
function M.apply(palette_name, opts)
	opts = opts or {}

	-- Reset
	vim.cmd("highlight clear")
	vim.cmd("syntax reset")
	palette_name = palette_name or config.get_palette_name() or vim.g.oasis_palette or "oasis_lagoon"

	-- Load palette
	local ok, c = pcall(require, "oasis.color_palettes." .. palette_name)
	if not ok then
		error(('Oasis: palette "%s" not found: %s'):format(palette_name, c))
	end

	-- Set background based on palette metadata (light_mode flag)
	-- Skip if requested (e.g., when called from auto-switch)
	if not opts.skip_background_set then
		local target_bg = (c.light_mode == true) and "light" or "dark"
		expected_background_value = target_bg
		vim.opt.background = target_bg
	end

	vim.g.colors_name = palette_name:gsub("_", "-") -- Convert to hyphen format to match colorscheme files
	vim.g.is_oasis_active = true -- Track whether Oasis is the active colorscheme

	-- Apply palette overrides from config
	c = config.apply_palette_overrides(c, palette_name)

	-- Build and apply the colorscheme
	local build = require("oasis.theme_generator")
	build(c, palette_name)

	-- Load and refresh plugin integrations
	pcall(require, "oasis.integrations.lualine")
	pcall(require, "oasis.integrations.tabby")
	require("oasis.integrations").refresh_all()

	-- Set up day/night auto-switching (only runs once)
	require("oasis.day_night_switch").setup()
end

-- :Oasis <palette> command with completion from lua/oasis/color_palettes/*.lua
vim.api.nvim_create_user_command("Oasis", function(opts)
	M.apply(opts.args ~= "" and opts.args or nil)
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

return M
