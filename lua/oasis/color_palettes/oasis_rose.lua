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
		primary = p.red.desertrose,
		secondary = p.yellow.sunYellow,
		accent = p.blue.skyblue,
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
		parameter = p.indigo.lightcactusflower, -- (paramaters) [UNIQUE]
		identifier = p.yellow.navajowhite, -- (property identifiers)
		delimiter = ui.theme.primary, -- (delimiters)
		type = p.teal.darkagave, -- (type definitions)
		builtinVar = p.blue.horizon, -- (this, document, window, etc)
		string = p.green.springcactus, -- (strings)
		regex = p.green.palm, -- (reg ex string)
		builtinConst = p.green.lightaloe, -- (e.g. null, undefined, Infinity, etc)
		constant = p.orange.darkRedDawn, -- (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = p.orange.redDawn, -- [inverse of identifier]
		builtinFunc = p.orange.deepsun, -- (eg. parseInst, Array, Object etc)
		statement = p.yellow.khaki, -- (primary p, general statement, conditonal, repeat, label )
		exception = p.red.brightestvibrantred, -- (try/catch, return)
		keyword = p.yellow.darkkhaki, -- (general catch all)
		special = p.orange.lightsunset, -- (other catch all)
		operator = p.red.brightestdesertrose, -- (operators)
		punctuation = p.red.brightestheatwave, -- (punctuation)
		preproc = p.blue.crystalBlue, -- (imports)

		-- Neutral: (Connections / Info)
		bracket = p.brown.lightriverbed, -- (bracket punctuation)
		comment = ui.fg.comment, -- (comments)
	},

	-- Diff
	diff = {
		add = p.green.springmoss,
		change = p.yellow.dune,
		delete = p.red.brick,
	},

	-- UI
	ui = {
		match = p.orange.deepsun, -- gold
		visual = { bg = p.visual.orange, fg = "none" },
		search = { bg = p.visual.orange, fg = ui.fg.core },
		curSearch = { bg = p.orange.sun, fg = ui.bg.core },
		dir = p.blue.skyblue,

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
