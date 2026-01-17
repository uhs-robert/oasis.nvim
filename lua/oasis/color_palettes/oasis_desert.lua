-- lua/oasis/color_palettes/oasis_desert.lua

local Config = require("oasis.config")
local p = require("oasis.palette")
local opts = Config.get()
local theme = p.theme.desert

-- Neovim: Only generate when needed. Extras: generate both.
local in_neovim = vim.uv ~= nil or vim.loop ~= nil
local need_light = not in_neovim or vim.o.background == "light"

-- General Reusable Colors
local base = {
  bg = theme.bg,
  fg = theme.fg,
  palette = {
    primary = p.khaki,
    secondary = p.red,
    accent = p.palm,
  },
  theme = {
    strong_primary = p.khaki[600],
    primary = p.khaki[500],
    light_primary = p.khaki[300],
    secondary_strong = p.red[800],
    secondary = p.red[400],
    secondary_light = p.red[50],
    accent = p.palm[500],
    cursor = p.khaki[500],
  },
}

local primary = base.palette.primary

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
    parameter = p.lavender[300],
    identifier = p.teal[300],
    delimiter = base.theme.secondary,
    type = p.teal[500],
    builtinVar = p.lagoon[300], -- (this, document, window, etc)
    string = p.cactus[400],
    regex = p.palm[400],
    builtinConst = p.slate[300], -- (e.g. null, undefined, Infinity, etc)
    constant = p.sunset[300], -- (constant: number, float, boolean, or const not string/character)

    -- Warm: (Control / Flow)
    func = p.sand[500],
    builtinFunc = p.sundown[400], -- (eg. parseInst, Array, Object etc)
    statement = opts.themed_syntax and primary[500] or p.khaki[500], -- (general statement (i.e. var, const))
    exception = opts.themed_syntax and p.red[50] or p.red[50], -- (try/catch, return)
    conditional = opts.themed_syntax and primary[600] or p.khaki[600], -- (Conditionals, Loops)
    special = p.sunset[300], -- (Statement not covered above)
    operator = p.peach[300],
    punctuation = p.coral[200],
    preproc = p.sky[500], -- (imports)

    -- Neutral: (Connections / Info)
    bracket = p.slate[300], -- (bracket punctuation)
    comment = (opts.useLegacyComments or opts.use_legacy_comments) and "#87CEEB" or theme.fg.comment,
  },

  -- UI
  ui = {
    lineNumber = p.sunset[400],
    visual = { bg = base.bg.surface, fg = "none" },
    search = { bg = p.visual.palm, fg = base.bg.core },
    match = { bg = p.palm[400], fg = base.bg.core },
    dir = p.sky[500],

    title = base.theme.secondary,
    border = base.theme.secondary,
    cursorLine = base.bg.mantle,
    nontext = base.fg.dim,
    float = {
      title = base.theme.secondary_light,
      fg = base.fg.strong,
      bg = base.bg.mantle,
      border = { fg = base.theme.secondary, bg = base.bg.mantle },
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
    search = { bg = p.visual.yellow, fg = base.fg.core },
    match = { bg = p.visual.orange, fg = base.fg.core },
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
