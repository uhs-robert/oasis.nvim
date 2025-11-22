-- lua/oasis/color_palettes/oasis_dusk.lua

local p = require("oasis.palette")
local theme = p.theme.dusk

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
		builtinVar = "#003063", -- (this, document, window, etc)
		string = "#0e3822",
		regex = "#133809",
		builtinConst = "#163632", -- (constant: number, float, boolean, or const not string/character)
		constant = "#522403",

		-- Warm: (Control / Flow)
		func = "#4c2804",
		builtinFunc = "#5c1a07", -- (eg. parseInt, Array, Object etc)
		statement = "#363107", -- (general statement (i.e. var, const))
		exception = "#640d0d", -- (try/catch, return)
		keyword = "#292812", -- (Conditionals, Loops)
		special = "#4e2700", -- (Statement not covered above)
		operator = "#600000",
		punctuation = "#510B0B",
		preproc = "#053640", -- (imports)

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
