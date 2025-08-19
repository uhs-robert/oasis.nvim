-- ../lua/color_palettes/oasis-twilight.lua
local lush = require("lush")
local hsl = lush.hsl

local c = {
	-- Backgrounds
	bg = {
		main = hsl("#221B2F"),
		panel = hsl("#2B243B"),
		surface = hsl("#352D47"),
	},
	-- Foregrounds
	fg = {
		main = hsl("#EAE6F4"),
		muted = hsl("#9D92AA"),
	},
	-- UI
	ui = {
		accent = hsl("#F0E68C").darken(8),
		border = hsl("#F0E68C").desaturate(10).lighten(6),
		cursorLine = hsl("#2E2640"),
		nontext = hsl("#7B6E93"),
		visual = hsl("#46345C"),
	},
	-- Syntax
	syntax = {
		comment = hsl("#7B6E93").desaturate(12),
		constant = hsl("#E6B3A0").darken(10),
		func = hsl("#7ADFFF").darken(8),
		special = hsl("#FF9A57").desaturate(6).darken(10),
		statement = hsl("#F0E68C").darken(8),
		string = hsl("#FFA0A0").darken(14),
		type = hsl("#9FD3B4").darken(8),
	},
	-- Status
	status = {
		err_alt = hsl("#D47070").lighten(4),
		error = hsl("#FF4A4A").darken(8),
		info = hsl("#7B9CE0").desaturate(8).darken(8),
		success = hsl("#88E7A0").desaturate(10).darken(12),
		warning = hsl("#E6B450").desaturate(12).darken(12),
	},
	-- Diff
	diff = {
		add = hsl("#3DF41C").desaturate(20).darken(20),
		change = hsl("#5A7FAF").desaturate(10).darken(12),
		delete = hsl("#AF5A8F").desaturate(10).darken(12),
	},
}

return c
