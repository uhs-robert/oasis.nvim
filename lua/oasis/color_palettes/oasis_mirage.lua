-- lua/oasis/color_palettes/oasis_mirage.lua

local p = require("oasis.palette")
local config = require("oasis.config")
local opts = config.get()
local theme = p.theme.mirage

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
		primary = p.teal[700],
		light_primary = p.teal[500],
		secondary = p.sunset[500],
		accent = p.lavender[500],
		palette = {
			primary = p.teal,
		},
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
		parameter = p.lavender[500],
		identifier = p.lagoon[300],
		delimiter = ui.theme.primary,
		type = p.lagoon[500],
		builtinVar = opts.themed_syntax and p.khaki[500] or p.gold[600], -- (this, document, window, etc)
		string = p.cactus[700],
		regex = p.palm[600],
		builtinConst = p.slate[600], -- (e.g. null, undefined, Infinity, etc)
		constant = p.sunset[500], -- (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = p.sunset[200],
		builtinFunc = p.sundown[400], -- (eg. parseInst, Array, Object etc) -- TODO: Sundown could be darker, check cactus too
		statement = opts.themed_syntax and ui.theme.palette.primary[500] or p.khaki[500], -- (general statement (i.e. var, const))
		exception = p.red[200], -- (try/catch, return)
		keyword = opts.themed_syntax and ui.theme.palette.primary[700] or p.khaki[700], -- (Conditionals, Loops)
		special = p.sunset[400], -- (Statement not covered above)
		operator = p.rose[400],
		punctuation = p.coral[300],
		preproc = p.sand[400], -- (imports)

		-- Neutral: (Connections / Info)
		bracket = p.slate[600], -- (bracket punctuation)
		comment = ui.theme.comment, -- (comments)
	},

	-- Diff
	diff = {
		add = p.moss[400],
		change = p.dune[500],
		delete = p.red[900],
	},

	-- UI
	ui = {
		lineNumber = p.sunset[500],
		match = { bg = p.sunset[500], fg = ui.bg.core },
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
