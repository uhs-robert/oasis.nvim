-- lua/oasis/color_palettes/oasis_dust.lua

local p = require("oasis.palette")
local key = "dust"

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
		primary = "#752424",
		light_primary = "#4E1818",
		secondary = "#11426e",
		accent = "#11426e",
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
		parameter = "#39007C",
		identifier = "#1D2B32",
		delimiter = ui.theme.primary,
		type = "#172E2B",
		builtinVar = "#0A2465",
		string = "#122F13",
		regex = "#222D08",
		builtinConst = "#072F29",
		constant = "#432000",

		-- Warm: (Control / Flow)
		func = "#461E00",
		builtinFunc = "#471D00",
		statement = "#362700",
		exception = "#530F0F",
		keyword = "#352800",
		special = "#471D09",
		operator = "#441D22",
		punctuation = "#2D291F",
		preproc = "#0B2B47",

		-- Neutral: (Connections / Info)
		bracket = "#2C2923",
		comment = ui.fg.comment,
	},

	-- Diff
	diff = {
		add = "#25491C",
		change = "#523E09",
		delete = "#530F0F",
	},

	-- UI
	ui = {
		match = "#3C2409",
		visual = { bg = ui.bg.surface, fg = "none" },
		search = { bg = "#FFD87C", fg = "#462E23" },
		curSearch = { bg = p.orange.deepsun, fg = "#2C1810" },
		dir = "#122D35",

		title = ui.theme.primary,
		border = ui.theme.primary,
		cursorLine = ui.bg.mantle,
		nontext = ui.fg.dim,
		float = {
			title = ui.theme.light_primary,
			fg = ui.fg.strong,
			bg = ui.bg.surface,
			border = { fg = ui.theme.primary, bg = ui.bg.mantle },
		},
		diag = {
			error = { fg = "#530F0F", bg = ui.bg.core },
			warn = { fg = "#372612", bg = ui.bg.core },
			info = { fg = "#122D35", bg = ui.bg.core },
			hint = { fg = "#142E29", bg = ui.bg.core },
			ok = { fg = "#25491C", bg = "none" },
		},
	},
}
return c
