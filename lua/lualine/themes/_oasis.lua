-- lua/lualine/themes/_oasis.lua

local M = {}

---@param style? string
function M.get(style)
	-- Default to lagoon if no style specified
	local palette_name = (style and ("oasis_" .. style)) or "oasis_lagoon"

	-- Load and extract the specified palette (handles both legacy and dual-mode)
	local utils = require("oasis.utils")
	local c, err = utils.load_and_extract_palette("oasis.color_palettes." .. palette_name)
	if not c then
		c, err = utils.load_and_extract_palette("oasis.color_palettes.oasis_lagoon")
	end

	local hl = {}

	hl.normal = {
		a = { bg = c.syntax.statement, fg = c.bg.core },
		b = { bg = c.bg.mantle, fg = c.syntax.statement },
		c = { bg = c.bg.surface, fg = c.fg.core },
	}

	hl.insert = {
		a = { bg = c.syntax.string, fg = c.bg.core },
		b = { bg = c.bg.mantle, fg = c.syntax.string },
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
		a = { bg = c.syntax.operator, fg = c.bg.core },
		b = { bg = c.bg.mantle, fg = c.syntax.operator },
	}

	hl.terminal = {
		a = { bg = c.syntax.type, fg = c.bg.core },
		b = { bg = c.bg.mantle, fg = c.syntax.type },
	}

	hl.inactive = {
		a = { bg = c.bg.mantle, fg = c.fg.dim },
		b = { bg = c.bg.surface, fg = c.fg.dim, gui = "bold" },
		c = { bg = c.bg.surface, fg = c.fg.dim },
	}

	return hl
end

return M
