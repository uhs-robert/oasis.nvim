-- lua/oasis/color_palettes/oasis_dawnlight.lua

local p = require("oasis.palette")
local key = "dawnlight"

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
		primary = "#703524",
		light_primary = "#703624",
		secondary = "#124977",
		accent = "#124977",
	},
}

-- Colorscheme
local c = {
	bg = ui.bg,
	fg = ui.fg,
	theme = ui.theme,
	terminal = p.light_terminal,
	light_mode = true,

	-- Syntax
	syntax = {
		-- Cold: (Data)
		parameter = "#541cb8",
		identifier = "#314955",
		delimiter = ui.theme.primary,
		type = "#074c60",
		builtinVar = "#113ba7",
		string = "#1e5020",
		regex = "#3a4c0e",
		builtinConst = "#0c4f45",
		constant = "#703700",

		-- Warm: (Control / Flow)
		func = "#753300",
		builtinFunc = "#773100",
		statement = "#5c4200",
		exception = "#891a1a",
		keyword = "#594200",
		special = "#773110",
		operator = "#733139",
		punctuation = "#4c4635",
		preproc = "#124878",

		-- Neutral: (Connections / Info)
		bracket = "#4a453b",
		comment = ui.fg.comment,
	},

	-- Diff
	diff = {
		add = "#2F7D32",
		change = "#5e401e",
		delete = "#891a1a",
	},

	-- UI
	ui = {
		match = "#653d0f",
		visual = { bg = ui.bg.surface, fg = "none" },
		search = { bg = "#FFD87C", fg = "#462E23" },
		curSearch = { bg = p.orange.deepsun, fg = "#2C1810" },
		dir = "#1e4b59",

		title = ui.theme.primary,
		border = ui.theme.primary,
		cursorLine = ui.bg.mantle,
		nontext = ui.fg.dim,
		float = {
			title = ui.theme.primary,
			fg = ui.fg.strong,
			bg = ui.bg.surface,
			border = { fg = ui.theme.primary, bg = ui.bg.mantle },
		},
		diag = {
			error = { fg = "#891a1a", bg = ui.bg.core },
			warn = { fg = "#5e401e", bg = ui.bg.core },
			info = { fg = "#1e4b59", bg = ui.bg.core },
			hint = { fg = "#224d45", bg = ui.bg.core },
			ok = { fg = "#2F7D32", bg = "none" },
		},
	},
}
return c
