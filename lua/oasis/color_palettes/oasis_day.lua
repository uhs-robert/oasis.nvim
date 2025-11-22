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
		builtinVar = "#003F81", -- (this, document, window, etc)
		string = "#134A2D",
		regex = "#1A4A0C",
		builtinConst = "#1E4742", -- (constant: number, float, boolean, or const not string/character)
		constant = "#6B2F04",

		-- Warm: (Control / Flow)
		func = "#643405",
		builtinFunc = "#782209", -- (eg. parseInt, Array, Object etc)
		statement = "#474109", -- (general statement (i.e. var, const))
		exception = "#821111", -- (try/catch, return)
		keyword = "#44411E", -- (Conditionals, Loops)
		special = "#663300", -- (Statement not covered above)
		operator = "#7F0000",
		punctuation = "#701010",
		preproc = "#074754", -- (imports)

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
