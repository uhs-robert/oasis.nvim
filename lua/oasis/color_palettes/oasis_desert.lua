-- lua/oasis/color_palettes/oasis_desert.lua

local Config = require("oasis.config")
local p = require("oasis.palette")
local opts = Config.get()
local theme = p.theme.desert

-- Neovim: Only generate when needed. Extras: generate both.
local in_neovim = vim.uv ~= nil or vim.loop ~= nil
local need_light = not in_neovim or vim.o.background == "light"
local use_legacy_comments = (opts.useLegacyComments or opts.use_legacy_comments)

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
    strong_primary = p.khaki[800],
    primary = p.khaki[500],
    light_primary = p.khaki[300],
    secondary_strong = p.red[800],
    secondary = p.red[500],
    secondary_light = p.rose[500],
    label = p.red[600],
    title = p.red[800],
    accent = p.palm[500],
    cursor = p.khaki[500],
  },
}

local primary = base.palette.primary

-- Dark mode palette
local dark = {
  is_desert = true, -- Treat as a desert variant
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
    parameter = p.palm[500],
    identifier = use_legacy_comments and p.sapphire[400] or p.sky[500],
    delimiter = base.theme.strong_primary,
    type = p.teal[500],
    typedef = p.teal[700],
    string = p.rose[500],
    regex = p.desert_rose[400],
    builtinVar = p.lavender[400], -- (this, document, window, etc)
    builtinConst = p.iris[400], -- (e.g. null, undefined, Infinity, etc)
    constant = p.sunset[500], -- (constant: number, float, boolean, or const not string/character)

    -- Warm: (Control / Flow)
    func = p.sand[400],
    builtinFunc = p.sand[200], -- (eg. parseInst, Array, Object etc)
    statement = primary[500], -- (general statement (i.e. var, const))
    exception = p.red[500], -- (try/catch, return)
    conditional = primary[800], -- (Conditionals, Loops)
    special = p.sunset[200], -- (Statement not covered above)
    operator = primary[600],
    punctuation = primary[700],

    -- Neutral: (Connections / Info)
    bracket = p.slate[500], -- (bracket)
    preproc = p.sundown[500], -- (imports)
    macro = p.sundown[600], -- (imports)
    comment = use_legacy_comments and p.cyan[500] or theme.fg.comment,
  },

  -- UI
  ui = {
    lineNumber = p.sunset[500],
    visual = { bg = p.visual.desert, fg = "none" },
    search = { bg = p.visual.grey, fg = base.fg.core },
    match = { bg = p.olive[500], fg = base.bg.core },
    matchParen = { bg = p.stone[900], fg = base.theme.secondary },
    dir = p.sky[500],

    title = base.theme.secondary,
    border = base.theme.strong_primary,
    cursorLine = base.bg.mantle,
    nontext = base.fg.dim,
    float = {
      title = base.theme.secondary,
      fg = base.fg.strong,
      bg = base.bg.mantle,
      border = { fg = base.theme.strong_primary, bg = base.bg.mantle },
    },
    picker = {
      title = base.theme.secondary,
      fg = base.fg.strong,
      bg = base.bg.mantle,
      border = { fg = base.theme.secondary_strong, bg = base.bg.mantle },
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
  local light_bg = LightTheme.generate_bg(theme.light_bg_seed, opts.light_intensity, { preserve_hsl = true })
  local light_ui = vim.tbl_deep_extend("force", {}, dark.ui, {
    search = { bg = p.visual.desert, fg = base.fg.core },
    match = { bg = p.olive[500], fg = base.fg.core },
    border = base.theme.primary,
    float = {
      title = base.theme.secondary,
      fg = base.fg.strong,
      bg = base.bg.mantle,
      border = { fg = base.theme.primary, bg = base.bg.mantle },
    },
    matchParen = { bg = dark.ui.matchParen.bg, fg = base.theme.secondary_strong },
  })
  local light_terminal = LightTheme.generate_terminal(p.terminal, light_bg.core, opts.light_intensity, opts.contrast)
  light = {
    light_mode = true,
    bg = light_bg,
    fg = LightTheme.generate_fg(base.fg, light_bg.core, opts.light_intensity),
    theme = LightTheme.generate_theme(base.theme, opts.light_intensity),
    terminal = light_terminal,
    diff = LightTheme.apply_contrast(dark.diff, light_bg.core, opts.contrast),
    git = LightTheme.generate_git(dark.git, light_terminal, light_bg.core, opts.contrast),
    syntax = LightTheme.generate_syntax(dark.syntax, light_bg.core, opts.light_intensity, nil, opts.contrast),
    ui = LightTheme.generate_ui(light_ui, light_bg, opts.light_intensity),
  }
end

-- Return dual-mode palette
return {
  dark = dark,
  light = light,
}
