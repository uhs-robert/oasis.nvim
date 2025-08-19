-- ../lua/color_palettes/oasis-night.lua
local lush = require("lush")
local hsl = lush.hsl

local c = {
	-- Backgrounds
	bg = {
		main = hsl("#0D0D1A"),
		panel = hsl("#1A1A26"),
		surface = hsl("#262633"),
	},
	-- Foregrounds
	fg = {
		main = hsl("#D0D0E0"),
		muted = hsl("#7A7A99"),
	},
	-- UI
	ui = {
		accent = hsl("#4DB8FF").desaturate(10).darken(8),
		border = hsl("#4DB8FF").desaturate(10).lighten(6),
		cursorLine = hsl("#4DB8FF").desaturate(50).darken(80),
		nontext = hsl("#5A544A").lighten(4),
		visual = hsl("#4DB8FF").desaturate(40).darken(70),
	},
	-- Syntax
	syntax = {
		comment = hsl("#5F87AF").darken(20),
		constant = hsl("#FFDE9B").darken(10),
		func = hsl("#00E5FF").desaturate(18).darken(10),
		special = hsl("#CD853F").darken(12),
		statement = hsl("#F0E68C").darken(12),
		string = hsl("#FFA0A0").darken(6),
		type = hsl("#9ACDFF").darken(6),
	},
	-- Status
	status = {
		err_alt = hsl("#CD5C5C").darken(10),
		error = hsl("#FF4D4D").darken(12),
		info = hsl("#5F87AF"),
		success = hsl("#6FCF97").darken(14),
		warning = hsl("#DCDC78").darken(14),
	},
	-- Diff
	diff = {
		add = hsl("#37F413").desaturate(30).darken(30),
		change = hsl("#5F87AF").darken(14),
		delete = hsl("#AF5FAF").darken(14),
	},
}

return c
