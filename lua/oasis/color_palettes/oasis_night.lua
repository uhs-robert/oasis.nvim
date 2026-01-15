-- lua/oasis/color_palettes/oasis_night.lua

local Config = require("oasis.config")
local p = require("oasis.palette")
local opts = Config.get()
local theme = p.theme.night

-- Neovim: Only generate when needed. Extras: generate both.
local in_neovim = vim.uv ~= nil or vim.loop ~= nil
local need_light = not in_neovim or vim.o.background == "light"

local light_seed = require("oasis.color_palettes.oasis_canyon").dark
local target_lightness = { [1] = 84, [2] = 82, [3] = 80, [4] = 78, [5] = 76 }

-- General Reusable Colors
local base = {
  bg = theme.bg,
  fg = theme.fg,
  palette = {
    primary = p.red,
    secondary = p.sunrise,
    accent = p.lavender,
  },
  theme = {
    strong_primary = p.red[800],
    primary = p.red[500],
    light_primary = p.red[100],
    secondary = p.sunrise[500],
    accent = p.lavender[200],
    cursor = p.khaki[500],
  },
}

-- Dark mode palette
local dark = {
  bg = base.bg,
  fg = base.fg,
  theme = base.theme,
  palette = base.palette,
  terminal = p.terminal,
  diff = vim.tbl_extend("force", p.diff, { change = theme.bg.surface }),
  git = p.git,

  -- Syntax
  syntax = {
    -- Cold: (Data)
    parameter = p.lavender[500],
    identifier = p.teal[400],
    delimiter = base.theme.strong_primary,
    type = p.teal[700],
    builtinVar = p.lagoon[500], -- (this, document, window, etc)
    string = p.cactus[500],
    regex = p.palm[500],
    builtinConst = p.slate[500], -- (constant: number, float, boolean, or const not string/character)
    constant = p.sunset[500],

    -- Warm: (Control / Flow)
    func = p.sunset[300],
    builtinFunc = p.sundown[400], -- (eg. parseInt, Array, Object etc)
    statement = opts.themed_syntax and base.palette.primary[300] or p.khaki[500], -- (general statement (i.e. var, const))
    exception = opts.themed_syntax and p.khaki[500] or p.red[400], -- (try/catch, return)
    conditional = opts.themed_syntax and p.red[500] or p.khaki[700], -- (Conditionals, Loops)
    special = p.sunset[500], -- (Statement not covered above)
    operator = p.peach[300],
    punctuation = p.coral[500],
    preproc = p.sky[500], -- (imports)

    -- Neutral: (Connections / Info)
    bracket = p.grey[500],
    comment = theme.fg.comment, -- (comments)
  },

  -- UI
  ui = {
    lineNumber = p.sunset[500],
    visual = { bg = p.visual.indigo, fg = "none" },
    search = { bg = p.visual.violet, fg = base.fg.core },
    match = { bg = p.sunrise[600], fg = base.bg.core },
    dir = p.sky[500],

    title = base.theme.primary,
    border = base.theme.primary,
    cursorLine = base.bg.surface,
    nontext = base.fg.dim,
    float = {
      title = base.theme.primary,
      fg = base.fg.strong,
      bg = base.bg.mantle,
      border = { fg = base.theme.primary, bg = base.bg.mantle },
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

-- Light mode configuration (backgrounds/ui/theme from night fg, syntax from canyon)
local light
if need_light then
  local LightTheme = require("oasis.tools.light_theme_generator")
  local light_bg = LightTheme.generate_bg(base.fg.core, opts.light_intensity, { target_l_core = target_lightness })
  local light_ui = vim.tbl_deep_extend("force", {}, dark.ui, {
    search = { bg = p.visual.orange, fg = base.fg.core },
    match = { bg = p.visual.red, fg = base.fg.core },
  })
  light = {
    light_mode = true,
    bg = light_bg,
    fg = LightTheme.generate_fg(light_seed.fg, light_bg.core, opts.light_intensity),
    theme = LightTheme.generate_theme(dark.theme, opts.light_intensity),
    terminal = LightTheme.generate_terminal(light_seed.terminal, light_bg.core, opts.light_intensity, opts.contrast),
    diff = LightTheme.apply_contrast(dark.diff, light_bg.core),
    git = LightTheme.apply_contrast(dark.git, light_bg.core),
    syntax = LightTheme.generate_syntax(light_seed.syntax, light_bg.core, opts.light_intensity, nil, opts.contrast),
    ui = LightTheme.generate_ui(light_ui, light_bg, opts.light_intensity),
  }
end

-- Return dual-mode palette
return {
  dark = dark,
  light = light,
}
