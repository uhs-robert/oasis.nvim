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
		primary = p.red.indianred,
		light_primary = p.red.desertrose,
		secondary = p.orange.sunset,
		accent = p.teal.darkagave,
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
		parameter = p.indigo.cactusflower,
		identifier = p.yellow.navajowhite,
		delimiter = ui.theme.primary,
		type = p.teal.darkagave,
		builtinVar = p.blue.skyBlueDress,
		string = p.green.cactus,
		regex = p.green.palm,
		builtinConst = p.teal.deepagave,
		constant = p.orange.darkRedDawn,

		-- Warm: (Control / Flow)
		func = p.orange.redDawn,
		builtinFunc = p.orange.sunrise,
		statement = p.yellow.khaki,
		exception = p.red.indianred,
		keyword = p.yellow.darkkhaki,
		special = p.orange.sunset,
		operator = p.red.desertrose,
		punctuation = p.red.heatwave,
		preproc = p.blue.crystalBlue,

		-- Neutral: (Connections / Info)
		bracket = p.brown.dryriverbed,
		comment = ui.fg.comment,
	},

	-- Diff
	diff = {
		add = p.green.springmoss,
		change = p.yellow.dune,
		delete = p.red.brick,
	},

	-- UI
	ui = {
		match = p.orange.sunset,
		visual = { bg = p.visual.orange, fg = "none" },
		search = { bg = p.teal.sky, fg = ui.fg.core },
		curSearch = { bg = p.orange.sun, fg = ui.fg.core },

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
