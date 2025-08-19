-- ../lua/color_palettes/oasis-mirage.lua
local lush = require("lush")
local hsl = lush.hsl

local c = {
	-- Backgrounds
	bg = {
		main = hsl("#18252A"),
		panel = hsl("#22343A"),
		surface = hsl("#2A3F46"),
	},
	-- Foregrounds
	fg = {
		main = hsl("#E2E6E5"),
		muted = hsl("#A8B3B3"),
	},
	-- UI
	ui = {
		accent = hsl("#4FD1C5").desaturate(6),
		border = hsl("#4FD1C5").desaturate(10).lighten(6),
		cursorLine = hsl("#24363B"),
		nontext = hsl("#6DCEEB").desaturate(70).darken(45),
		visual = hsl("#1A5A60").darken(10),
	},
	-- Syntax
	syntax = {
		comment = hsl("#6DCEEB").desaturate(34).darken(36),
		constant = hsl("#FFD99A").darken(14),
		func = hsl("#4FD1C5").lighten(12).saturate(10),
		special = hsl("#CD853F").darken(10),
		statement = hsl("#F0E68C").darken(8),
		string = hsl("#FFA0A0").darken(10),
		type = hsl("#7CC39B").darken(6),
	},
	-- Status
	status = {
		err_alt = hsl("#CD5C5C"),
		error = hsl("#FF5A5A").darken(10),
		info = hsl("#75A0FF").desaturate(12).darken(8),
		success = hsl("#60E6A8").darken(10),
		warning = hsl("#E8C24A").darken(8),
	},
	-- Diff
	diff = {
		add = hsl("#2FAE7B").darken(14),
		change = hsl("#5F87AF").darken(10),
		delete = hsl("#A05F9F").darken(12),
	},
}

return c
