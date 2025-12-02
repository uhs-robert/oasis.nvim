-- lua/oasis/color_palettes/oasis_dawn.lua

local p = require("oasis.palette")
local theme = p.theme.dawn

-- General Reusable Colors
local ui = {
	-- Backgrounds
	bg = {
		core = theme.bg.core,
		shadow = theme.bg.shadow,
		mantle = theme.bg.mantle,
		surface = theme.bg.surface,
	},
	-- Foregrounds
	fg = {
		core = theme.fg.core,
		strong = theme.fg.strong,
		muted = theme.fg.muted,
		dim = theme.fg.dim,
		comment = theme.fg.comment,
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
		builtinVar = "#004f72", -- (this, document, window, etc)
		string = "#155433",
		regex = "#1d550e",
		builtinConst = "#22514B", -- (constant: number, float, boolean, or const not string/character)
		constant = "#7a3605",

		-- Warm: (Control / Flow)
		func = "#723B06",
		builtinFunc = "#89270b", -- (eg. parseInt, Array, Object etc)
		statement = "#514a0b", -- (general statement (i.e. var, const))
		exception = "#931313", -- (try/catch, return)
		conditional = "#45421F", -- (Conditionals, Loops)
		special = "#753a00", -- (Statement not covered above)
		operator = "#900000",
		punctuation = "#7E1B1B",
		preproc = "#085160", -- (imports)

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
		lineNumber = "#753a00",
		match = { bg= "#FFD87C", fg = "#753a00" },
		visual = { bg = ui.bg.surface, fg = "none" },
		search = { bg = "#FFD87C", fg = "#462E23" },
		curSearch = { bg = p.sunshine[600], fg = "#2C1810" },
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
