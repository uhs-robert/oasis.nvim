-- lua/oasis/color_palettes/oasis_abyss.lua

local p = require("oasis.palette")
local theme = p.theme.abyss

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
		primary = p.red[800],
		light_primary = p.rose[500],
		secondary = p.sunset[500],
		accent = p.agave[600],
	},
}

-- Colorscheme
local c = {
	bg = ui.bg,
	fg = ui.fg,
	theme = ui.theme,
	terminal = p.terminal,

	-- Syntax
	syntax = {
		-- Cold: (Data)
		parameter = p.lavender[600],
		identifier = p.sand[400],
		delimiter = ui.theme.primary,
		type = p.agave[600],
		builtinVar = p.sky[600], -- (this, document, window, etc)
		string = p.cactus[500],
		regex = p.palm[500],
		builtinConst = p.agave[800], -- (e.g. null, undefined, Infinity, etc)
		constant = p.sunrise[700], -- (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = p.sunrise[500],
		builtinFunc = p.sunshine[700], -- (eg. parseInst, Array, Object etc)
		statement = p.khaki[500], -- (general statement (i.e. var, const))
		exception = p.red[500], -- (try/catch, return)
		keyword = p.khaki[700], -- (Conditionals, Loops)
		special = p.sunset[500], -- (Statement not covered above)
		operator = p.rose[500],
		punctuation = p.coral[500],
		preproc = p.lagoon[600], -- (imports)

		-- Neutral: (Connections / Info)
		bracket = p.brown[700],
		comment = ui.fg.comment,
	},

	-- Diff
	diff = {
		add = p.moss[400],
		change = p.dune[500],
		delete = p.red[900],
	},

	-- UI
	ui = {
		match = p.sunset[500],
		visual = { bg = p.visual.orange, fg = "none" },
		search = { bg = p.visual.red, fg = ui.fg.core },
		curSearch = { bg = p.sunshine[500], fg = ui.bg.core },
		dir = p.sky[500],

		title = ui.theme.primary,
		border = ui.theme.primary,
		cursorLine = ui.bg.surface,
		nontext = ui.fg.dim,
		float = {
			title = ui.theme.primary,
			fg = ui.fg.core,
			bg = ui.bg.surface,
			border = { fg = ui.theme.primary, bg = ui.bg.mantle },
		},
		diag = {
			error = { fg = p.diag.error.fg_light, bg = p.diag.error.bg },
			warn = { fg = p.diag.warn.fg, bg = p.diag.warn.bg },
			info = { fg = p.diag.info.fg_light, bg = p.diag.info.bg },
			hint = { fg = p.diag.hint.fg_light, bg = p.diag.hint.bg },
			ok = { fg = p.diag.ok.fg, bg = "none" },
		},
	},
}
return c
