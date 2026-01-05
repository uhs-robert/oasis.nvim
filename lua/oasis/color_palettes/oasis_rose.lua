-- lua/oasis/color_palettes/oasis_rose.lua

local Config = require("oasis.config")
local LightTheme = require("oasis.tools.light_theme_generator")
local p = require("oasis.palette")
local opts = Config.get()
local theme = p.theme.rose
local force_aaa = opts.contrast and opts.contrast.force_aaa or opts.contrast.min_ratio > 5.8

-- General Reusable Colors
local ui = {
  bg = theme.bg,
  fg = theme.fg,
  -- General colors
  theme = {
    strong_primary = p.rose[700],
    primary = p.rose[600],
    light_primary = p.rose[400],
    secondary = p.gold[400],
    accent = p.sky[500],
    palette = {
      primary = p.rose,
    },
  },
}

local primary = ui.theme.palette.primary

-- Dark mode palette
local dark = {
  bg = ui.bg,
  fg = ui.fg,
  theme = ui.theme,
  terminal = p.terminal,
  diff = vim.tbl_extend("force", p.diff, { change = theme.bg.surface }),
  git = p.git,

  -- Syntax
  syntax = {
    -- Cold: (Data)
    parameter = p.lavender[400],
    identifier = p.teal[500],
    delimiter = ui.theme.strong_primary,
    type = p.teal[700],
    builtinVar = p.lagoon[500], -- (this, document, window, etc)
    string = p.cactus[700],
    regex = p.palm[500],
    builtinConst = p.slate[500], -- (e.g. null, undefined, Infinity, etc)
    constant = p.sunset[500], -- (constant: number, float, boolean, or const not string/character)

    -- Warm: (Control / Flow)
    func = p.sunset[300],
    builtinFunc = p.sundown[400], -- (eg. parseInst, Array, Object etc)
    statement = opts.themed_syntax and primary[500] or p.khaki[500], -- (general statement (i.e. var, const))
    exception = opts.themed_syntax and p.khaki[500] or p.red[200], -- (try/catch, return)
    conditional = opts.themed_syntax and force_aaa and primary[600] or primary[700] or p.khaki[700], -- (Conditionals, Loops)
    special = p.sunset[400], -- (Statement not covered above)
    operator = p.peach[300],
    punctuation = p.coral[300],
    preproc = p.sky[500], -- (imports)

    -- Neutral: (Connections / Info)
    bracket = p.slate[500], -- (bracket punctuation)
    comment = theme.fg.comment, -- (comments)
  },

  -- UI
  ui = {
    lineNumber = p.sunshine[600],
    match = { bg = p.sunshine[600], fg = ui.bg.core },
    visual = { bg = ui.bg.surface, fg = "none" },
    search = { bg = p.visual.teal, fg = ui.fg.core },
    curSearch = { bg = p.teal[300], fg = ui.bg.core },
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
local light_bg = LightTheme.generate_bg(ui.fg.core, opts.light_intensity)
local light_ui = vim.tbl_deep_extend("force", {}, dark.ui, {
  search = { bg = p.visual.pink, fg = ui.fg.core },
  curSearch = { bg = p.visual.teal, fg = ui.fg.core },
})
local light = {
  light_mode = true,
  bg = light_bg,
  fg = LightTheme.generate_fg(ui.fg, light_bg.core, opts.light_intensity),
  theme = LightTheme.generate_theme(ui.theme, opts.light_intensity),
  terminal = LightTheme.generate_terminal(p.terminal, light_bg.core, opts.light_intensity, opts.contrast),
  diff = LightTheme.apply_contrast(dark.diff, light_bg.core),
  git = LightTheme.apply_contrast(dark.git, light_bg.core),
  syntax = LightTheme.generate_syntax(dark.syntax, light_bg.core, opts.light_intensity, nil, opts.contrast),
  ui = LightTheme.generate_ui(light_ui, light_bg, opts.light_intensity),
}

-- Return dual-mode palette
return {
  dark = dark,
  light = light,
}
