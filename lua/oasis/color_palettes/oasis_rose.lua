-- lua/oasis/color_palettes/oasis_rose.lua

local p = require("oasis.palette")
local key = "rose"

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
		primary = p.rose[500],
		secondary = p.gold[400],
		accent = p.sky[500],
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
		parameter = p.lavender[400], -- (paramaters) [UNIQUE]
		identifier = p.sand[400], -- (property identifiers)
		delimiter = ui.theme.primary, -- (delimiters)
		type = p.agave[600], -- (type definitions)
		builtinVar = p.azure[500], -- (this, document, window, etc)
		string = p.cactus[700], -- (strings)
		regex = p.palm[500], -- (reg ex string)
		builtinConst = p.aloe[400], -- (e.g. null, undefined, Infinity, etc)
		constant = p.sunrise[700], -- (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = p.sunrise[500], -- [inverse of identifier]
		builtinFunc = p.sunshine[600], -- (eg. parseInst, Array, Object etc)
		statement = p.khaki[500], -- (primary p, general statement, conditonal, repeat, label )
		exception = p.red[200], -- (try/catch, return)
		keyword = p.khaki[700], -- (general catch all)
		special = p.sunset[400], -- (other catch all)
		operator = p.rose[300], -- (operators)
		punctuation = p.coral[300], -- (punctuation)
		preproc = p.lagoon[600], -- (imports)

		-- Neutral: (Connections / Info)
		bracket = p.brown[600], -- (bracket punctuation)
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
		match = p.sunshine[600], -- gold
		visual = { bg = p.visual.orange, fg = "none" },
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
