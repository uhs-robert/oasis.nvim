-- lua/oasis/color_palettes/oasis_night.lua

local lush = require("lush")
local hsl = lush.hsl
local p = require("oasis.palette")
local key = "night"

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
	-- General colors
	theme = {
		primary = hsl(p.red.indianred), --#cd5c5c
		light_primary = hsl(p.red.desertrose),
		secondary = hsl(p.orange.sunset), --#FF9F41
		accent = hsl(p.blue.horizon), --#4AC8FF
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
		parameter = hsl(p.indigo.moonlitflower), --  #B499FF (paramaters) [UNIQUE]
		identifier = hsl(p.blue.darkskyblue), --  #87CEEB (property identifiers)
		delimiter = ui.theme.primary, -- (delimiters)
		type = hsl(p.teal.darkagave), --  #48B4E0 (type definitions)
		builtinVar = hsl(p.blue.skyBlueDress), --  #1CA1FF (this, document, window, etc)
		string = hsl(p.green.cactus), --  #35b56e (strings)
		regex = hsl(p.green.palm), --  #9CEB87 (reg ex string)
		builtinConst = hsl(p.teal.deepagave), --  #A7D3A9 (e.g. null, undefined, Infinity, etc)
		constant = hsl(p.orange.darkRedDawn), --  #8FD1C7 (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = hsl(p.orange.redDawn), --  #F8C471 [inverse of identifier]
		builtinFunc = hsl(p.orange.sunrise), --  #F5A72C (eg. parseInst, Array, Object etc)
		statement = hsl(p.yellow.khaki), --  #F0E68C (primary p, general statement, conditonal, repeat, label )
		exception = hsl(p.red.indianred), --  #CD5C5C (try/catch, return)
		keyword = hsl(p.yellow.darkkhaki), --  #E3963E (general catch all)
		special = hsl(p.orange.sunset), --  #FF9F41 (other catch all)
		operator = hsl(p.red.desertrose), --  #ffa0a0 (operators)
		punctuation = hsl(p.red.heatwave), --  #E68A8A (punctuation)
		preproc = hsl(p.blue.crystalBlue), --  #E0C4A8 (imports)

		-- Neutral: (Connections / Info)
		bracket = hsl(p.brown.dryriverbed), --  #9E9584 (bracket punctuation)
		comment = ui.fg.comment, --  #8b7765 (comments)
	},

	-- Diff
	diff = {
		add = hsl(p.green.moss), --#6BBF59
		change = hsl(p.yellow.dune), --#D4A017
		delete = hsl(p.red.brick), --#A23B3B
	},

	-- UI
	ui = {
		match = hsl(p.orange.sunset),
		visual = { bg = hsl(p.visual.indigo), fg = "none" }, --#4D4528
		search = { bg = hsl(p.teal.sky), fg = ui.fg.core }, -- #019992
		curSearch = { bg = hsl(p.orange.sun), fg = ui.fg.core }, -- #F5A72C

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
