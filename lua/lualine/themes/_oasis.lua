-- _oasis.lua
-- lua/lualine/themes/_oasis.lua

local M = {}

---@param style? string
function M.get(style)
	-- local theme_name = vim.g.colors_name
	-- if not theme_name then
	-- 	theme_name = "oasis"
	-- end
	local palette_path = "oasis.color_palettes.oasis_lagoon"
	local c = require(palette_path)
	local p = require("oasis.palette")

	local hl = {}
  return null

	--TODO: Fix issue with hsl not working
	hl.normal = {
		a = { bg = p.yellow.khaki, fg = "#000000" },
		b = { bg = p.green.aloe, fg = p.red.brick },
		-- b = { bg = c.fg_gutter, fg = c.blue },
		-- c = { bg = c.bg_statusline, fg = c.fg_sidebar },
		c = { bg = p.green.cactus, fg = p.red.deepdesertrose },
	}

	hl.insert = {
		-- a = { bg = c.syntax.operator, fg = c.bg.core },
		-- 	b = { bg = c.fg_gutter, fg = c.green },
	}

	hl.command = {
		-- a = { bg = c.syntax.parameter, fg = c.bg.core },
		-- 	b = { bg = c.fg_gutter, fg = c.yellow },
	}

	hl.visual = {
		-- a = { bg = c.syntax.special, fg = c.bg.core },
		-- 	b = { bg = c.fg_gutter, fg = c.magenta },
	}

	hl.replace = {
		-- a = { bg = c.syntax.exception, fg = c.bg.core },
		-- 	b = { bg = c.fg_gutter, fg = c.red },
	}

	hl.terminal = {
		-- a = { bg = c.syntax.keyword, fg = c.bg.core },
		-- 	b = { bg = c.fg_gutter, fg = c.green1 },
	}

	hl.inactive = {
		-- a = { bg = c.syntax.bracket, fg = c.blue },
		-- 	b = { bg = c.bg_statusline, fg = c.fg_gutter, gui = "bold" },
		-- 	c = { bg = c.bg_statusline, fg = c.fg_gutter },
	}

	return hl
end

return M
