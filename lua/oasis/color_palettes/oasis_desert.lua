-- lua/oasis/color_palettes/oasis_desert.lua

local p = require("oasis.palette")
local Config = require("oasis.config")
local ColorUtils = require("oasis.tools.color_utils")
local LightTheme = require("oasis.tools.light_theme_generator")
local opts = Config.get()
local theme = p.theme.desert

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
		strong_primary = p.red[800],
		primary = p.red[500],
		light_primary = p.rose[500],
		secondary = p.khaki[500],
		accent = p.sky[500],
		palette = {
			primary = p.khaki,
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
		parameter = p.lavender[300],
		identifier = p.teal[300],
		delimiter = ui.theme.strong_primary,
		type = p.teal[500],
		builtinVar = p.lagoon[300], -- (this, document, window, etc)
		string = p.cactus[400],
		regex = p.palm[400],
		builtinConst = p.slate[300], -- (e.g. null, undefined, Infinity, etc)
		constant = p.sunset[300], -- (constant: number, float, boolean, or const not string/character)

		-- Warm: (Control / Flow)
		func = p.sand[500],
		builtinFunc = p.sundown[400], -- (eg. parseInst, Array, Object etc)
		statement = opts.themed_syntax and ui.theme.palette.primary[500] or p.khaki[500], -- (general statement (i.e. var, const))
		exception = opts.themed_syntax and p.red[50] or p.red[50], -- (try/catch, return)
		conditional = opts.themed_syntax and ui.theme.palette.primary[600] or p.khaki[600], -- (Conditionals, Loops)
		special = p.sunset[300], -- (Statement not covered above)
		operator = p.peach[300],
		punctuation = p.coral[200],
		preproc = p.sky[500], -- (imports)

		-- Neutral: (Connections / Info)
		bracket = p.slate[300], -- (bracket punctuation)
		comment = (opts.useLegacyComments or opts.use_legacy_comments) and "#87CEEB" or theme.fg.comment,
	},

	-- Diff
	diff = {
		add = p.visual.green,
		change = theme.bg.surface,
		delete = p.visual.red,
	},

	-- UI
	ui = {
		lineNumber = p.sunset[400],
		match = { bg = p.sunset[400], fg = ui.bg.core },
		visual = { bg = ui.bg.surface, fg = "none" },
		curSearch = { bg = p.sunset[500], fg = ui.bg.core },
		search = { bg = p.visual.orange, fg = ui.fg.core },
		dir = p.sky[500],

		title = ui.theme.primary,
		border = ui.theme.strong_primary,
		cursorLine = ui.bg.mantle,
		nontext = ui.fg.dim,
		float = {
			title = ui.theme.light_primary,
			fg = ui.fg.core,
			bg = ui.bg.surface,
			border = { fg = ui.theme.strong_primary, bg = ui.bg.mantle },
		},
		diag = {
			error = { fg = p.rose[400], bg = p.diag.error.bg },
			warn = { fg = p.diag.warn.fg, bg = p.diag.warn.bg },
			info = { fg = p.diag.info.fg_light, bg = p.diag.info.bg },
			hint = { fg = p.diag.hint.fg_light, bg = p.diag.hint.bg },
			ok = { fg = p.diag.ok.fg, bg = "none" },
		},
	},
}

-- Light mode configuration
local light_bg = LightTheme.generate_backgrounds(ui.fg.core, opts.light_intensity)
local light_ui = vim.tbl_deep_extend("force", {}, dark.ui, {
	search = { bg = p.visual.yellow, fg = ui.fg.core },
	curSearch = { bg = p.visual.orange, fg = ui.fg.core },
})

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
	ui = LightTheme.generate_ui(light_ui, light_bg, opts.light_intensity),
}

-- Return dual-mode palette
return {
	dark = dark,
	light = light,
}
