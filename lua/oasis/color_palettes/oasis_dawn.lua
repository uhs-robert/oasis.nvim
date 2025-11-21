-- lua/oasis/color_palettes/oasis_dawn.lua

local p = require("oasis.palette")
local key = "dawn"

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
		primary = "#733725",
		light_primary = "#753826",
		secondary = "#134c7d",
		accent = "#134c7d",
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
		parameter = "#571CBE",
		identifier = "#334D5A",
		delimiter = ui.theme.primary,
		type = "#074E64",
		builtinVar = "#113EB0",
		string = "#1E5120",
		regex = "#3A4D0E",
		builtinConst = "#0B5046",
		constant = "#753800",

		-- Warm: (Control / Flow)
		func = "#7A3500",
		builtinFunc = "#7A3200",
		statement = "#5B4200",
		exception = "#990000",
		keyword = "#584715",
		special = "#793110",
		operator = "#79333C",
		punctuation = "#4E4736",
		preproc = "#124A7C",

		-- Neutral: (Connections / Info)
		bracket = "#4F493E",
		comment = ui.fg.comment,
	},

	-- Diff
	diff = {
		add = "#2F7D32",
		change = "#60421E",
		delete = "#990000",
	},

	-- UI
	ui = {
		match = "#6A400F",
		visual = { bg = ui.bg.surface, fg = "none" },
		search = { bg = "#FFD87C", fg = "#462E23" },
		curSearch = { bg = p.orange.deepsun, fg = "#2C1810" },
		dir = "#175061",

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
			error = { fg = "#990000", bg = ui.bg.core },
			warn = { fg = "#60421E", bg = ui.bg.core },
			info = { fg = "#175061", bg = ui.bg.core },
			hint = { fg = "#1b5249", bg = ui.bg.core },
			ok = { fg = "#2F7D32", bg = "none" },
		},
	},
}
return c
