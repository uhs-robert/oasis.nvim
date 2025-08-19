-- ../lua/color_palettes/oasis-midnight.lua
local lush = require("lush")
local hsl = lush.hsl

local c = {
	-- Backgrounds
	bg = {
		main = hsl("#000000"),
		panel = hsl("#1A1A1A"),
		surface = hsl("#333333"),
	},
	-- Foregrounds
	fg = {
		main = hsl("#E0E0E0"),
		muted = hsl("#5A544A").lighten(10),
	},
	-- UI
	ui = {
		accent = hsl("#4AC8FF").desaturate(10).darken(10),
		border = hsl("#4AC8FF").desaturate(10).lighten(6),
		cursorLine = hsl("#6DCEEB").desaturate(40).darken(82),
		nontext = hsl("#5A544A").lighten(10),
		visual = hsl("#6DCEEB").desaturate(20).darken(78),
	},
	-- Syntax
	syntax = {
		comment = hsl("#6DCEEB").darken(42),
		constant = hsl("#FFDE9B").darken(14),
		func = hsl("#00E5FF").desaturate(6).lighten(4),
		special = hsl("#CD853F").lighten(4),
		statement = hsl("#F0E68C").darken(4),
		string = hsl("#FFA0A0").darken(4),
		type = hsl("#9ACD32").lighten(4),
	},
	-- Status
	status = {
		err_alt = hsl("#CD5C5C").lighten(4),
		error = hsl("#FF0000").darken(6),
		info = hsl("#75A0FF").desaturate(8).darken(8),
		success = hsl("#89FB98").desaturate(6).darken(6),
		warning = hsl("#EEEE00").desaturate(8).darken(6),
	},
	-- Diff
	diff = {
		add = hsl("#37F413").desaturate(8).darken(12),
		change = hsl("#5F87AF").darken(8),
		delete = hsl("#AF5FAF").darken(8),
	},
}

return c
