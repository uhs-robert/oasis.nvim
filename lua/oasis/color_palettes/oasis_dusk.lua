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
		parameter = "#3B1483",
		identifier = "#1F343C",
		delimiter = ui.theme.primary,
		type = "#1f343c",
		builtinVar = "#0b2978",
		string = "#153817",
		regex = "#263603",
		builtinConst = "#053831",
		constant = "#4f2600",

		-- Warm: (Control / Flow)
		func = "#502300",
		builtinFunc = "#542300",
		statement = "#402e00",
		exception = "#621212",
		keyword = "#3c2d00",
		special = "#51220b",
		operator = "#512228",
		punctuation = "#353125",
		preproc = "#0c3050",

		-- Neutral: (Connections / Info)
		bracket = "#322f27",
		comment = ui.fg.comment,
	},

	-- Diff
	diff = {
		add = "#2B5621",
		change = "#60490A",
		delete = "#621212",
	},

	-- UI
	ui = {
		match = "#44290b",
		visual = { bg = ui.bg.surface, fg = "none" },
		search = { bg = "#FFD87C", fg = "#462E23" },
		curSearch = { bg = p.orange.deepsun, fg = "#2C1810" },
		dir = "#15353f",

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
			error = { fg = "#621212", bg = ui.bg.core },
			warn = { fg = "#3f2b14", bg = ui.bg.core },
			info = { fg = "#15353f", bg = ui.bg.core },
			hint = { fg = "#183631", bg = ui.bg.core },
			ok = { fg = "#2B5621", bg = "none" },
		},
	},
}
return c
