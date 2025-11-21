-- lua/oasis/color_palettes/oasis_dust.lua

local p = require("oasis.palette")
local key = "dust"

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
		primary = "#752424",
		light_primary = "#4E1818",
		secondary = "#11426e",
		accent = "#11426e",
	},
}

-- string       : #53D390 → #0c301d ( 1.08:1 →  7.05:1) ✗
-- type         : #81C0B6 → #172e2a ( 1.01:1 →  7.05:1) ✗
-- warn         : #EEEE00 → #2b2b00 ( 1.64:1 →  7.05:1) ✗

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
		parameter = "#39007B",
		identifier = "#252a30",
		delimiter = ui.theme.primary,
		type = "#172E2A",
		builtinVar = "#002a55",
		string = "#0c301d",
		regex = "#113008",
		builtinConst = "#132e2b",
		constant = "#461f03",

		-- Warm: (Control / Flow)
		func = "#412203",
		builtinFunc = "#4f1706",
		statement = "#2e2a06",
		exception = "#570b0b",
		keyword = "#2c2b14",
		special = "#432100",
		operator = "#5c0000",
		punctuation = "#560c0c",
		preproc = "#042e37",

		-- Neutral: (Connections / Info)
		bracket = "#2d2923",
		comment = ui.fg.comment,
	},

	-- Diff
	diff = {
		add = "#25491C",
		change = "#2b2b00",
		delete = "#4d1818",
	},

	-- UI
	ui = {
		match = "#432100",
		visual = { bg = ui.bg.surface, fg = "none" },
		search = { bg = "#FFD87C", fg = "#462E23" },
		curSearch = { bg = p.sunshine[600], fg = "#2C1810" },
		dir = "#0a2d3c",

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
			error = { fg = "#4d1818", bg = ui.bg.core },
			warn = { fg = "#2b2b00", bg = ui.bg.core },
			info = { fg = "#0a2d3c", bg = ui.bg.core },
			hint = { fg = "#132e2a", bg = ui.bg.core },
			ok = { fg = "#25491C", bg = "none" },
		},
	},
}
return c
