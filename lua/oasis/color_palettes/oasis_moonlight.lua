-- ../lua/color_palettes/oasis-moonlight.lua
local lush = require("lush")
local hsl = lush.hsl

local c = {
	-- Backgrounds
	bg = {
		main = hsl("#000000"),
		panel = hsl("#111111"),
		surface = hsl("#1A1A1A"),
	},
	-- Foregrounds
	fg = {
		main = hsl("#E0E0E0"),
		muted = hsl("#808080"),
	},
	-- UI
	ui = {
		accent = hsl("#4DB8FF").desaturate(10),
		border = hsl("#4DB8FF").desaturate(10).lighten(10),
		cursorLine = hsl("#4DB8FF").desaturate(50).darken(85),
		nontext = hsl("#5A544A").lighten(10), -- preference
		visual = hsl("#4DB8FF").desaturate(40).darken(80),
	},
	-- Syntax
	syntax = {
		comment = hsl("#6DA0C0").darken(22),
		constant = hsl("#FFD99A").darken(14),
		func = hsl("#00E5FF").darken(14),
		special = hsl("#CD853F").darken(18),
		statement = hsl("#F0E68C").darken(14),
		string = hsl("#FFA0A0").darken(8),
		type = hsl("#9ACDFF"),
	},
	-- Status
	status = {
		err_alt = hsl("#CD5C5C"),
		error = hsl("#FF4D4D"),
		info = hsl("#5F87FF").darken(6),
		success = hsl("#6FCF97"),
		warning = hsl("#EEEE00").darken(12),
	},
	-- Diff
	diff = {
		add = hsl("#37F413").desaturate(20).darken(20),
		change = hsl("#5F87AF").darken(10),
		delete = hsl("#AF5FAF").darken(10),
	},
}

return c
