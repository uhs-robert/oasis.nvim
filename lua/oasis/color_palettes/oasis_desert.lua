-- lua/oasis/color_palettes/oasis_desert.lua

local p = require("oasis.palette")
local config = require("oasis.config")
local opts = config.get()
local theme = p.theme.desert

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
		light_primary = p.rose[300],
		secondary = p.khaki[500],
		accent = p.sky[500],
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
		parameter = p.lavender[300],
		identifier = p.teal[300],
		delimiter = ui.theme.palette.primary[800],
		type = p.teal[600],
		builtinVar = p.lagoon[400], -- (this, document, window, etc)
		string = p.cactus[400],
		regex = p.palm[400],
		builtinConst = p.slate[600], -- (e.g. null, undefined, Infinity, etc)
		constant = p.sunset[400], -- (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = p.sunset[200],
		builtinFunc = p.sundown[400], -- (eg. parseInst, Array, Object etc)
		statement = opts.themed_syntax and ui.theme.palette.primary[50] or p.khaki[500], -- (general statement (i.e. var, const))
		exception = opts.themed_syntax and p.khaki[500] or p.red[50], -- (try/catch, return)
		keyword = opts.themed_syntax and ui.theme.palette.primary[300] or p.khaki[600], -- (Conditionals, Loops)
		special = p.sunset[400], -- (Statement not covered above)
		operator = p.rose[300],
		punctuation = p.coral[200],
		preproc = p.sky[500], -- (imports)

		-- Neutral: (Connections / Info)
		bracket = p.slate[600], -- (bracket punctuation)
		comment = (opts.useLegacyComments or opts.use_legacy_comments) and "#87CEEB" or ui.fg.comment,
	},

	-- Diff
	diff = {
		add = p.moss[400],
		change = p.dune[500],
		delete = p.red[900],
	},

	-- UI
	ui = {
		lineNumber = p.sunset[400],
		match = { bg = p.sunset[400], fg = ui.bg.core },
		visual = { bg = p.visual.blue, fg = "none" },
		search = { bg = p.visual.orange, fg = ui.fg.core },
		curSearch = { bg = p.sunset[400], fg = ui.bg.core },
		dir = p.sky[500],

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
			error = { fg = p.rose[400], bg = p.diag.error.bg },
			warn = { fg = p.diag.warn.fg, bg = p.diag.warn.bg },
			info = { fg = p.diag.info.fg_light, bg = p.diag.info.bg },
			hint = { fg = p.diag.hint.fg_light, bg = p.diag.hint.bg },
			ok = { fg = p.diag.ok.fg, bg = "none" },
		},
	},
}
return c
