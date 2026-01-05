-- lua/oasis/color_palettes/oasis_dawnlight.lua

local p = require("oasis.palette")
local Config = require("oasis.config")
local ColorUtils = require("oasis.tools.color_utils")
local LightTheme = require("oasis.tools.light_theme_generator")
local opts = Config.get()
local seed_dark = require("oasis.color_palettes.oasis_canyon").dark
local bg_seed = p.theme.night.fg.core
local light_intensity = 2
local target_l = { [2] = 82 }
local contrast_opts = opts.contrast or { min_ratio = 5.8, force_aaa = false }
local light_bg = LightTheme.generate_bg(bg_seed, light_intensity, { target_l_core = target_l })

-- Colorscheme
local c = {
  bg = light_bg,
  fg = LightTheme.generate_fg(seed_dark.fg, light_bg.core, light_intensity, contrast_opts),
  theme = LightTheme.generate_theme(seed_dark.theme, light_intensity),
  terminal = LightTheme.generate_terminal(
    seed_dark.terminal or p.terminal,
    light_bg.core,
    light_intensity,
    contrast_opts
  ),
  light_mode = true,

  -- Syntax
  syntax = LightTheme.generate_syntax(seed_dark.syntax, light_bg.core, light_intensity, nil, contrast_opts),

  -- Diff
  diff = {
    add = ColorUtils.darken_to_contrast(seed_dark.diff.add, light_bg.core, 7.0),
    change = ColorUtils.darken_to_contrast(seed_dark.diff.change, light_bg.core, 7.0),
    delete = ColorUtils.darken_to_contrast(seed_dark.diff.delete, light_bg.core, 7.0),
  },

  -- UI
  ui = LightTheme.generate_ui(seed_dark.ui, light_bg, light_intensity),
}

-- Deprecation notice (once per session)
if vim and vim.notify and not vim.g.oasis_deprecated_dawnlight then
  vim.g.oasis_deprecated_dawnlight = true
  vim.notify(
    "Oasis: 'dawnlight' is deprecated and will be removed in a future release. Please migrate to 'night' with light_intensity = 2.",
    vim.log.levels.WARN
  )
end

return c
