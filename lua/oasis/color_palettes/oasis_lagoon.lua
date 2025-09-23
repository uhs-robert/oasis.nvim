-- lua/oasis/color_palettes/oasis_lagoon.lua

local lush = require("lush")
local hsl = lush.hsl
local p = require("oasis.palette")
local key = "lagoon"

-- General Reusable Colors
local ui = {
	-- Backgrounds
	bg = {
		core = hsl(p.theme.bg.core[key]),
		shadow = hsl(p.theme.bg.shadow[key]),
		mantle = hsl(p.theme.bg.mantle[key]),
		surface = hsl(p.theme.bg.surface[key]),
	},
	-- Foregrounds
	fg = {
		core = hsl(p.theme.fg.core[key]),
		muted = hsl(p.theme.fg.muted[key]),
		dim = hsl(p.theme.fg.dim[key]),
		comment = hsl(p.theme.fg.comment[key]),
	},
	-- General colors
	theme = {
		primary = hsl(p.blue.azure),
		light_primary = hsl(p.blue.skyblue),
		secondary = hsl(p.orange.sunset),
		accent = hsl(p.red.desertrose),
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
		parameter = hsl(p.indigo.darkcactusflower), -- (paramaters)
		identifier = hsl(p.yellow.navajowhite), -- (property identifiers)
		delimiter = ui.theme.primary, -- (delimiters)
		type = hsl(p.teal.darkagave), -- (type definitions)
		builtinVar = hsl(p.blue.skyBlueDress), -- (this, document, window, etc)
		string = hsl(p.green.cactus), -- (strings)
		regex = hsl(p.green.darkPalm), -- (reg ex string)
		builtinConst = hsl(p.teal.deepagave), -- (e.g. null, undefined, Infinity, etc)
		constant = hsl(p.orange.darkRedDawn), -- (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = hsl(p.orange.redDawn), -- [inverse of identifier]
		builtinFunc = hsl(p.orange.sunrise), -- (eg. parseInst, Array, Object etc)
		statement = hsl(p.yellow.khaki), -- (primary, general statement, conditonal, repeat, label )
		exception = hsl(p.red.indianred), -- (try/catch, return)
		keyword = hsl(p.yellow.darkkhaki), -- (general catch all)
		special = hsl(p.orange.lightsunset), -- (other catch all)
		operator = hsl(p.red.desertrose), -- (operators)
		punctuation = hsl(p.red.heatwave), -- (punctuation)
		preproc = hsl(p.blue.crystalBlue), -- (imports)

		-- Neutral: (Connections / Info)
		bracket = hsl(p.brown.dryriverbed), -- (bracket punctuation)
		comment = ui.fg.comment, -- (comments)
	},

	-- Diff
	diff = {
		add = hsl(p.green.springmoss),
		change = hsl(p.yellow.dune),
		delete = hsl(p.red.brick),
	},

	-- UI
	ui = {
		match = hsl(p.orange.sunset),
		visual = { bg = hsl(p.visual.teal), fg = "none" },
		search = { bg = hsl(p.teal.sky), fg = ui.fg.core },
		curSearch = { bg = hsl(p.orange.sun), fg = ui.bg.core },
		dir = hsl(p.blue.skyblue),

		title = ui.theme.primary,
		border = ui.theme.primary,
		cursorLine = ui.bg.shadow.lighten(6),
		nontext = ui.fg.dim,
		float = {
			title = ui.theme.primary,
			fg = ui.fg.core,
			bg = ui.bg.mantle,
			border = { fg = ui.theme.primary, bg = ui.bg.mantle },
		},
		diag = {
			error = { fg = hsl(p.diag.error.fg), bg = hsl(p.diag.error.bg) },
			warn = { fg = hsl(p.diag.warn.fg), bg = hsl(p.diag.warn.bg) },
			info = { fg = hsl(p.diag.info.fg), bg = hsl(p.diag.info.bg) },
			hint = { fg = hsl(p.diag.hint.fg), bg = hsl(p.diag.hint.bg) },
			ok = { fg = hsl(p.diag.ok.fg), bg = "none" },
		},
	},
}
return c
