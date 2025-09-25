-- lua/lualine/themes/_oasis.lua

local M = {}

---@param style? string
function M.get(style)
	-- Default to lagoon if no style specified
	local palette_name = (style and ("oasis_" .. style)) or "oasis_lagoon"

	-- Load the specified palette
	local ok, c = pcall(require, "oasis.color_palettes." .. palette_name)
	if not ok then
		c = require("oasis.color_palettes.oasis_lagoon")
	end

	local hl = {}

	hl.normal = {
		a = { bg = c.syntax.statement, fg = c.bg.core },
		b = { bg = c.bg.mantle, fg = c.fg.core },
		c = { bg = c.bg.surface, fg = c.fg.muted },
	}

	hl.insert = {
		a = { bg = c.syntax.operator, fg = c.bg.core },
		b = { bg = c.bg.mantle, fg = c.syntax.operator },
	}

	hl.command = {
		a = { bg = c.syntax.parameter, fg = c.bg.core },
		b = { bg = c.bg.mantle, fg = c.syntax.parameter },
	}

	hl.visual = {
		a = { bg = c.syntax.special, fg = c.bg.core },
		b = { bg = c.bg.mantle, fg = c.syntax.special },
	}

	hl.replace = {
		a = { bg = c.syntax.exception, fg = c.bg.core },
		b = { bg = c.bg.mantle, fg = c.syntax.exception },
	}

	hl.terminal = {
		a = { bg = c.syntax.keyword, fg = c.bg.core },
		b = { bg = c.bg.mantle, fg = c.syntax.keyword },
	}

	hl.inactive = {
		a = { bg = c.bg.mantle, fg = c.fg.dim },
		b = { bg = c.bg.surface, fg = c.fg.dim, gui = "bold" },
		c = { bg = c.bg.surface, fg = c.fg.dim },
	}

	return hl
end

return M
