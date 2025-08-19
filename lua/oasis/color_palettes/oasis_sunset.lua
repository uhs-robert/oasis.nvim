-- ../lua/color_palettes/oasis-sunset.lua
local lush = require("lush")
local hsl = lush.hsl

local c = {
	-- Backgrounds
	bg = {
		main = hsl("#2B1D1B"),
		panel = hsl("#35231F"),
		surface = hsl("#433129"),
	},
	-- Foregrounds
	fg = {
		main = hsl("#F5E6DC"),
		muted = hsl("#D5C2B2"),
	},
	-- UI
	ui = {
		accent = hsl("#FF9A57").desaturate(6).darken(6),
		border = hsl("#FF9A57").desaturate(6).lighten(6),
		cursorLine = hsl("#3A251E"),
		nontext = hsl("#B89F7A").desaturate(30).darken(20),
		visual = hsl("#6B3A2A").darken(10),
	},
	-- Syntax
	syntax = {
		comment = hsl("#A68E7A").desaturate(20),
		constant = hsl("#FFD99A").darken(14),
		func = hsl("#74D0FF").darken(8),
		special = hsl("#FF9A57").darken(6),
		statement = hsl("#F0E68C").darken(6),
		string = hsl("#FFA0A0").darken(12),
		type = hsl("#A7C770"),
	},
	-- Status
	status = {
		err_alt = hsl("#CD5C5C").lighten(2),
		error = hsl("#FF4A4A").darken(8),
		info = hsl("#75A0FF").desaturate(14).darken(10),
		success = hsl("#86E79A").desaturate(10).darken(10),
		warning = hsl("#F0D000").desaturate(12).darken(8),
	},
	-- Diff
	diff = {
		add = hsl("#5F875F").desaturate(20).darken(20),
		change = hsl("#5F87AF").desaturate(10).darken(10),
		delete = hsl("#AF5FAF").desaturate(10).darken(12),
	},
}

return c
