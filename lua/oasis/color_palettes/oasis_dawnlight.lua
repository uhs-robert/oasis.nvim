-- lua/oasis/color_palettes/oasis_dawnlight.lua

local p = require("oasis.palette")
local theme = p.theme.dawnlight

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
		light_primary = "#7F2727",
		secondary = "#124977",
		accent = "#124977",
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
		parameter = "#5a00c3",
		identifier = "#3e4750",
		delimiter = ui.theme.primary,
		type = "#264c46",
		builtinVar = "#00458d", -- (this, document, window, etc)
		string = "#145031",
		regex = "#1c510d",
		builtinConst = "#204d48", -- (constant: number, float, boolean, or const not string/character)
		constant = "#743305",

		-- Warm: (Control / Flow)
		func = "#6d3905",
		builtinFunc = "#82250a", -- (eg. parseInt, Array, Object etc)
		statement = "#4d470a", -- (general statement (i.e. var, const))
		exception = "#8c1313", -- (try/catch, return)
		keyword = "#413E1D", -- (Conditionals, Loops)
		special = "#6f3700", -- (Statement not covered above)
		operator = "#890000",
		punctuation = "#7C1212",
		preproc = "#074d5b", -- (imports)

		-- Neutral: (Connections / Info)
		bracket = "#4b453b",
		comment = ui.fg.comment,
	},

	-- Diff
	diff = {
		add = "#2F7D32",
		change = "#494900",
		delete = "#7f2727",
	},

	-- UI
	ui = {
		match = "#6f3700",
		visual = { bg = ui.bg.surface, fg = "none" },
		search = { bg = "#FFD87C", fg = "#462E23" },
		curSearch = { bg = p.sunshine[600], fg = "#2C1810" },
		dir = "#114b63",

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
			error = { fg = "#7f2727", bg = ui.bg.core },
			warn = { fg = "#494900", bg = ui.bg.core },
			info = { fg = "#114b63", bg = ui.bg.core },
			hint = { fg = "#204d46", bg = ui.bg.core },
			ok = { fg = "#2F7D32", bg = "none" },
		},
	},
}
return c
