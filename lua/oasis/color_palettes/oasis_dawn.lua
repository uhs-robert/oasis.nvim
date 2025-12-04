-- lua/oasis/color_palettes/oasis_dawn.lua

local p = require("oasis.palette")
local config = require("oasis.config")
local color_utils = require("oasis.tools.color_utils")
local light_gen = require("oasis.tools.light_theme_generator")
local opts = config.get()
local seed_dark = require("oasis.color_palettes.oasis_canyon").dark
local bg_seed = p.theme.night.fg.core
local light_intensity = 1
local target_l = { [1] = 84 }
local contrast_opts = opts.contrast or { min_ratio = 5.8, force_aaa = false }
local light_bg = light_gen.generate_light_backgrounds(bg_seed, light_intensity, { target_l_core = target_l })

-- Colorscheme
local c = {
	bg = light_bg,
	fg = light_gen.generate_light_foregrounds(seed_dark.fg, light_bg.core, light_intensity, contrast_opts),
	theme = light_gen.generate_light_theme(seed_dark.theme, light_intensity),
	terminal = light_gen.generate_light_terminal(
		seed_dark.terminal or p.terminal,
		light_bg.core,
		light_intensity,
		contrast_opts
	),
	light_mode = true,

	-- Syntax
	syntax = light_gen.generate_light_syntax(seed_dark.syntax, light_bg.core, light_intensity, nil, contrast_opts),

	-- Diff
	diff = {
		add = color_utils.darken_to_contrast(seed_dark.diff.add, light_bg.core, 7.0),
		change = color_utils.darken_to_contrast(seed_dark.diff.change, light_bg.core, 7.0),
		delete = color_utils.darken_to_contrast(seed_dark.diff.delete, light_bg.core, 7.0),
	},

	-- UI
	ui = light_gen.generate_light_ui(seed_dark.ui, light_bg, light_intensity),
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
