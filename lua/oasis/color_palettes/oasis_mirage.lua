-- lua/oasis/color_palettes/oasis_mirage.lua

local Config = require("oasis.config")
local p = require("oasis.palette")
local opts = Config.get()
local theme = p.theme.mirage

-- Neovim: Only generate when needed. Extras: generate both.
local in_neovim = vim.uv ~= nil or vim.loop ~= nil
local need_light = not in_neovim or vim.o.background == "light"

-- General Reusable Colors
local base = {
  bg = theme.bg,
  fg = theme.fg,
  palette = {
    primary = p.teal,
    secondary = p.sunrise,
    accent = p.lavender,
  },
  theme = {
    primary_strong = p.teal[700],
    primary = p.teal[600],
    primary_light = p.teal[400],
    secondary = p.sunrise[500],
    label = p.sunrise[600],
    accent = p.lavender[300],
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
    parameter = p.palm[500],
    preproc = p.olive[500], -- (imports)
    macro = p.olive[600], -- (imports)
    identifier = p.sky[500],
    delimiter = base.theme.primary_strong,
    type = opts.themed_syntax and p.khaki[300] or p.teal[600],
    typedef = opts.themed_syntax and p.khaki[800] or p.teal[800],
    string = p.rose[500],
    regex = p.rose[300],
    builtin_var = p.lavender[500], -- (this, document, window, etc)
    builtin_const = p.iris[400], -- (e.g. null, undefined, Infinity, etc)
    constant = p.sunset[500], -- (constant: number, float, boolean, or const not string/character)

    -- Warm: (Control / Flow)
    func = p.copper[200],
    builtin_func = p.copper[400], -- (eg. parseInt, Array, Object etc)
    statement = opts.themed_syntax and primary[400] or p.khaki[500], -- (general statement (i.e. var, const))
    conditional = opts.themed_syntax and primary[700] or p.khaki[800], -- (Conditionals, Loops)
    exception = p.red[500], -- (try/catch, return)
    special = p.sunset[300], -- (Statement not covered above)
    operator = base.palette.primary[500],
    punctuation = base.palette.primary[800],

    -- Neutral: (Connections / Info)
    bracket = p.slate[500], -- (bracket punctuation)
    comment = theme.fg.comment, -- (comments)
  },

  -- UI
  ui = {
    line_number = p.sunset[500],
    visual = { bg = base.bg.surface, fg = "none" },
    search = { bg = p.visual.grey, fg = base.fg.core },
    match = { bg = p.lavender[500], fg = base.bg.core },
    match_parent = { bg = p.visual.orange, fg = p.sunrise[600] },
    dir = p.sky[500],

    title = base.theme.primary,
    border = base.theme.primary_strong,
    cursor_line = base.bg.mantle,
    nontext = base.fg.dim,
    float = {
      title = base.theme.secondary,
      fg = base.fg.strong,
      bg = base.bg.crust,
      border = { fg = base.theme.primary_strong, bg = base.bg.crust },
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
    search = { bg = p.visual.teal, fg = base.fg.core },
    match = { bg = p.visual.orange, fg = base.fg.core },
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
