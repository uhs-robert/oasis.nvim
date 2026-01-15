-- lua/oasis/integrations/tabby.lua

local Tabby = {}

--- Get current oasis palette for tabby theme
---@return table
function Tabby.get_theme()
  local current_palette = vim.g.colors_name or "oasis_lagoon"

  -- Convert hyphen format to underscore format for module loading
  current_palette = current_palette:gsub("%-", "_")

  -- Ensure the palette name has proper format
  if not current_palette:match("^oasis_") then current_palette = "oasis_lagoon" end

  -- Load and extract the current palette
  local Utils = require("oasis.utils")
  local c, err = Utils.load_and_extract_palette("oasis.color_palettes." .. current_palette)
  if not c then
    c, err = Utils.load_and_extract_palette("oasis.color_palettes.oasis_lagoon")
  end

  return {
    fill = { fg = c.fg.muted, bg = c.bg.core }, -- tabline background (transparent)
    head = { fg = c.bg.core, bg = c.syntax.statement }, -- head element
    current_tab = { fg = c.bg.core, bg = c.syntax.statement }, -- current tab label
    tab = { fg = c.syntax.statement, bg = c.bg.mantle }, -- other tab label
    win = { fg = c.syntax.special, bg = c.bg.mantle }, -- window
    tail = { fg = c.bg.core, bg = c.syntax.statement }, -- tail element
  }
end

--- Setup tabby with dynamic oasis theme using presets
---@param preset? string Tabby preset to use (default: 'active_wins_at_tail')
---@param options? table Additional options for tabby
function Tabby.setup(preset, options)
  if not package.loaded["tabby"] then return end

  preset = preset or "active_wins_at_tail"
  options = options or {}

  -- Merge oasis theme with user options
  local config = vim.tbl_deep_extend("force", {
    preset = preset,
    option = vim.tbl_deep_extend("force", {
      theme = Tabby.get_theme(),
      nerdfont = true,
    }, options),
  }, {})

  require("tabby").setup(config)
end

--- Update existing tabby config with oasis theme
function Tabby.apply_to_existing_config(opts)
  if not opts.option then opts.option = {} end

  opts.option.theme = Tabby.get_theme()

  return opts
end

--- Refresh tabby theme
function Tabby.refresh()
  if package.loaded["tabby"] then Tabby.force_apply() end
end

--- Force apply oasis theme to existing tabby setup
function Tabby.force_apply()
  if not package.loaded["tabby"] then return end

  local tabby = require("tabby")
  local current_config = tabby._config or {}
  current_config.option = current_config.option or {}
  current_config.option.theme = Tabby.get_theme()
  tabby.setup(current_config)
  vim.cmd("redrawtabline")
end

-- Auto-register this integration
require("oasis.integrations").register("tabby", Tabby)

-- Call force_apply when oasis loads
vim.schedule(function()
  Tabby.force_apply()
end)

return Tabby
