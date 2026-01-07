-- lua/oasis/color_palettes/oasis_starlight.lua

local Config = require("oasis.config")
local LightTheme = require("oasis.tools.light_theme_generator")
local p = require("oasis.palette")
local opts = Config.get()
local theme = p.theme.starlight

-- General Reusable Colors
local ui = {
  bg = theme.bg,
  fg = theme.fg,
  -- General colors
  theme = {
    strong_primary = p.lagoon[600],
    primary = p.lagoon[500],
    light_primary = p.sky[500],
    secondary = p.khaki[500],
    accent = p.sunrise[500],
    cursor = p.khaki[500],
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
  diff = vim.tbl_extend("force", p.diff, { change = theme.bg.surface }),
  git = p.git,

  -- Syntax
  syntax = {
    -- Cold: (Data)
    parameter = p.lavender[500],
    identifier = p.teal[300],
    delimiter = ui.theme.strong_primary,
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

  -- UI
  ui = {
    lineNumber = p.sunset[500],
    visual = { bg = p.visual.yellow, fg = "none" },
    search = { bg = p.visual.yellow, fg = ui.fg.core },
    match = { bg = p.khaki[500], fg = ui.bg.core },
    dir = p.sky[500],

    title = ui.theme.primary,
    border = ui.theme.strong_primary,
    cursorLine = p.theme.lagoon.bg.mantle, -- NOTE: Uses another theme's mantle
    nontext = ui.fg.dim,
    float = {
      title = ui.theme.primary,
      fg = ui.fg.strong,
      bg = ui.bg.mantle,
      border = { fg = ui.theme.strong_primary, bg = ui.bg.mantle },
    },
    diag = {
      error = { fg = p.diag.error.fg, bg = p.diag.error.bg },
      warn = { fg = p.diag.warn.fg, bg = p.diag.warn.bg },
      info = { fg = p.diag.info.fg, bg = p.diag.info.bg },
      hint = { fg = p.diag.hint.fg, bg = p.diag.hint.bg },
      ok = { fg = p.diag.ok.fg, bg = "none" },
    },
  },
}

-- Light mode configuration
local light_bg = LightTheme.generate_bg(ui.fg.core, opts.light_intensity)
local light_ui = vim.tbl_deep_extend("force", {}, dark.ui, {
  search = { bg = p.visual.yellow, fg = ui.fg.core },
  match = { bg = p.visual.orange, fg = ui.fg.core },
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
