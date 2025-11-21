-- lua/oasis/color_palettes/oasis_desert.lua

local p = require("oasis.palette")
local key = "desert"

-- General Reusable Colors
local ui = {
	-- -- Backgrounds
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
		primary = p.red.vibrantred,
		light_primary = p.red.brightestdesertrose,
		secondary = p.yellow.khaki,
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
		parameter = p.indigo.lightestcactusflower, -- (paramaters) [UNIQUE]
		identifier = p.yellow.navajowhite, -- (property identifiers)
		delimiter = ui.theme.primary, -- (delimiters)
		type = p.teal.lightagave, -- (type definitions)
		builtinVar = p.blue.lighthorizon, -- (this, document, window, etc)
		string = p.green.lightcactus, -- (strings)
		regex = p.green.palm, -- (reg ex string)
		builtinConst = p.teal.agave, -- (e.g. null, undefined, Infinity, etc)
		constant = p.orange.lightestlightRedDawn, -- (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = p.orange.redDawn, -- [inverse of identifier]
		builtinFunc = p.orange.lightsun, -- (eg. parseInst, Array, Object etc)
		statement = p.yellow.khaki, -- (primary p, general statement, conditonal, repeat, label )
		exception = p.red.lightestvibrantred, -- (try/catch, return)
		keyword = p.yellow.khaki3, -- (general catch all)
		special = p.orange.lightdawn, -- (other catch all)
		operator = p.red.lightdesertrose, -- (operators)
		punctuation = p.red.lighterheatwave, -- (punctuation)
		preproc = p.blue.blueLagoon, -- (imports)

		-- Neutral: (Connections / Info)
		bracket = p.brown.paleclay, -- (bracket punctuation)
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
		match = p.orange.lightestsunset,
		visual = { bg = p.visual.blue, fg = "none" },
		search = { bg = p.visual.orange, fg = ui.fg.core },
		curSearch = { bg = p.orange.lightestsunset, fg = ui.bg.core },
		dir = p.blue.skyblue,

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
			error = { fg = p.red.brightdesertrose, bg = p.diag.error.bg },
			warn = { fg = p.diag.warn.fg, bg = p.diag.warn.bg },
			info = { fg = p.diag.info.fg_light, bg = p.diag.info.bg },
			hint = { fg = p.diag.hint.fg_light, bg = p.diag.hint.bg },
			ok = { fg = p.diag.ok.fg, bg = "none" },
		},
	},
}
return c
