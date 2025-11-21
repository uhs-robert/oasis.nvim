-- lua/oasis/color_palettes/oasis_dune.lua

local p = require("oasis.palette")
local theme = p.theme.dune

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
		primary = p.khaki[500],
		secondary = p.aloe[500],
		accent = p.cactus[500],
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
		parameter = p.lavender[400],
		identifier = p.sand[400],
		delimiter = ui.theme.primary,
		type = p.agave[500],
		builtinVar = p.azure[500], -- (this, document, window, etc)
		string = p.cactus[500],
		regex = p.palm[500],
		builtinConst = p.agave[600], -- (e.g. null, undefined, Infinity, etc)
		constant = p.sunrise[600], -- (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = p.sunrise[500],
		builtinFunc = p.sunshine[500], -- (eg. parseInst, Array, Object etc)
		statement = p.khaki[500], -- (general statement (i.e. var, const))
		exception = p.red[100], -- (try/catch, return)
		keyword = p.khaki[700], -- (Conditionals, Loops)
		special = p.sunset[500], -- (Statement not covered above)
		operator = p.rose[300],
		punctuation = p.coral[300],
		preproc = p.lagoon[600], -- (imports)

		-- Neutral: (Connections / Info)
		bracket = p.brown[500], -- (bracket punctuation)
		comment = ui.fg.comment, -- (comments)
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
		visual = { bg = p.visual.blue, fg = "none" },
		search = { bg = p.visual.orange, fg = ui.fg.core },
		curSearch = { bg = p.sunshine[500], fg = ui.bg.core },
		dir = p.sky[500],

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
			error = { fg = p.diag.error.fg_light, bg = p.diag.error.bg },
			warn = { fg = p.diag.warn.fg, bg = p.diag.warn.bg },
			info = { fg = p.diag.info.fg_light, bg = p.diag.info.bg },
			hint = { fg = p.diag.hint.fg_light, bg = p.diag.hint.bg },
			ok = { fg = p.diag.ok.fg, bg = "none" },
		},
	},
}
return c
