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
    primary = "#C12424",
		light_primary = "#B44A18",
		secondary = "#1C6FB8",
		accent = "#1C6FB8",
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
		parameter = "#7A3FE2", -- parameters
		identifier = "#8F6F4E", -- property identifiers
		delimiter = ui.theme.light_primary, -- delimiters
		type = "#0A6F8D", -- type definitions
		builtinVar = "#2A60EA", -- this, document, window, etc
		string = "#2F7D32", -- strings
		regex = "#6C8F1A", -- regular expressions
		builtinConst = "#169885", -- null, undefined, Infinity
		constant = "#D26600", -- numbers/booleans/const (non-string)

		-- Warm: (Control / Flow)
		func = "#A34700", -- function names
		builtinFunc = "#C14F00", -- Array, Object, etc --TODO: Seperate from fun and constant
		statement = "#A07400", -- if/for/while/labels
		exception = "#C12424", -- try/catch/return
		keyword = "#7B5C00", -- general keywords
		special = "#B44A18", -- misc specials
		operator = "#AD6078", -- operators
		punctuation = "#6F664D", -- punctuation
		preproc = "#1C6FB8", -- imports/preprocessor

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
		match = p.orange.embercore,
		visual = { bg = p.visual.light_blue, fg = "none" },
		search = { bg = p.yellow.wheat, fg = ui.bg.core },
		curSearch = { bg = p.orange.deepsun, fg = ui.bg.core },
		dir = p.blue.wellwater,

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
			info = { fg = p.blue.wellwater, bg = p.brown.fadedclay },
			hint = { fg = p.teal.shadepool, bg = p.brown.fadedclay },
			ok = { fg = '#2F7D32', bg = "none" },
		},
	},
}
return c
