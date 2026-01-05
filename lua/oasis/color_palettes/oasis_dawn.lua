-- lua/oasis/color_palettes/oasis_dawn.lua

local Config = require("oasis.config")
local LightTheme = require("oasis.tools.light_theme_generator")
local p = require("oasis.palette")
local opts = Config.get()
local seed_dark = require("oasis.color_palettes.oasis_canyon").dark
local bg_seed = p.theme.night.fg.core
local light_intensity = 1
local target_l = { [1] = 84 }
local contrast_opts = opts.contrast or { min_ratio = 5.8, force_aaa = false }
local light_bg = LightTheme.generate_bg(bg_seed, light_intensity, { target_l_core = target_l })

-- Colorscheme
local c = {
  light_mode = true,
  bg = light_bg,
  fg = LightTheme.generate_fg(seed_dark.fg, light_bg.core, light_intensity, contrast_opts),
  theme = LightTheme.generate_theme(seed_dark.theme, light_intensity),
  terminal = LightTheme.generate_terminal(seed_dark.terminal, light_bg.core, light_intensity, contrast_opts),
  diff = LightTheme.apply_contrast(seed_dark.diff, light_bg.core),
  git = LightTheme.apply_contrast(seed_dark.git, light_bg.core),
  syntax = LightTheme.generate_syntax(seed_dark.syntax, light_bg.core, light_intensity, nil, contrast_opts),
  ui = LightTheme.generate_ui(seed_dark.ui, light_bg, light_intensity),
}

-- Deprecation notice (once per session)
if vim and vim.notify and not vim.g.oasis_deprecated_dawn then
  vim.g.oasis_deprecated_dawn = true
  vim.notify(
    "Oasis: 'dawn' is deprecated and will be removed in a future release. Please migrate to 'night' with light_intensity = 1.",
    vim.log.levels.WARN
  )
end

return c
