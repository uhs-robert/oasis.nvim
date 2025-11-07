-- lua/oasis/color_palettes/oasis_day.lua

local p = require("oasis.palette")
local key = "day"

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
		primary = "#B5563A",
		light_primary = "#B5563A",
		secondary = "#1C6FB8",
		accent = "#1C6FB8",
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
		parameter = "#5A2FCC", -- parameters
		identifier = "#8F6F4E", -- property identifiers
		delimiter = ui.theme.primary, -- delimiters
		type = "#0A6F8D", -- type definitions
		builtinVar = "#2A60EA", -- this, document, window, etc
		string = "#2A712D", -- strings
		regex = "#516B14", -- regular expressions
		builtinConst = "#169885", -- null, undefined, Infinity
		constant = "#D26600", -- numbers/booleans/const (non-string)

		-- Warm: (Control / Flow)
		func = "#A34700", -- function names
		builtinFunc = "#C14F00", -- Array, Object, etc --TODO: Seperate from fun and constant
		statement = "#A07400", -- if/for/while/labels
		exception = "#C12424", -- try/catch/return
		keyword = "#7B5C00", -- general keywords
		special = "#B44A18", -- misc specials
		-- operator = "#AD6078", -- operators
		operator = "#B85763", -- or "#B3505E" / "#A84B58"
		punctuation = "#6F664D", -- punctuation
		preproc = "#1964A6", -- imports/preprocessor

		-- Neutral: (Connections / Info)
		bracket = "#5E574A", -- bracket punctuation
		comment = ui.fg.comment, -- comments
	},

	-- Diff
	diff = {
		add = "#2F7D32",
		change = p.brown.sandstoneGlow,
		delete = "#C12424",
	},

	-- UI
	ui = {
		match = "#804d13",
		visual = { bg = ui.bg.surface, fg = "none" },
		search = { bg = p.yellow.wheat, fg = ui.bg.core },
		curSearch = { bg = p.orange.deepsun, fg = ui.bg.core },
		dir = "#255e6f",

		title = ui.theme.primary,
		border = ui.theme.primary,
		cursorLine = ui.bg.mantle,
		nontext = ui.fg.dim,
		float = {
			title = ui.theme.primary,
			fg = ui.fg.core,
			bg = ui.bg.surface,
			border = { fg = ui.theme.primary, bg = ui.bg.mantle },
		},
		diag = {
			error = { fg = "#C12424", bg = p.brown.paleclay },
			warn = { fg = p.brown.sandstoneGlow, bg = p.brown.fadedclay },
			info = { fg = "#255e6f", bg = p.brown.fadedclay },
			hint = { fg = "#2c635a", bg = p.brown.fadedclay },
			ok = { fg = "#2F7D32", bg = "none" },
		},
	},
}
return c
