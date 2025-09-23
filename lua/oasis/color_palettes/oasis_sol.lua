-- lua/oasis/color_palettes/oasis_sol.lua

local lush = require("lush")
local hsl = lush.hsl
local p = require("oasis.palette")

-- General Reusable Colors
local ui = {
	-- Backgrounds
	bg = {
		core = hsl(p.black.solCore),
		mantle = hsl(p.black.solMantle),
		crust = hsl(p.black.solCrust),
		surface = hsl(p.black.solSurface),
	},
	-- Foregrounds
	fg = {
		core = hsl(p.white.dunesand),
		muted = hsl(p.brown.charredClay),
		dim = hsl(p.brown.charredClay),
	},
	-- General colors
	theme = {
		primary = hsl(p.red.indianred),
		secondary = hsl(p.orange.sunset),
		accent = hsl(p.blue.horizon),
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
		parameter = hsl(p.indigo.lightcactusflower), -- (paramaters) [UNIQUE]
		identifier = hsl(p.yellow.navajowhite), -- (property identifiers)
		delimiter = hsl(p.red.indianred), -- (delimiters)
		type = hsl(p.teal.darkagave), -- (type definitions)
		builtinVar = hsl(p.blue.lightazure), -- (this, document, window, etc)
		string = hsl(p.green.springcactus), -- (strings)
		regex = hsl(p.green.palm), -- (reg ex string)
		builtinConst = hsl(p.green.lightaloe), -- (e.g. null, undefined, Infinity, etc)
		constant = hsl(p.orange.darkRedDawn), -- (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = hsl(p.orange.redDawn), -- [inverse of identifier]
		builtinFunc = hsl(p.orange.deepsun), -- (eg. parseInst, Array, Object etc)
		statement = hsl(p.yellow.khaki), -- (primary p, general statement, conditonal, repeat, label )
		exception = hsl(p.red.indianred), -- (try/catch, return)
		keyword = hsl(p.yellow.darkkhaki), -- (general catch all)
		special = hsl(p.orange.lightsunset), -- (other catch all)
		operator = hsl(p.red.desertrose), -- (operators)
		punctuation = hsl(p.red.heatwave), -- (punctuation)
		preproc = hsl(p.blue.crystalBlue), -- (imports)

		-- Neutral: (Connections / Info)
		bracket = hsl(p.brown.dryriverbed), -- (bracket punctuation)
		comment = hsl(p.brown.driftwood), -- (comments)
	},

	-- Diff
	diff = {
		add = hsl(p.green.springmoss),
		change = hsl(p.yellow.dune),
		delete = hsl(p.red.brick),
	},

	-- UI
	ui = {
		match = hsl(p.orange.deepsun), -- gold
		visual = { bg = hsl(p.visual.orange), fg = "none" },
		search = { bg = hsl(p.teal.sky), fg = ui.fg.core },
		curSearch = { bg = hsl(p.orange.sun), fg = ui.bg.core },
		dir = hsl(p.blue.skyblue),

		title = ui.theme.primary,
		border = ui.theme.primary,
		cursorLine = ui.bg.crust.lighten(6),
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
