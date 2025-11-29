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

--- Apply Oasis using a palette module name (no prefix).
--- Examples:
---   require('oasis').apply('oasis_midnight')
---   require('oasis').apply('oasis')         -- default
---@param palette_name string|nil
function M.apply(palette_name)
	palette_name = palette_name or vim.g.oasis_palette or config.get_palette_name()
	local bg = vim.o.background
	local cfg = config.get()
	local is_light_style = palette_name == ("oasis_" .. cfg.light_style)
	local expected_bg = is_light_style and "light" or "dark"

	-- If we're switching between light/dark, prefer users last choice if different style from config
	if palette_name == M.styles.current and bg ~= expected_bg then
		if bg == "light" then
			palette_name = M.styles.light or ("oasis_" .. cfg.light_style)
		else
			palette_name = M.styles.dark or ("oasis_" .. cfg.dark_style)
		end
	elseif bg ~= expected_bg then
		vim.o.background = expected_bg
	end

	-- Remember this style choice for the current background
	M.styles.current = palette_name
	M.styles[vim.o.background] = palette_name

	-- Reset
	vim.cmd("highlight clear")
	vim.cmd("syntax reset")

	-- Clear palette cache to ensure fresh load with current config
	package.loaded["oasis.color_palettes." .. palette_name] = nil

	-- Load palette (will read fresh config)
	local ok, c = pcall(require, "oasis.color_palettes." .. palette_name)
	if not ok then
		error(('Oasis: palette "%s" not found: %s'):format(palette_name, c))
	end

	vim.g.colors_name = palette_name:gsub("_", "-") -- Convert to hyphen format to match colorscheme files

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

return M
