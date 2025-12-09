-- lua/oasis/color_palettes/oasis_starlight.lua

local p = require("oasis.palette")
local config = require("oasis.config")
local ColorUtils = require("oasis.tools.color_utils")
local LightTheme = require("oasis.tools.light_theme_generator")
local opts = config.get()
local theme = p.theme.starlight

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
		primary = p.lagoon[500],
		light_primary = p.sky[500],
		secondary = p.khaki[400],
		accent = p.sunrise[500],
		palette = {
			primary = p.lagoon,
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
		parameter = p.lavender[500],
		identifier = p.teal[300],
		delimiter = ui.theme.palette.primary[600],
		type = p.teal[600],
		builtinVar = opts.themed_syntax and p.khaki[500] or p.lagoon[500], -- (this, document, window, etc)
		string = p.cactus[700],
		regex = p.palm[600],
		builtinConst = p.slate[500], -- (e.g. null, undefined, Infinity, etc)
		constant = p.sunset[500], -- (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = p.sunset[300],
		builtinFunc = p.sundown[400], -- (eg. parseInst, Array, Object etc)
		statement = opts.themed_syntax and ui.theme.palette.primary[500] or p.khaki[500], -- (general statement (i.e. var, const))
		exception = p.red[500], -- (try/catch, return)
		conditional = opts.themed_syntax and ui.theme.palette.primary[600] or p.gold[300], -- (Conditionals, Loops)
		special = p.sunset[400], -- (Statement not covered above)
		operator = p.rose[500],
		punctuation = p.rose[700],
		preproc = p.sky[500], -- (imports)

		-- Neutral: (Connections / Info)
		bracket = p.grey[500], -- (bracket punctuation)
		comment = theme.fg.comment, -- (comments)
	},

	-- Diff
	diff = {
		add = p.moss[500],
		change = theme.bg.surface,
		delete = p.visual.red,
	},

	-- UI
	ui = {
		lineNumber = p.sunset[500],
		match = { bg = p.sunset[500], fg = ui.bg.core },
		visual = { bg = p.visual.yellow, fg = "none" },
		search = { bg = p.visual.orange, fg = ui.fg.core },
		curSearch = { bg = p.sunshine[500], fg = ui.bg.core },
		dir = p.sky[500],

		title = ui.theme.primary,
		border = ui.theme.primary,
		cursorLine = p.theme.lagoon.bg.mantle, -- NOTE: Uses another theme's mantle
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
local light_bg = LightTheme.generate_backgrounds(ui.fg.core, opts.light_intensity)
local light = {
	bg = light_bg,
	fg = LightTheme.generate_foregrounds(ui.fg, light_bg.core, opts.light_intensity),
	theme = LightTheme.generate_theme(ui.theme, opts.light_intensity),
	terminal = LightTheme.generate_terminal(p.terminal, light_bg.core, opts.light_intensity, opts.contrast),
	light_mode = true,

	-- Syntax
	syntax = LightTheme.generate_syntax(dark.syntax, light_bg.core, opts.light_intensity, nil, opts.contrast),

	-- Diff
	diff = {
		add = ColorUtils.darken_to_contrast(dark.diff.add, light_bg.core, 7.0),
		change = ColorUtils.darken_to_contrast(dark.diff.change, light_bg.core, 7.0),
		delete = ColorUtils.darken_to_contrast(dark.diff.delete, light_bg.core, 7.0),
	},

	-- UI
	ui = LightTheme.generate_ui(dark.ui, light_bg, opts.light_intensity),
}

-- Return dual-mode palette
return {
	dark = dark,
	light = light,
}
