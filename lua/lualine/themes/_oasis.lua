-- lua/lualine/themes/_oasis.lua

local M = {}

---@param style? string
function M.get(style)
	-- local theme_name = vim.g.colors_name
	-- if not theme_name then
	-- 	theme_name = "oasis"
	-- end
	local palette_path = "oasis.color_palettes." .. style
	local c = require(palette_path)

	local hl = {}

	hl.normal = {
		a = { bg = c.syntax.statement, fg = c.bg.core },
	-- 	b = { bg = c.fg_gutter, fg = c.blue },
	-- 	c = { bg = c.bg_statusline, fg = c.fg_sidebar },
  }

	hl.insert = {
		a = { bg = c.syntax., fg = c.core },
	-- 	b = { bg = c.fg_gutter, fg = c.green },
	}

	hl.command = {
		a = { bg = c.yellow, fg = c.core },
	-- 	b = { bg = c.fg_gutter, fg = c.yellow },
	}

	hl.visual = {
		a = { bg = c.magenta, fg = c.core },
	-- 	b = { bg = c.fg_gutter, fg = c.magenta },
	}

	hl.replace = {
		a = { bg = c.red, fg = c.core },
	-- 	b = { bg = c.fg_gutter, fg = c.red },
	}

	hl.terminal = {
		a = { bg = c.green1, fg = c.core },
	-- 	b = { bg = c.fg_gutter, fg = c.green1 },
	}

	hl.inactive = {
		a = { bg = c.bg_statusline, fg = c.blue },
	-- 	b = { bg = c.bg_statusline, fg = c.fg_gutter, gui = "bold" },
	-- 	c = { bg = c.bg_statusline, fg = c.fg_gutter },
	}

	return hl
end

return M
