-- lua/oasis/color_palettes/oasis_night.lua

local p = require("oasis.palette")
local config = require("oasis.config")
local color_utils = require("oasis.tools.color_utils")
local light_gen = require("oasis.tools.light_theme_generator")
local opts = config.get()
local theme = p.theme.night
local light_seed = require("oasis.color_palettes.oasis_canyon").dark
local target_lightness = 80

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
		secondary = p.sunset[500],
		accent = p.lagoon[500],
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
		identifier = p.teal[400],
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
		statement = opts.themed_syntax and ui.theme.palette.primary[400] or p.khaki[500], -- (general statement (i.e. var, const))
		exception = opts.themed_syntax and p.khaki[500] or p.red[400], -- (try/catch, return)
		conditional = opts.themed_syntax and p.rose[700] or p.khaki[700], -- (Conditionals, Loops)
		special = p.sunset[500], -- (Statement not covered above)
		operator = p.peach[300],
		punctuation = p.coral[500],
		preproc = p.sky[500], -- (imports)

		-- Neutral: (Connections / Info)
		bracket = p.grey[500],
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
		visual = { bg = p.visual.indigo, fg = "none" },
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

-- Light mode configuration (backgrounds/ui/theme from night fg, syntax from canyon)
local light_ui = vim.tbl_deep_extend("force", {}, dark.ui, {
	title = p.red[600],
	border = p.red[600],
})

local light_theme = vim.tbl_deep_extend("force", {}, dark.theme, {
	primary = p.red[600],
	light_primary = p.red[400],
})

local light_bg =
	light_gen.generate_light_backgrounds(ui.fg.core, opts.light_intensity, { target_l_core = target_lightness })
local light = {
	bg = light_bg,
	fg = light_gen.generate_light_foregrounds(light_seed.fg, light_bg.core, opts.light_intensity, opts.contrast),
	theme = light_gen.generate_light_theme(light_theme, opts.light_intensity),
	terminal = light_gen.generate_light_terminal(
		light_seed.terminal,
		light_bg.core,
		opts.light_intensity,
		opts.contrast
	),
	light_mode = true,

	-- Syntax
	syntax = light_gen.generate_light_syntax(
		light_seed.syntax,
		light_bg.core,
		opts.light_intensity,
		nil,
		opts.contrast
	),

	-- Diff
	diff = {
		add = color_utils.darken_to_contrast(dark.diff.add, light_bg.core, 7.0),
		change = color_utils.darken_to_contrast(dark.diff.change, light_bg.core, 7.0),
		delete = color_utils.darken_to_contrast(dark.diff.delete, light_bg.core, 7.0),
	},

	-- UI
	ui = light_gen.generate_light_ui(light_ui, light_bg, opts.light_intensity, opts.contrast),
}

-- Return dual-mode palette
return {
	dark = dark,
	light = light,
}
