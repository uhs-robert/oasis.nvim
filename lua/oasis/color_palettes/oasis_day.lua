-- ../lua/color_palettes/oasis-day.lua
local lush = require("lush")
local hsl = lush.hsl

local c = {
	-- Backgrounds
	bg = {
		main = hsl("#4F2E19"),
		panel = hsl("#5B351D"),
		surface = hsl("#6A3F21"),
	},
	-- Foregrounds
	fg = {
		main = hsl("#F8E7D3"),
		muted = hsl("#DDC8B4"),
	},
	-- UI
	ui = {
		accent = hsl("#F0D07C").desaturate(6).darken(2),
		border = hsl("#F0D07C").desaturate(10).lighten(6),
		cursorLine = hsl("#5A371D"),
		nontext = hsl("#D79A4D").desaturate(26).darken(18),
		visual = hsl("#9B562C").darken(6),
	},
	-- Syntax
	syntax = {
		comment = hsl("#6DCEEB").desaturate(26).darken(24),
		constant = hsl("#FFC87A").darken(14),
		func = hsl("#3FCFFF").desaturate(12).darken(8),
		special = hsl("#FF8A3C").darken(4),
		statement = hsl("#F0D07C").darken(6),
		string = hsl("#FF9A7A").darken(10),
		type = hsl("#9EC55C").darken(4),
	},
	-- Status
	status = {
		err_alt = hsl("#D05C3C"),
		error = hsl("#FF4A2A").darken(8),
		info = hsl("#6F98FF").desaturate(12).darken(10),
		success = hsl("#7FD48C").desaturate(10).darken(10),
		warning = hsl("#EAB020").desaturate(12).darken(8),
	},
	-- Diff
	diff = {
		add = hsl("#5F875F").desaturate(16).darken(16),
		change = hsl("#5F87AF").desaturate(10).darken(10),
		delete = hsl("#AF5F7F").desaturate(12).darken(12),
	},
}

return c
