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
		primary = p.red.vibrantred,
		light_primary = p.red.desertrose,
		secondary = p.orange.sunset,
		accent = p.blue.horizon,
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
		parameter = p.indigo.moonlitflower,
		identifier = p.yellow.navajowhite,
		delimiter = ui.theme.primary,
		type = p.teal.darkagave,
		builtinVar = p.blue.skyBlueDress,
		string = p.green.cactus,
		regex = p.green.palm,
		builtinConst = p.teal.midagave,
		constant = p.orange.darkRedDawn,

		-- Warm: (Control / Flow)
		func = p.orange.redDawn,
		builtinFunc = p.orange.deepersun,
		statement = p.yellow.khaki,
		exception = p.red.brightvibrantred,
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
		add = p.green.moss,
		change = p.yellow.dune,
		delete = p.red.brick,
	},

	-- UI
	ui = {
		match = p.orange.sunset,
		visual = { bg = p.visual.indigo, fg = "none" },
		search = { bg = p.visual.orange, fg = ui.fg.core },
		curSearch = { bg = p.orange.sun, fg = ui.bg.core },

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
			error = { fg = p.diag.error.fg_light, bg = p.diag.error.bg },
			warn = { fg = p.diag.warn.fg, bg = p.diag.warn.bg },
			info = { fg = p.diag.info.fg_light, bg = p.diag.info.bg },
			hint = { fg = p.diag.hint.fg_light, bg = p.diag.hint.bg },
			ok = { fg = p.diag.ok.fg, bg = "none" },
		},
	},
}
return c
