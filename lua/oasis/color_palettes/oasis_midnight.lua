-- lua/oasis/color_palettes/oasis_midnight.lua

local p = require("oasis.palette")
local config = require("oasis.config")
local color_Utils = require("oasis.tools.color_utils")
local light_gen = require("oasis.tools.light_theme_generator")
local opts = config.get()
local theme = p.theme.midnight

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
		primary = p.red[800],
		light_primary = p.rose[500],
		secondary = p.sunset[400],
		accent = p.teal[600],
		palette = {
			primary = p.red,
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
		identifier = p.teal[500],
		delimiter = ui.theme.primary,
		type = p.teal[700],
		builtinVar = p.lagoon[500], -- (this, document, window, etc)
		string = p.cactus[500],
		regex = p.palm[500],
		builtinConst = p.slate[500], -- (constant: number, float, boolean, or const not string/character)
		constant = p.sunset[500],

		-- Warm: (Control / Flow)
		func = p.sunset[300],
		builtinFunc = p.sundown[400], -- (eg. parseInt, Array, Object etc)
		statement = opts.themed_syntax and ui.theme.palette.primary[300] or p.khaki[500], -- (general statement (i.e. var, const))
		exception = opts.themed_syntax and p.khaki[500] or p.red[400], -- (try/catch, return)
		conditional = opts.themed_syntax and p.rose[700] or p.khaki[700], -- (Conditionals, Loops)
		special = p.sunset[500], -- (Statement not covered above)
		operator = p.peach[300],
		punctuation = p.coral[400],
		preproc = p.sky[500], -- (imports)

		-- Neutral: (Connections / Info)
		bracket = p.slate[500],
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

		title = ui.theme.primary,
		border = ui.theme.primary,
		cursorLine = ui.bg.surface,
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
local light_bg = light_gen.generate_backgrounds(ui.fg.core, opts.light_intensity)
local light_ui = vim.tbl_deep_extend("force", {}, dark.ui, {
	title = p.red[700],
	border = p.red[700],
})

local light = {
	bg = light_bg,
	fg = light_gen.generate_foregrounds(ui.fg, light_bg.core, opts.light_intensity),
	theme = light_gen.generate_theme(ui.theme, opts.light_intensity),
	terminal = light_gen.generate_terminal(p.terminal, light_bg.core, opts.light_intensity, opts.contrast),
	light_mode = true,

	-- Syntax
	syntax = light_gen.generate_syntax(dark.syntax, light_bg.core, opts.light_intensity, nil, opts.contrast),

	-- Diff
	diff = {
		add = color_Utils.darken_to_contrast(dark.diff.add, light_bg.core, 7.0),
		change = color_Utils.darken_to_contrast(dark.diff.change, light_bg.core, 7.0),
		delete = color_Utils.darken_to_contrast(dark.diff.delete, light_bg.core, 7.0),
	},

	-- UI
	ui = light_gen.generate_ui(light_ui, light_bg, opts.light_intensity),
}

-- Return dual-mode palette
return {
	dark = dark,
	light = light,
}
