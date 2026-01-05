-- lua/oasis/color_palettes/oasis_twilight.lua

local p = require("oasis.palette")
local Config = require("oasis.config")
local ColorUtils = require("oasis.tools.color_utils")
local LightTheme = require("oasis.tools.light_theme_generator")
local opts = Config.get()
local theme = p.theme.twilight

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
    strong_primary = p.lavender[600],
    primary = p.lavender[500],
    light_primary = p.lavender[300],
    secondary = p.khaki[400],
    accent = p.cactus[700],
    palette = {
      primary = p.lavender,
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
    parameter = opts.themed_syntax and p.khaki[500] or p.lavender[500],
    identifier = p.teal[300],
    delimiter = ui.theme.strong_primary,
    type = p.teal[600],
    builtinVar = p.lagoon[500], -- (this, document, window, etc)
    string = p.cactus[700],
    regex = p.palm[500],
    builtinConst = p.slate[500], -- (e.g. null, undefined, Infinity, etc)
    constant = p.sunset[400], -- (constant: number, float, boolean, or const not string/character)

    -- Warm: (Control / Flow)
    func = p.sunset[200],
    builtinFunc = p.sundown[400], -- (eg. parseInst, Array, Object etc)
    statement = opts.themed_syntax and ui.theme.palette.primary[200] or p.khaki[500], -- (general statement (i.e. var, const))
    exception = p.red[300], -- (try/catch, return)
    conditional = opts.themed_syntax and ui.theme.palette.primary[400] or p.khaki[700], -- (Conditionals, Loops)
    special = p.sunset[400], -- (Statement not covered above)
    operator = p.rose[400],
    punctuation = p.coral[400],
    preproc = p.sky[500], -- (imports)

    -- Neutral: (Connections / Info)
    bracket = p.grey[400], -- (bracket punctuation)
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
    visual = { bg = ui.bg.surface, fg = "none" },
    search = { bg = p.visual.yellow, fg = ui.fg.core },
    curSearch = { bg = p.khaki[500], fg = ui.bg.core },
    dir = p.sky[500],

    title = ui.theme.primary,
    border = ui.theme.strong_primary,
    cursorLine = ui.bg.mantle,
    nontext = ui.fg.dim,
    float = {
      title = ui.theme.primary,
      fg = ui.fg.strong,
      bg = ui.bg.mantle,
      border = { fg = ui.theme.strong_primary, bg = ui.bg.mantle },
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
local light_ui = vim.tbl_deep_extend("force", {}, dark.ui, {
  search = { bg = p.visual.indigo, fg = ui.fg.core },
  curSearch = { bg = p.visual.yellow, fg = ui.fg.core },
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
