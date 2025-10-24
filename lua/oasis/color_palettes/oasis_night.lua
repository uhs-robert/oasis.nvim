-- lua/oasis/color_palettes/oasis_night.lua

local p = require("oasis.palette")
local key = "night"

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
		primary = p.red.indianred, --#cd5c5c
		light_primary = p.red.desertrose,
		secondary = p.orange.sunset, --#FF9F41
		accent = p.blue.horizon, --#4AC8FF
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
		parameter = p.indigo.moonlitflower, --  #B499FF (paramaters) [UNIQUE]
		identifier = p.yellow.navajowhite, --  #87CEEB (property identifiers)
		delimiter = ui.theme.primary, -- (delimiters)
		type = p.teal.darkagave, --  #48B4E0 (type definitions)
		builtinVar = p.blue.skyBlueDress, --  #1CA1FF (this, document, window, etc)
		string = p.green.cactus, --  #35b56e (strings)
		regex = p.green.palm, --  #9CEB87 (reg ex string)
		builtinConst = p.teal.deepagave, --  #A7D3A9 (e.g. null, undefined, Infinity, etc)
		constant = p.orange.darkRedDawn, --  #8FD1C7 (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = p.orange.redDawn, --  #F8C471 [inverse of identifier]
		builtinFunc = p.orange.sunrise, --  #F5A72C (eg. parseInst, Array, Object etc)
		statement = p.yellow.khaki, --  #F0E68C (primary p, general statement, conditonal, repeat, label )
		exception = p.red.indianred, --  #CD5C5C (try/catch, return)
		keyword = p.yellow.darkkhaki, --  #E3963E (general catch all)
		special = p.orange.sunset, --  #FF9F41 (other catch all)
		operator = p.red.desertrose, --  #ffa0a0 (operators)
		punctuation = p.red.heatwave, --  #E68A8A (punctuation)
		preproc = p.blue.crystalBlue, --  #E0C4A8 (imports)

		-- Neutral: (Connections / Info)
		bracket = p.brown.dryriverbed, --  #9E9584 (bracket punctuation)
		comment = ui.fg.comment, --  #8b7765 (comments)
	},

	-- Diff
	diff = {
		add = p.green.moss, --#6BBF59
		change = p.yellow.dune, --#D4A017
		delete = p.red.brick, --#A23B3B
	},

	-- UI
	ui = {
		match = p.orange.sunset,
		visual = { bg = p.visual.indigo, fg = "none" }, --#4D4528
		search = { bg = p.teal.sky, fg = ui.fg.core }, -- #019992
		curSearch = { bg = p.orange.sun, fg = ui.fg.core }, -- #F5A72C

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
			error = { fg = p.diag.error.fg, bg = p.diag.error.bg },
			warn = { fg = p.diag.warn.fg, bg = p.diag.warn.bg },
			info = { fg = p.diag.info.fg, bg = p.diag.info.bg },
			hint = { fg = p.diag.hint.fg, bg = p.diag.hint.bg },
			ok = { fg = p.diag.ok.fg, bg = "none" },
		},
	},
}
return c
