-- lua/oasis/color_palettes/oasis_dusk.lua

local p = require("oasis.palette")
local key = "dusk"

-- General Reusable Colors
local ui = {
	-- Backgrounds
	bg = {
		core = p.theme.bg.core[key],
		shadow = p.theme.bg.shadow[key],
		mantle = p.theme.bg.mantle[key],
		surface = p.theme.bg.surface[key],
	},
	-- Foregrounds
	fg = {
		core = p.theme.fg.core[key],
		strong = p.theme.fg.strong[key],
		muted = p.theme.fg.muted[key],
		dim = p.theme.fg.dim[key],
		comment = p.theme.fg.comment[key],
	},
	-- General colors
	theme = {
		primary = "#8A2A2A",
		light_primary = "#5A1B1B",
		secondary = "#11426E",
		accent = "#11426E",
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
		parameter = "#41008d",
		identifier = "#2b3138",
		delimiter = ui.theme.primary,
		type = "#1b3531",
		builtinVar = "#003063",
		string = "#0e3822",
		regex = "#133809",
		builtinConst = "#163632",
		constant = "#522403",

		-- Warm: (Control / Flow)
		func = "#4c2804",
		builtinFunc = "#5c1a07",
		statement = "#363107",
		exception = "#640d0d",
		keyword = "#343217",
		special = "#4e2700",
		operator = "#690000",
		punctuation = "#640e0e",
		preproc = "#053640",

		-- Neutral: (Connections / Info)
		bracket = "#353029",
		comment = ui.fg.comment,
	},

	-- Diff
	diff = {
		add = "#2B5621",
		change = "#333300",
		delete = "#621212",
	},

	-- UI
	ui = {
		match = "#4e2600",
		visual = { bg = ui.bg.surface, fg = "none" },
		search = { bg = "#FFD87C", fg = "#462E23" },
		curSearch = { bg = p.sunshine[600], fg = "#2C1810" },
		dir = "#0c3545",

		title = ui.theme.primary,
		border = ui.theme.primary,
		cursorLine = ui.bg.mantle,
		nontext = ui.fg.dim,
		float = {
			title = ui.theme.light_primary,
			fg = ui.fg.strong,
			bg = ui.bg.surface,
			border = { fg = ui.theme.primary, bg = ui.bg.mantle },
		},
		diag = {
			error = { fg = "#591b1b", bg = ui.bg.core },
			warn = { fg = "#333300", bg = ui.bg.core },
			info = { fg = "#0c3545", bg = ui.bg.core },
			hint = { fg = "#163631", bg = ui.bg.core },
			ok = { fg = "#2B5621", bg = "none" },
		},
	},
}
return c
