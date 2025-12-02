-- lua/oasis/color_palettes/oasis_cactus.lua

local p = require("oasis.palette")
local config = require("oasis.config")
local color_utils = require("oasis.tools.color_utils")
local light_gen = require("oasis.tools.light_theme_generator")
local opts = config.get()
local theme = p.theme.cactus

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
	},
	-- General colors
	theme = {
		primary = p.aloe[700],
		light_primary = p.aloe[500],
		secondary = p.rose[700],
		accent = p.rose[500],
		palette = {
			primary = p.aloe,
		},
	},
}

-- Dark mode palette
local dark = {
	bg = ui.bg,
	fg = ui.fg,
	theme = ui.theme,
	terminal = p.terminal,

	-- Syntax
	syntax = {
		-- Cold: (Data)
		parameter = p.lavender[400],
		identifier = p.sky[500],
		delimiter = ui.theme.primary,
		type = p.lagoon[500],
		builtinVar = opts.themed_syntax and p.khaki[500] or p.lagoon[500], -- (this, document, window, etc)
		string = p.cactus[700],
		regex = p.palm[500],
		builtinConst = p.slate[400], -- (e.g. null, undefined, Infinity, etc)
		constant = p.sunset[500], -- (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = p.sunset[300],
		builtinFunc = p.sundown[400], -- (eg. parseInst, Array, Object etc)
		statement = opts.themed_syntax and ui.theme.palette.primary[400] or p.khaki[500], -- (general statement (i.e. var, const))
		exception = p.red[200], -- (try/catch, return)
		conditional = opts.themed_syntax and ui.theme.palette.primary[600] or p.khaki[700], -- (Conditionals, Loops)
		special = p.sunset[400], -- (Statement not covered above)
		operator = p.rose[400],
		punctuation = p.coral[300],
		preproc = p.sand[300], -- (imports)

		-- Neutral: (Connections / Info)
		bracket = p.slate[400], -- (bracket punctuation)
		comment = theme.fg.comment, -- (comments)
	},

	-- Diff
	diff = {
		add = p.visual.green,
		change = theme.bg.surface,
		delete = p.visual.red,
	},

	-- UI
	ui = {
		lineNumber = p.sunset[500],
		match = { bg = p.sunset[500], fg = ui.bg.core },
		visual = { bg = p.visual.orange, fg = "none" },
		search = { bg = p.visual.orange, fg = ui.fg.core },
		curSearch = { bg = p.sunshine[500], fg = ui.bg.core },
		dir = p.sky[500],

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
			error = { fg = p.diag.error.fg_light, bg = p.diag.error.bg },
			warn = { fg = p.diag.warn.fg, bg = p.diag.warn.bg },
			info = { fg = p.diag.info.fg_light, bg = p.diag.info.bg },
			hint = { fg = p.diag.hint.fg_light, bg = p.diag.hint.bg },
			ok = { fg = p.diag.ok.fg, bg = "none" },
		},
	},
}

-- Light mode configuration
local light_bg = light_gen.generate_light_backgrounds(ui.fg.core, opts.light_intensity)
local light = {
	bg = light_bg,
	fg = light_gen.generate_light_foregrounds(ui.fg, light_bg.core, opts.light_intensity),
	theme = light_gen.generate_light_theme(ui.theme, opts.light_intensity),
	terminal = light_gen.generate_light_terminal(p.terminal, light_bg.core, opts.light_intensity),
	light_mode = true,

	-- Syntax
	syntax = light_gen.generate_light_syntax(dark.syntax, light_bg.core, opts.light_intensity),

	-- Diff
	diff = {
		add = color_utils.darken_to_contrast(dark.diff.add, light_bg.core, 7.0),
		change = color_utils.darken_to_contrast(dark.diff.change, light_bg.core, 7.0),
		delete = color_utils.darken_to_contrast(dark.diff.delete, light_bg.core, 7.0),
	},

	-- UI
	ui = light_gen.generate_light_ui(dark.ui, light_bg, opts.light_intensity),
}

-- Return dual-mode palette
return {
	dark = dark,
	light = light,
}
