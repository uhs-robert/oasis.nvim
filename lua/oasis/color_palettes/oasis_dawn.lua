-- lua/oasis/color_palettes/oasis_dawn.lua

local p = require("oasis.palette")
local key = "dawn"

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
		primary = "#A63333",
		light_primary = "#753826",
		secondary = "#134c7d",
		accent = "#134c7d",
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
		parameter = "#5e00cd",
		identifier = "#424A54",
		delimiter = ui.theme.primary,
		type = "#28504a",
		builtinVar = "#004f72",
		string = "#155433",
		regex = "#1d550e",
		builtinConst = "#22514B",
		constant = "#7a3605",

		-- Warm: (Control / Flow)
		func = "#723B06",
		builtinFunc = "#89270b",
		statement = "#514a0b",
		exception = "#931313",
		keyword = "#4e4b23",
		special = "#753a00",
		operator = "#990000",
		punctuation = "#931515",
		preproc = "#085160",

		-- Neutral: (Connections / Info)
		bracket = "#50493E",
		comment = ui.fg.comment,
	},

	-- Diff
	diff = {
		add = "#2F7D32",
		change = "#4c4c00",
		delete = "#862929",
	},

	-- UI
	ui = {
		match = "#753a00",
		visual = { bg = ui.bg.surface, fg = "none" },
		search = { bg = "#FFD87C", fg = "#462E23" },
		curSearch = { bg = p.orange.deepsun, fg = "#2C1810" },
		dir = "#114f68",

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
			error = { fg = "#862929", bg = ui.bg.core },
			warn = { fg = "#4c4c00", bg = ui.bg.core },
			info = { fg = "#114f68", bg = ui.bg.core },
			hint = { fg = "#21514a", bg = ui.bg.core },
			ok = { fg = "#2F7D32", bg = "none" },
		},
	},
}
return c
