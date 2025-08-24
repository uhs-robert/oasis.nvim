-- lua/oasis/color_palettes/oasis_midnight.lua
local lush = require("lush")
local hsl = lush.hsl
local color = require("oasis.palette")

local palette = {
	-- Backgrounds
  bg = {
		main = hsl("#000000"),
		panel = hsl("#080808"),
		inlay = hsl("#121212"),
		surface = hsl("#1A1A1A"),
  },
	-- Foregrounds
  fg = {
		main = hsl(color.lightSand),
		muted = hsl(color.darkSand),
  },
  -- U
  theme = {
    primary = hsl("#CD5C5C"),
    secondary = hsl("#FF9F41"),
    accent = hsl("#4AC8FF"),
  }
}

local c = {
  bg = palette.bg,
  fg = palette.fg,
  theme = palette.theme,
	-- UI
	ui = {
    title = palette.theme.primary,
		border = palette.theme.primary,
		cursorLine = hsl("#6DCEEB").desaturate(40).darken(82), -- TODO: What is this and test it and change it
		nontext = hsl("#514742"), -- #6B5B56
		match = hsl("#FFD700"),
		-- matchParen = hsl(),
		visual = { bg = hsl("#36525e"), fg = "none" },
		search = { bg = hsl("#019992"), fg = palette.fg.main },
		curSearch = { bg = hsl("#F5A72C"), fg = hsl(color.black) },

		float = {
			fg = palette.fg.main,
			bg = palette.bg.panel,
      title = palette.theme.secondary,
			fg_border = palette.theme.primary,
			bg_border = palette.bg.panel,
		},
		diag = {
			error = {
				fg = hsl(color.diag.error.fg),
				bg = hsl(color.diag.error.bg),
			},
			warn = {
				fg = hsl(color.diag.warn.fg),
				bg = hsl(color.diag.warn.bg),
			},
			info = {
				fg = hsl(color.diag.info.fg),
				bg = hsl(color.diag.info.bg),
			},
			hint = {
				fg = hsl(color.diag.hint.fg),
				bg = hsl(color.diag.hint.bg),
			},
			ok = {
				fg = hsl("#00FF7F"),
				bg = "none",
			},
		},
	},

	-- Syntax
	syntax = {

		-- Cold: (Data)
		parameter = hsl("#B499FF"), -- (paramaters) [UNIQUE]
		identifier = hsl("#87CEEB"), -- (property identifiers)
		type = hsl("#48B4E0"), -- (type definitions)
		builtinVar = hsl("#1CA1FF"), -- (this, document, window, etc)
		string = hsl("#35b56e"), -- (strings)
		regex = hsl("#9CEB87"), -- (reg ex string)
		builtinConst = hsl("#A7D3A9"), -- (e.g. null, undefined, Infinity, etc)
		constant = hsl("#FF99E4"), -- (constant: not string, character, number, float, or boolean)
		number = hsl("#FF99E4"), -- (number, float, boolean)

		-- Warm: (Control / Flow)
		func = hsl("#F8C471"), -- [inverse of identifier]
		builtinFunc = hsl("#F5A72C"), -- (eg. parseInst, Array, Object etc)
		statement = hsl("#F0E68C"), -- (primary color, general statement, conditonal, repeat, label )
		exception = hsl("#CD5C5C"), -- (try/catch, return)
		keyword = hsl("#E3963E"), -- (general catch all)
		special = hsl("#FF9F41"), -- (other catch all)
		operator = hsl("#ffa0a0"), -- (operators)
		punctuation = hsl("#E68A8A"), -- (punctuation)
		preproc = hsl("#E0C4A8"), -- (imports)

		-- Neutral: (Connections / Info)
		bracket = hsl("#9E9584"), -- (bracket punctuation)
		comment = hsl("#8b7765"), -- (comments)
	},
  --
	-- Diff
	diff = {
		add = hsl("#37F413"),
		change = hsl("#5F87AF"),
		delete = hsl("#D946EF"),
	},
}
return c
