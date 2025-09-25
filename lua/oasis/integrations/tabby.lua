-- lua/oasis/integrations/tabby.lua
-- Tabby.nvim integration for oasis colorscheme

local M = {}

--- Get current oasis palette for tabby theme
---@return table
function M.get_theme()
	-- Get current palette name from vim.g.colors_name
	local current_palette = vim.g.colors_name or "oasis_lagoon"

	-- Load the current palette
	local ok, c = pcall(require, "oasis.color_palettes." .. current_palette)
	if not ok then
		-- Fallback to lagoon palette
		c = require("oasis.color_palettes.oasis_lagoon")
	end

	return {
		fill = { fg = c.fg.muted, bg = c.bg.core }, -- tabline background
		head = { fg = c.bg.core, bg = c.syntax.statement }, -- head element
		current_tab = { fg = c.bg.core, bg = c.syntax.statement }, -- current tab label
		tab = { fg = c.fg.muted, bg = c.bg.mantle }, -- other tab label
		win = { fg = c.fg.core, bg = c.bg.surface }, -- window
		tail = { fg = c.bg.core, bg = c.syntax.statement }, -- tail element
	}
end

--- Setup tabby with dynamic oasis theme using presets
---@param preset? string Tabby preset to use (default: 'active_wins_at_tail')
---@param options? table Additional options for tabby
function M.setup(preset, options)
	if not package.loaded["tabby"] then
		return
	end

	preset = preset or "active_wins_at_tail"
	options = options or {}

	-- Merge oasis theme with user options
	local config = vim.tbl_deep_extend("force", {
		preset = preset,
		option = vim.tbl_deep_extend("force", {
			theme = M.get_theme(),
			nerdfont = true,
		}, options),
	}, {})

	require("tabby").setup(config)
end

--- Update existing tabby config with oasis theme (for use with your existing config)
function M.apply_to_existing_config(opts)
	if not opts.option then
		opts.option = {}
	end

	-- Set dynamic oasis theme
	opts.option.theme = M.get_theme()

	return opts
end

--- Refresh tabby theme (called by integration manager)
function M.refresh()
	if package.loaded["tabby"] then
		-- Just trigger a redraw - tabby will call get_theme() automatically
		vim.cmd("redrawtabline")
	end
end

-- Auto-register this integration
require("oasis.integrations").register("tabby", M)

return M
