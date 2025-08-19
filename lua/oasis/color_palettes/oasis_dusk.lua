-- ../lua/color_palettes/oasis-dusk.lua
local lush = require("lush")
local hsl = lush.hsl

local c = {
	-- Backgrounds
	bg = {
		main = hsl("#1C1A29"),
		panel = hsl("#242236"),
		surface = hsl("#2E2B45"),
	},
	-- Foregrounds
	fg = {
		main = hsl("#E8E6F0"),
		muted = hsl("#A39CAE"),
	},
	-- UI
	ui = {
		accent = hsl("#F0E68C").darken(12),
		border = hsl("#F0E68C").desaturate(10).lighten(6),
		cursorLine = hsl("#2A2738"),
		nontext = hsl("#7C6F92").desaturate(12),
		visual = hsl("#4B3B6B").darken(12),
	},
	-- Syntax
	syntax = {
		comment = hsl("#7C6F92").desaturate(20),
		constant = hsl("#E6B3A0").darken(12),
		func = hsl("#79D9FF").darken(10),
		special = hsl("#FF9A57").desaturate(12).darken(12),
		statement = hsl("#F0E68C").darken(10),
		string = hsl("#FFA0A0").darken(16),
		type = hsl("#90CFAE"),
	},
	-- Status
	status = {
		err_alt = hsl("#CD5C5C").darken(4),
		error = hsl("#FF4A4A").darken(10),
		info = hsl("#7BA4F2").desaturate(10).darken(6),
		success = hsl("#86E79A").desaturate(14).darken(14),
		warning = hsl("#F0E68C").desaturate(10).darken(10),
	},
	-- Diff
	diff = {
		add = hsl("#37F413").desaturate(22).darken(24),
		change = hsl("#5F87AF").desaturate(12).darken(14),
		delete = hsl("#AF5FAF").desaturate(14).darken(14),
	},
}

return c
