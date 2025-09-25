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
		fill       = { fg = c.fg.muted, bg = c.bg.core },
		head       = { fg = c.bg.core, bg = c.syntax.statement },
		current_tab = { fg = c.bg.core, bg = c.syntax.statement },
		tab        = { fg = c.fg.muted, bg = c.bg.mantle },
		win        = { fg = c.fg.core, bg = c.bg.surface },
		tail       = { fg = c.bg.core, bg = c.syntax.statement },
	}
end

--- Setup tabby with oasis theme
---@param preset? string Tabby preset to use (default: 'tab_only')
function M.setup(preset)
	if not package.loaded['tabby'] then
		return
	end

	preset = preset or 'tab_only'

	require('tabby.tabline').use_preset(preset, {
		theme = M.get_theme()
	})
end

--- Refresh tabby theme (called by integration manager)
function M.refresh()
	if package.loaded['tabby'] and package.loaded['oasis.integrations.tabby'] then
		M.setup()
	end
end

-- Auto-register this integration
require('oasis.integrations').register('tabby', M)

return M