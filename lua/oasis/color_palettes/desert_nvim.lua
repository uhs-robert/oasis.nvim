-- ../lua/color_palettes/oasis-legacy.lua
local lush = require("lush")
local hsl = lush.hsl

local c = {
	-- Backgrounds
	bg = {
		main = hsl("#333333"),
		panel = hsl("#4D4D4D"),
		surface = hsl("#666666"),
	},
	-- Foregrounds
	fg = {
		main = hsl("#FFFFFF"),
		muted = hsl("#7F7F8C"),
	},
	-- UI
	ui = {
		accent = hsl("#F0E68C"),
		border = hsl("#C2BFA5"),
		cursorLine = hsl("#666666"),
		dir = hsl("#6DCEEB"),
		nontext = hsl("#6DCEEB"),
		visual = hsl("#6B8E24"),
		visualFg = hsl("#F0E68C"),
	},
	-- Syntax
	syntax = {
		comment = hsl("#6DCEEB"),
		constant = hsl("#FFA0A0"),
		special = hsl("#FFDE9B"),
		statement = hsl("#F0E68C"),
		string = hsl("#FFA0A0"),
		type = hsl("#BDB76B"),
	},
	-- Status
	status = {
		err_alt = hsl("#CD5C5C"),
		error = hsl("#FF0000"),
		info = hsl("#75A0FF"),
		success = hsl("#89FB98"),
		warning = hsl("#EEEE00"),
	},
	-- Diff
	diff = {
		add = hsl("#5F875F"),
		change = hsl("#5F87AF"),
		delete = hsl("#AF5FAF"),
	},
}

return c
