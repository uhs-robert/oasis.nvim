-- lua/oasis/color_palettes/oasis_day.lua

local p = require("oasis.palette")
local key = "day"

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
		primary = "#683121",
		light_primary = "#692d36",
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
		parameter = "#4d1aa8",
		identifier = "#2d434e",
		delimiter = ui.theme.primary,
		type = "#064659",
		builtinVar = "#0f379b",
		string = "#1b4a1d",
		regex = "#35460d",
		builtinConst = "#0b4940",
		constant = "#683200",

		-- Warm: (Control / Flow)
		func = "#6c2f00",
		builtinFunc = "#6e2d00",
		statement = "#543d00",
		exception = "#7e1818",
		keyword = "#513e00",
		special = "#6e2d0f",
		operator = "#6a2d35",
		punctuation = "#464031",
		preproc = "#11426e",

		-- Neutral: (Connections / Info)
		bracket = "#454037",
		comment = ui.fg.comment,
	},

	-- Diff
	diff = {
		add = "#2F7D32",
		change = "#563b1c",
		delete = "#7e1818",
	},

	-- UI
	ui = {
		match = "#5d380e",
		visual = { bg = ui.bg.surface, fg = "none" },
		search = { bg = "#FFD87C", fg = "#462E23" },
		curSearch = { bg = p.orange.deepsun, fg = "#2C1810" },
		dir = "#1c4552",

		title = ui.theme.primary,
		border = ui.theme.primary,
		cursorLine = ui.bg.mantle,
		nontext = ui.fg.dim,
		float = {
			title = ui.theme.primary,
			fg = ui.fg.core,
			bg = ui.bg.surface,
			border = { fg = ui.theme.primary, bg = ui.bg.mantle },
		},
		diag = {
			error = { fg = "#7e1818", bg = ui.bg.core },
			warn = { fg = "#563b1c", bg = ui.bg.core },
			info = { fg = "#1c4552", bg = ui.bg.core },
			hint = { fg = "#204741", bg = ui.bg.core },
			ok = { fg = "#2F7D32", bg = "none" },
		},
	},
}
return c
