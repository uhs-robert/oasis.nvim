-- lua/oasis/color_palettes/oasis_starlight.lua

local p = require("oasis.palette")
local theme = p.theme.starlight

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
		primary = p.azure[500],
		light_primary = p.sky[500],
		secondary = p.khaki[500],
		accent = p.sunrise[500],
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
		parameter = p.lavender[500], -- (paramaters) [UNIQUE]
		identifier = p.sand[400], -- (property identifiers)
		delimiter = ui.theme.primary, -- (delimiters)
		type = p.agave[500], -- (type definitions)
		builtinVar = p.sky[600], -- (this, document, window, etc)
		string = p.cactus[700], -- (strings)
		regex = p.palm[500], -- (reg ex string)
		builtinConst = p.aloe[400], -- (e.g. null, undefined, Infinity, etc)
		constant = p.sunrise[700], -- (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = p.sunshine[200], -- [inverse of identifier]
		builtinFunc = p.sunshine[600], -- (eg. parseInst, Array, Object etc)
		statement = p.khaki[500], -- (primary p, general statement, conditonal, repeat, label )
		exception = p.red[500], -- (try/catch, return)
		keyword = p.gold[300], -- (general catch all)
		special = p.sunset[400], -- (other catch all)
		operator = p.rose[500], -- (operators)
		punctuation = p.rose[700], -- (punctuation)
		preproc = p.lagoon[600], -- (imports)

		-- Neutral: (Connections / Info)
		bracket = p.grey[500], -- (bracket punctuation)
		comment = ui.fg.comment, -- (comments)
	},

	-- Diff
	diff = {
		add = p.moss[500],
		change = p.dune[500],
		delete = p.red[900],
	},

	-- UI
	ui = {
		match = p.sunset[500],
		visual = { bg = p.visual.yellow, fg = "none" },
		search = { bg = p.visual.orange, fg = ui.fg.core },
		curSearch = { bg = p.sunshine[500], fg = ui.bg.core },
		dir = p.sky[500],

		title = ui.theme.primary,
		border = ui.theme.primary,
		cursorLine = p.theme.lagoon.bg.mantle, -- NOTE: Uses another theme's mantle
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
