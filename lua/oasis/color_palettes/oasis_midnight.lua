-- lua/oasis/color_palettes/oasis_midnight.lua

local p = require("oasis.palette")
local key = "midnight"

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
		primary = p.red[500],
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
		builtinVar = p.sky[600],
		string = p.cactus[500],
		regex = p.palm[500],
		builtinConst = p.agave[700],
		constant = p.sunrise[700],

		-- Warm: (Control / Flow)
		func = p.sunrise[500],
		builtinFunc = p.sunshine[700],
		statement = p.khaki[500],
		exception = p.red[400],
		keyword = p.khaki[700],
		special = p.sunset[500],
		operator = p.rose[500],
		punctuation = p.coral[400],
		preproc = p.lagoon[600],

		-- Neutral: (Connections / Info)
		bracket = p.brown[500],
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
