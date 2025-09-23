-- lua/oasis/color_palettes/oasis_starlight.lua

local lush = require("lush")
local hsl = lush.hsl
local p = require("oasis.palette")
local key = "starlight"

-- General Reusable Colors
local ui = {
	-- Backgrounds
	bg = {
		core = hsl(p.theme.bg.core[key]),
		mantle = hsl(p.theme.bg.mantle[key]),
		crust = hsl(p.theme.bg.crust[key]),
		surface = hsl(p.theme.bg.surface[key]),
	},
	-- Foregrounds
	fg = {
		core = hsl(p.theme.fg.core[key]),
		muted = hsl(p.theme.fg.muted[key]),
		dim = hsl(p.theme.fg.dim[key]),
		comment = hsl(p.theme.fg.comment[key]),
	},
	-- -- Backgrounds
	-- bg = {
	-- 	core = hsl(p.black.abyssCore),
	-- 	mantle = hsl(p.black.charcoal),
	-- 	crust = hsl(p.black.abyssMantle),
	-- 	surface = hsl(p.black.abyssCrust),
	-- },
	-- -- Foregrounds
	-- fg = {
	-- 	core = hsl(p.white.moondust),
	-- 	muted = hsl(p.grey.duskbasalt),
	-- 	dim = hsl(p.grey.duskbasalt),
	-- },
	-- General colors
	theme = {
		primary = hsl(p.blue.horizon),
		light_primary = hsl(p.blue.skyblue),
		secondary = hsl(p.yellow.khaki),
		accent = hsl(p.orange.redDawn),
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
		parameter = hsl(p.indigo.moonlitflower), -- (paramaters) [UNIQUE]
		identifier = hsl(p.yellow.navajowhite), -- (property identifiers)
		delimiter = ui.theme.primary, -- (delimiters)
		type = hsl(p.teal.agave), -- (type definitions)
		builtinVar = hsl(p.blue.skyBlueDress), -- (this, document, window, etc)
		string = hsl(p.green.springcactus), -- (strings)
		regex = hsl(p.green.palm), -- (reg ex string)
		builtinConst = hsl(p.green.lightaloe), -- (e.g. null, undefined, Infinity, etc)
		constant = hsl(p.orange.darkRedDawn), -- (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = hsl(p.orange.lightdawn), -- [inverse of identifier]
		builtinFunc = hsl(p.orange.deepsun), -- (eg. parseInst, Array, Object etc)
		statement = hsl(p.yellow.khaki), -- (primary p, general statement, conditonal, repeat, label )
		exception = hsl(p.red.indianred), -- (try/catch, return)
		keyword = hsl(p.yellow.moonlitsand), -- (general catch all)
		special = hsl(p.orange.lightsunset), -- (other catch all)
		operator = hsl(p.red.deepdesertrose), -- (operators)
		punctuation = hsl(p.red.deepheatwave), -- (punctuation)
		preproc = hsl(p.blue.crystalBlue), -- (imports)

		-- Neutral: (Connections / Info)
		bracket = hsl(p.grey.palemoon), -- (bracket punctuation)
		comment = ui.fg.comment, -- (comments)
	},

	-- Diff
	diff = {
		add = hsl(p.green.moss),
		change = hsl(p.yellow.dune),
		delete = hsl(p.red.brick),
	},

	-- UI
	ui = {
		match = hsl(p.orange.sunset),
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
