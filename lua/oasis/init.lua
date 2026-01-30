-- lua/oasis/init.lua

local Oasis = {}
local Config = require("oasis.config")

--- Track current and remembered styles for light/dark switching
---@type {current?: string, light?: string, dark?: string}
Oasis.styles = {}

--- Resolve palette name based on config and background changes
---@param palette_name string|nil User-provided palette name
---@param bg string Current background ("light" or "dark")
---@return string resolved_palette The palette name to use
local function resolve_palette_name(palette_name, bg)
  local resolved_palette = palette_name or Config.get_palette_name() or "oasis_lagoon"
  local is_current_theme = (resolved_palette == Oasis.styles.current)
  local last_theme_for_this_bg = Oasis.styles[bg]

  -- Background change detected - handle theme switching logic
  if is_current_theme and resolved_palette ~= last_theme_for_this_bg then
    local old_bg = bg == "light" and "dark" or "light"
    local cfg = Config.get()
    local old_style_option = old_bg == "light" and cfg.light_style or cfg.dark_style

    -- Resolve invalid names: fall back to cfg.style then default
    if not Config.is_valid_theme(old_style_option) then old_style_option = nil end
    old_style_option = old_style_option or cfg.style or "lagoon"

    -- Check if user was on their configured theme for the old background
    local old_configured_palette = "oasis_" .. old_style_option
    local should_use_config = resolved_palette == old_configured_palette
    if should_use_config then
      return Config.get_palette_name() or "oasis_lagoon"
    else
      -- User switched themes
      local Utils = require("oasis.utils")
      local mode = Utils.get_palette_mode(resolved_palette)
      if not (mode == "dual" or mode == bg) then return Config.get_palette_name() or "oasis_lagoon" end
    end
  end

  return resolved_palette
end

--- Remember current style choices for light/dark switching
---@param palette_name string Palette to remember
---@param bg string Current background
local function remember_style(palette_name, bg)
  Oasis.styles.current = palette_name
  Oasis.styles[bg] = palette_name
end

--- Load palette module with overrides applied
---@param palette_name string Palette name to load
---@return table palette The loaded palette (errors if not found)
local function load_palette_module(palette_name)
  local module_name = "oasis.color_palettes." .. palette_name
  package.loaded[module_name] = nil -- Use a fresh palette load

  -- Load palette
  local ok, palette = pcall(require, module_name)
  if not ok then error(('Oasis: palette "%s" not found: %s'):format(palette_name, palette)) end

  -- Extract variant based on background (dual-mode palettes have .dark/.light)
  if palette.dark then
    local mode = vim.o.background == "light" and "light" or "dark"
    palette = palette[mode]
  end

  return Config.apply_palette_overrides(palette, palette_name)
end

--- Apply theme and refresh plugin integrations
---@param palette table The color palette to apply
---@param palette_name string The palette name (e.g., "oasis_lagoon")
local function apply_theme(palette, palette_name)
  local build = require("oasis.theme_generator")
  build(palette, palette_name)

  -- Defer plugin integrations to after startup
  pcall(require, "oasis.integrations.lualine")
  pcall(require, "oasis.integrations.tabby")
  require("oasis.integrations").refresh_all()
end

--- Apply Oasis using a palette module name (no prefix).
--- Examples:
---   require('oasis').apply('oasis_midnight')
---   require('oasis').apply('oasis')
---@param palette_name string|nil
function Oasis.apply(palette_name)
  local bg = vim.o.background
  palette_name = resolve_palette_name(palette_name, bg)
  remember_style(palette_name, bg)

  -- Reset highlights
  if vim.v.vim_did_enter == 1 then
    vim.cmd("highlight clear")
    if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
  end

  -- Set colorscheme name and load
  vim.g.colors_name = palette_name:gsub("_", "-")
  local palette = load_palette_module(palette_name)
  apply_theme(palette, palette_name)
end

--- Setup Oasis with user configuration
--- Note: This only configures Oasis. To apply the theme, use :colorscheme oasis
---@param user_config OasisConfig|nil User configuration
function Oasis.setup(user_config)
  Config.setup(user_config)
  -- Register commands on first setup call
  if not Oasis._commands_registered then
    -- Defer to after startup
    require("oasis.api").setup()
    Oasis._commands_registered = true
  end
end

--- Toggle transparency and reapply the current theme
function Oasis.toggle_transparency()
  require("oasis.api").toggle_transparency()
end

--- Toggle themed_syntax and reapply the current theme
function Oasis.toggle_themed_syntax()
  require("oasis.api").toggle_themed_syntax()
end

--- Cycle light intensity (picker by default)
---@param show_picker boolean|nil
function Oasis.cycle_intensity(show_picker)
  require("oasis.api").cycle_intensity(show_picker)
end

return Oasis
