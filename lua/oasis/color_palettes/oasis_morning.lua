-- ../lua/color_palettes/oasis-morning.lua
local lush = require("lush")
local hsl = lush.hsl

local c = {
	-- Backgrounds
	bg = {
		main = hsl("#3A2412"),
		panel = hsl("#442A16"),
		surface = hsl("#52331A"),
	},
	-- Foregrounds
	fg = {
		main = hsl("#F7E2C9"),
		muted = hsl("#D9C1A6"),
	},
	-- UI
	ui = {
		accent = hsl("#F0D07C").desaturate(6).darken(4),
		border = hsl("#F0D07C").desaturate(6).lighten(6),
		cursorLine = hsl("#4A2F18"),
		nontext = hsl("#D79A4D").desaturate(15).darken(12),
		visual = hsl("#8B4A26").darken(6),
	},
	-- Syntax
	syntax = {
		comment = hsl("#6DCEEB").desaturate(38).darken(30),
		constant = hsl("#FFC87A").darken(18),
		func = hsl("#40D9FF").desaturate(12).darken(10),
		special = hsl("#FF8A3C").darken(6),
		statement = hsl("#F0D07C").darken(8),
		string = hsl("#FF9A7A").darken(12),
		type = hsl("#9EC55C").darken(6),
	},
	-- Status
	status = {
		err_alt = hsl("#D05C3C").lighten(2),
		error = hsl("#FF4A2A").darken(10),
		info = hsl("#6F98FF").desaturate(14).darken(10),
		success = hsl("#7FD48C").desaturate(10).darken(12),
		warning = hsl("#EAB020").desaturate(12).darken(10),
	},
	-- Diff
	diff = {
		add = hsl("#5F875F").desaturate(18).darken(18),
		change = hsl("#5F87AF").desaturate(10).darken(12),
		delete = hsl("#AF5F7F").desaturate(12).darken(14),
	},
}

return c
