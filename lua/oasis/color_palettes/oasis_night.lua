-- lua/oasis/color_palettes/oasis_night.lua

local p = require("oasis.palette")
local config = require("oasis.config")
local opts = config.get()
local theme = p.theme.night

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
		accent = p.lagoon[500],
		palette = {
			primary = p.red,
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
		identifier = p.teal[400],
		delimiter = ui.theme.primary,
		type = p.teal[700],
		builtinVar = p.lagoon[500], -- (this, document, window, etc)
		string = p.cactus[500],
		regex = p.palm[500],
		builtinConst = p.slate[500], -- (constant: number, float, boolean, or const not string/character)
		constant = p.sunset[500],

		-- Warm: (Control / Flow)
		func = p.sunset[300],
		builtinFunc = p.sundown[400], -- (eg. parseInt, Array, Object etc)
		statement = opts.themed_syntax and ui.theme.palette.primary[400] or p.khaki[500], -- (general statement (i.e. var, const))
		exception = opts.themed_syntax and p.khaki[500] or p.red[400], -- (try/catch, return)
		keyword = opts.themed_syntax and p.rose[700] or p.khaki[700], -- (Conditionals, Loops)
		special = p.sunset[500], -- (Statement not covered above)
		operator = p.peach[300],
		punctuation = p.coral[500],
		preproc = p.sky[500], -- (imports)

		-- Neutral: (Connections / Info)
		bracket = p.grey[500],
		comment = ui.fg.comment,
	},

	-- Diff
	diff = {
		add = p.moss[500],
		change = p.dune[500],
		delete = p.red[900],
	},

	-- UI
	ui = {
		lineNumber = p.sunset[500],
		match = { bg = p.sunset[500], fg = ui.bg.core },
		visual = { bg = p.visual.indigo, fg = "none" },
		search = { bg = p.visual.orange, fg = ui.fg.core },
		curSearch = { bg = p.sunshine[500], fg = ui.bg.core },

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
