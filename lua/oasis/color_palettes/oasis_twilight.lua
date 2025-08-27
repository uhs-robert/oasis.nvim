-- lua/oasis/color_palettes/oasis_twilight.lua
local lush = require("lush")
local hsl = lush.hsl
local p = require("oasis.palette")

-- General Reusable Colors
local ui = {
	-- Backgrounds
	bg = {
		core = hsl(p.black.twilightCore),
		mantle = hsl(p.black.twilightMantle),
		crust = hsl(p.black.twilightCrust),
		surface = hsl(p.black.twilightSurface),
	},
	-- Foregrounds
	fg = {
		core = hsl(p.white.moonpearl),
		muted = hsl(p.grey.dusklilac),
		dim = hsl(p.grey.duskash),
	},
	-- General colors
	theme = {
		primary = hsl(p.indigo.moonlitflower),
		secondary = hsl(p.yellow.moonlitsand),
		accent = hsl(p.green.springcactus),
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
		parameter = hsl(p.indigo.cactusflower), --
		identifier = hsl(p.blue.skyblue), -- (property identifiers)
		type = hsl(p.blue.horizon), -- (type definitions)
		builtinVar = hsl(p.blue.azure), -- (this, document, window, etc)
		string = hsl(p.green.springcactus), -- (strings)
		regex = hsl(p.green.oasis), -- (reg ex string)
		builtinConst = hsl(p.green.aloe), -- (e.g. null, undefined, Infinity, etc)
		constant = hsl(p.teal.agave), -- (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = hsl(p.orange.dawn), -- [inverse of identifier]
		builtinFunc = hsl(p.orange.sun), -- (eg. parseInst, Array, Object etc)
		statement = hsl(p.yellow.khaki2), -- (primary p, general statement, conditonal, repeat, label )
		exception = hsl(p.red.indianred), -- (try/catch, return)
		keyword = hsl(p.orange.amber), -- (general catch all)
		special = hsl(p.orange.sunset), -- (other catch all)
		operator = hsl(p.red.deepdesertrose), -- (operators)
		punctuation = hsl(p.red.deepheatwave), -- (punctuation)
		preproc = hsl(p.brown.darkpuebloclay), -- (imports)

		-- Neutral: (Connections / Info)
		bracket = hsl(p.brown.dryriverbed), -- (bracket punctuation)
		comment = hsl(p.grey.darktwilight), --  (comments)
	},

	-- Diff
	diff = {
		add = hsl(p.green.springmoss),
		change = hsl(p.yellow.dune),
		delete = hsl(p.red.brick),
	},

	-- UI
	ui = {
		match = hsl(p.yellow.gold), -- gold
		visual = { bg = hsl(p.visual.yellow), fg = "none" },
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
