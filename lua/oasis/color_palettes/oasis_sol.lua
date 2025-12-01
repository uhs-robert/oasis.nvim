-- lua/oasis/color_palettes/oasis_sol.lua

local p = require("oasis.palette")
local config = require("oasis.config")
local opts = config.get()
local theme = p.theme.sol

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
		primary = p.red[600],
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
		parameter = p.lavender[400],
		identifier = p.teal[500],
		delimiter = ui.theme.primary,
		type = p.teal[700],
		builtinVar = p.lagoon[500], -- (this, document, window, etc)
		string = p.cactus[700],
		regex = p.palm[500],
		builtinConst = p.slate[500], -- (e.g. null, undefined, Infinity, etc)
		constant = p.sunset[500], -- (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = p.sunset[300],
		builtinFunc = p.sundown[400], -- (eg. parseInst, Array, Object etc)
		statement = opts.themed_syntax and ui.theme.palette.primary[200] or p.khaki[500], -- (general statement (i.e. var, const))
		exception = opts.themed_syntax and p.khaki[500] or p.red[300], -- (try/catch, return)
		keyword = opts.themed_syntax and p.rose[600] or p.khaki[700], -- (Conditionals, Loops)
		special = p.sunset[400], -- (Statement not covered above)
		operator = opts.themed_syntax and p.peach[300] or p.rose[400],
		punctuation = opts.themed_syntax and p.peach[500] or p.coral[400],
		preproc = p.sky[500], -- (imports)

		-- Neutral: (Connections / Info)
		bracket = p.slate[500], -- (bracket punctuation)
		comment = ui.fg.comment, -- (comments)
	},

	-- Diff
	diff = {
		add = p.visual.green,
		change = theme.bg.surface,
		delete = p.visual.red,
	},

	-- UI
	ui = {
		lineNumber = p.sunshine[600],
		match = { bg = p.sunshine[600], fg = ui.bg.core },
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
