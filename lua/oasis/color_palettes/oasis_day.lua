-- lua/oasis/color_palettes/oasis_day.lua

local p = require("oasis.palette")
local theme = p.theme.day

-- General Reusable Colors
local ui = {
	-- Backgrounds
	bg = {
		core = theme.bg.core,
		shadow = theme.bg.shadow,
		mantle = theme.bg.mantle,
		surface = theme.bg.surface,
	},
	-- Foregrounds
	fg = {
		core = theme.fg.core,
		strong = theme.fg.strong,
		muted = theme.fg.muted,
		dim = theme.fg.dim,
		comment = theme.fg.comment,
	},
	-- General colors
	theme = {
		primary = "#9B3030",
		light_primary = "#762424",
		secondary = "#11426e",
		accent = "#11426e",
	},
}

-- Colorscheme
local c = {
	bg = ui.bg,
	fg = ui.fg,
	theme = ui.theme,
	terminal = p.light_terminal,
	light_mode = true,

	-- Syntax
	syntax = {
		-- Cold: (Data)
		parameter = "#5300B5",
		identifier = "#39414A",
		delimiter = ui.theme.primary,
		type = "#234641",
		builtinVar = "#003F81",
		string = "#134A2D",
		regex = "#1A4A0C",
		builtinConst = "#1E4742",
		constant = "#6B2F04",

		-- Warm: (Control / Flow)
		func = "#643405",
		builtinFunc = "#782209",
		statement = "#474109",
		exception = "#821111",
		keyword = "#44411E",
		special = "#663300",
		operator = "#870000",
		punctuation = "#811212",
		preproc = "#074754",

		-- Neutral: (Connections / Info)
		bracket = "#454036",
		comment = ui.fg.comment,
	},

	-- Diff
	diff = {
		add = "#2F7D32",
		change = "#434300",
		delete = "#752424",
	},

	-- UI
	ui = {
		match = "#663300",
		visual = { bg = ui.bg.surface, fg = "none" },
		search = { bg = "#FFD87C", fg = "#462E23" },
		curSearch = { bg = p.sunshine[600], fg = "#2C1810" },
		dir = "#0F455B",

		title = ui.theme.primary,
		border = ui.theme.primary,
		cursorLine = ui.bg.mantle,
		nontext = ui.fg.dim,
		float = {
			title = ui.theme.light_primary,
			fg = ui.fg.core,
			bg = ui.bg.surface,
			border = { fg = ui.theme.primary, bg = ui.bg.mantle },
		},
		diag = {
			error = { fg = "#752424", bg = ui.bg.core },
			warn = { fg = "#434300", bg = ui.bg.core },
			info = { fg = "#0F455B", bg = ui.bg.core },
			hint = { fg = "#1d4741", bg = ui.bg.core },
			ok = { fg = "#2F7D32", bg = "none" },
		},
	},
}
return c
