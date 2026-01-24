-- lua/oasis/config.lua

local Config = {}
local DEFAULT_DARK = "lagoon"
local DEFAULT_LIGHT = "lagoon"
local BASE_COLORS = nil
local deepcopy = vim.deepcopy

-- Get base color palette (cached)
-- @return table colors The base color palette from palette.lua
function Config.get_base_colors()
  if not BASE_COLORS then BASE_COLORS = require("oasis.palette") end
  return BASE_COLORS
end

-- Helper to get background setting (use vim.o.background if available, otherwise default to "dark" for standalone lua)
local function get_background()
  if vim and vim.o and vim.o.background then
    return vim.o.background
  else
    return "dark"
  end
end

-- Default configuration
-- stylua: ignore start
---@type OasisConfig
Config.defaults = {
	style = DEFAULT_DARK,         -- Primary style choice (default palette)
	dark_style = nil,             -- nil=`style`, or specify a dark theme (e.g., "sol", "canyon")
	light_style = nil,            -- nil=`style`, or specify a light theme (e.g., "night", "canyon")
	use_legacy_comments = false,  -- Applies to `desert` only. Uses vibrant skyblue for comments
	themed_syntax = true,         -- Use theme primary color for statements/conditionals
	light_intensity = 3,          -- Light background intensity (1-5): 1=subtle, 5=saturated
	palette_overrides = {},
	highlight_overrides = {},

	-- Contrast controls
	contrast = {
		min_ratio = 5.8,            -- Minimum WCAG contrast ratio for syntax/terminal chroma slots (clamped 4.5-7.0)
		force_aaa = false,          -- Force all relevant contrast targets to AAA (7.0). Overrides min_ratio.
	},

	-- Text styling toggles
	styles = {
		bold = true,                -- Enable/disable bold text
		italic = true,              -- Enable/disable italic text
		underline = true,           -- Enable/disable underline
		undercurl = true,           -- Enable/disable undercurl (diagnostics, spell)
		strikethrough = true,       -- Enable/disable strikethrough
	},

	-- Additional toggles
	terminal_colors = true,       -- Enable/disable terminal color setting
	transparent = false,          -- Make backgrounds transparent (NONE)

	-- Plugin integrations
	integrations = {
		default_enabled = true,     -- Default behavior: true = enable all, false = disable all
    -- For each plugin: nil = use default_enabled, true = enable, false = disable
		plugins = {
			fzf_lua = nil,
			gitsigns = nil,
			lazy = nil,
      mini = nil,
			snacks = nil,
			which_key = nil,
		},
	},
}
-- stylua: ignore end

-- Current active configuration
---@type OasisConfig
Config.options = deepcopy(Config.defaults)
Config.user_options = {}
Config.user_plugins = {}

--- Setup configuration
---@param user_config table|nil User configuration to merge with defaults
function Config.setup(user_config)
  user_config = user_config or {}
  Config.user_options = user_config
  Config.user_plugins = ((user_config.integrations or {}).plugins or {})
  Config.options = vim.tbl_deep_extend("force", deepcopy(Config.defaults), user_config)
  local styles = Config.options.styles
  if type(styles) ~= "table" then
    styles = {}
    Config.options.styles = styles
  end
  styles.all_enabled = styles.bold ~= false
    and styles.italic ~= false
    and styles.underline ~= false
    and styles.undercurl ~= false
    and styles.strikethrough ~= false
end

--- Get current configuration
---@return OasisConfig config The current configuration
function Config.get()
  return Config.options
end

--- Get user configuration (unmerged)
---@return OasisConfig config The user configuration table
function Config.get_user()
  return Config.user_options
end

--- Get user integrations plugin overrides
---@return table plugins The user integrations plugins map
function Config.get_user_plugins()
  return Config.user_plugins
end

--- Check if a theme name is valid (exists in palette.lua themes)
---@param name string|nil Theme name to validate (e.g., "lagoon", "desert")
---@return boolean is_valid True if the name exists in themes
function Config.is_valid_theme(name)
  if not name then return false end
  local themes = Config.get_base_colors().theme
  return themes[name] ~= nil
end

--- Get the full palette name from the configured style
--- Guaranteed to return a usable palette name string (falls back to defaults).
---@return string palette_name Full palette name (e.g., "oasis_lagoon")
function Config.get_palette_name()
  local bg = get_background()

  -- Use dark_style/light_style based on background, fallback to style, then DEFAULT
  local style_option = bg == "light" and Config.options.light_style or Config.options.dark_style
  if not Config.is_valid_theme(style_option) then style_option = nil end
  style_option = style_option or Config.options.style or (bg == "light" and DEFAULT_LIGHT or DEFAULT_DARK)

  return "oasis_" .. style_option
end

--- Apply palette overrides to a loaded palette
---@param palette table The base palette
---@param palette_name string The name of the palette (e.g., "oasis_desert")
---@return table palette The palette with overrides applied
function Config.apply_palette_overrides(palette, palette_name)
  local overrides = Config.options.palette_overrides
  if type(overrides) == "table" and next(overrides) == nil then return palette end
  if overrides == nil then return palette end
  local PaletteOverrides = require("oasis.lib.override_palette")
  return PaletteOverrides.resolve(palette, palette_name, Config.options)
end

return Config
