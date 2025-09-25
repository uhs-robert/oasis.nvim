-- lua/oasis/color_palettes/oasis_starlight.lua

local p = require("oasis.palette")
local key = "starlight"

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
		muted = p.theme.fg.muted[key],
		dim = p.theme.fg.dim[key],
		comment = p.theme.fg.comment[key],
	},
	-- General colors
	theme = {
		primary = p.blue.horizon,
		light_primary = p.blue.skyblue,
		secondary = p.yellow.khaki,
		accent = p.orange.redDawn,
	},
}

-- Colorscheme
local c = {
	bg = ui.bg,
	fg = ui.fg,
	theme = ui.theme,

	-- Syntax
	syntax = {
		-- Cold: (Data)
		parameter = p.indigo.moonlitflower, -- (paramaters) [UNIQUE]
		identifier = p.yellow.navajowhite, -- (property identifiers)
		delimiter = ui.theme.primary, -- (delimiters)
		type = p.teal.agave, -- (type definitions)
		builtinVar = p.blue.skyBlueDress, -- (this, document, window, etc)
		string = p.green.springcactus, -- (strings)
		regex = p.green.palm, -- (reg ex string)
		builtinConst = p.green.lightaloe, -- (e.g. null, undefined, Infinity, etc)
		constant = p.orange.darkRedDawn, -- (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = p.orange.lightdawn, -- [inverse of identifier]
		builtinFunc = p.orange.deepsun, -- (eg. parseInst, Array, Object etc)
		statement = p.yellow.khaki, -- (primary p, general statement, conditonal, repeat, label )
		exception = p.red.indianred, -- (try/catch, return)
		keyword = p.yellow.moonlitsand, -- (general catch all)
		special = p.orange.lightsunset, -- (other catch all)
		operator = p.red.deepdesertrose, -- (operators)
		punctuation = p.red.deepheatwave, -- (punctuation)
		preproc = p.blue.crystalBlue, -- (imports)

		-- Neutral: (Connections / Info)
		bracket = p.grey.palemoon, -- (bracket punctuation)
		comment = ui.fg.comment, -- (comments)
	},

	-- Diff
	diff = {
		add = p.green.moss,
		change = p.yellow.dune,
		delete = p.red.brick,
	},

	-- UI
	ui = {
		match = p.orange.sunset,
		visual = { bg = p.visual.yellow, fg = "none" },
		search = { bg = p.teal.sky, fg = ui.fg.core },
		curSearch = { bg = p.orange.sun, fg = ui.bg.core },
		dir = p.blue.skyblue,

		title = ui.theme.primary,
		border = ui.theme.primary,
		cursorLine = p.theme.bg.mantle.lagoon,
		nontext = ui.fg.dim,
		float = {
			title = ui.theme.primary,
			fg = ui.fg.core,
			bg = ui.bg.surface,
			border = { fg = ui.theme.primary, bg = ui.bg.mantle },
		},
		diag = {
			error = { fg = p.diag.error.fg, bg = p.diag.error.bg },
			warn = { fg = p.diag.warn.fg, bg = p.diag.warn.bg },
			info = { fg = p.diag.info.fg, bg = p.diag.info.bg },
			hint = { fg = p.diag.hint.fg, bg = p.diag.hint.bg },
			ok = { fg = p.diag.ok.fg, bg = "none" },
		},
	},
}
return c
