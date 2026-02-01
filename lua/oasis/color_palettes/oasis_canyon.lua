-- lua/oasis/color_palettes/oasis_canyon.lua

local Config = require("oasis.config")
local p = require("oasis.palette")
local opts = Config.get()
local theme = p.theme.canyon

-- Neovim: Only generate when needed. Extras: generate both.
local in_neovim = vim.uv ~= nil or vim.loop ~= nil
local need_light = not in_neovim or vim.o.background == "light"

-- General Reusable Colors
local base = {
  bg = theme.bg,
  fg = theme.fg,
  palette = {
    primary = p.sunset,
    secondary = p.rose,
    accent = p.sky,
  },
  theme = {
    strong_primary = p.sunset[500],
    primary = p.sunset[300],
    light_primary = p.sunshine[200],
    secondary = p.rose[500],
    accent = p.lagoon[500],
    cursor = p.khaki[500],
  },
}

-- Dark mode palette
local dark = {
  bg = base.bg,
  fg = base.fg,
  theme = base.theme,
  palette = base.palette,
  terminal = vim.tbl_extend(
    "force",
    p.terminal,
    { black = theme.bg.core, color0 = theme.bg.core, bright_black = theme.fg.muted, color8 = theme.fg.muted }
  ),
  diff = vim.tbl_extend("force", p.diff, { change = theme.bg.surface }),
  git = p.git,

  -- Syntax
  syntax = {
    -- Cold: (Data)
    parameter = p.lavender[400],
    identifier = p.sky[500],
    delimiter = base.theme.strong_primary,
    type = p.teal[700],
    builtinVar = p.gold[400], -- (this, document, window, etc)
    string = p.cactus[500],
    regex = p.palm[400],
    builtinConst = p.steelblue[500], -- (e.g. null, undefined, Infinity, etc)
    constant = p.sunset[600], -- (constant: number, float, boolean, or const not string/character)

    -- Warm: (Control / Flow)
    func = p.sand[300],
    builtinFunc = p.sand[500], -- (eg. parseInst, Array, Object etc)
    statement = opts.themed_syntax and base.palette.primary[300] or p.khaki[500], -- (general statement (i.e. var, const))
    exception = p.red[300], -- (try/catch, return)
    conditional = opts.themed_syntax and base.palette.primary[400] or p.khaki[700], -- (Conditionals, Loops)
    special = p.sunset[400], -- (Statement not covered above)
    operator = p.rose[500],
    punctuation = p.coral[400],
    preproc = p.teal[300], -- (imports)

    -- Neutral: (Connections / Info)
    bracket = p.slate[500], -- (bracket punctuation)
    comment = theme.fg.comment, -- (comments)
  },

  -- UI
  ui = {
    lineNumber = p.sunset[600],
    visual = { bg = base.bg.surface, fg = "none" },
    search = { bg = p.sky[900], fg = base.fg.core },
    match = { bg = p.lagoon[500], fg = base.bg.core },
    matchParen = { bg = p.visual.blue, fg = p.lagoon[500] },
    dir = p.sky[400],

    title = base.theme.primary,
    border = base.theme.strong_primary,
    cursorLine = base.bg.mantle,
    nontext = base.fg.dim,
    float = {
      title = base.theme.primary,
      fg = base.fg.strong,
      bg = base.bg.mantle,
      border = { fg = base.theme.strong_primary, bg = base.bg.mantle },
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
local light
if need_light then
  local LightTheme = require("oasis.tools.light_theme_generator")
  local light_bg = LightTheme.generate_bg(base.fg.core, opts.light_intensity)
  local light_ui = vim.tbl_deep_extend("force", {}, dark.ui, {
    search = { bg = p.visual.orange, fg = base.fg.core },
    match = { bg = p.lagoon[500], fg = base.fg.core },
  })
  light = {
    light_mode = true,
    bg = light_bg,
    fg = LightTheme.generate_fg(base.fg, light_bg.core, opts.light_intensity),
    theme = LightTheme.generate_theme(base.theme, opts.light_intensity),
    terminal = LightTheme.generate_terminal(p.terminal, light_bg.core, opts.light_intensity, opts.contrast),
    diff = LightTheme.apply_contrast(dark.diff, light_bg.core),
    git = LightTheme.apply_contrast(dark.git, light_bg.core),
    syntax = LightTheme.generate_syntax(dark.syntax, light_bg.core, opts.light_intensity, nil, opts.contrast),
    ui = LightTheme.generate_ui(light_ui, light_bg, opts.light_intensity),
  }
end

-- Return dual-mode palette
return {
  dark = dark,
  light = light,
}
