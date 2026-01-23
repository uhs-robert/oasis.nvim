-- lua/oasis/lib/override_palette.lua

local PaletteOverrides = {}
local Config = require("oasis.config")
local deepcopy = vim.deepcopy

--- Resolve function overrides into a table
---@param palette table
---@param overrides table|function|nil
---@return table|nil
local function normalize(palette, overrides)
  if type(overrides) == "function" then
    local colors = Config.get_base_colors()
    return overrides(palette, colors)
  end

  if type(overrides) ~= "table" then return nil end

  return overrides
end

--- Apply global light/intensity overrides to a palette
---@param result table
---@param overrides table
---@param intensity number
local function apply_global_light(result, overrides, intensity)
  if overrides.light then result = vim.tbl_deep_extend("force", result, overrides.light) end

  local intensity_key = "light_" .. intensity
  if overrides[intensity_key] then
    result = vim.tbl_deep_extend("force", result, overrides[intensity_key])
  end

  return result
end

--- Apply palette-specific dark overrides
---@param result table
---@param palette_override table
---@return table
local function apply_dark(result, palette_override)
  local dark_overrides = {}
  for key, value in pairs(palette_override) do
    if key ~= "light" and not key:match("^light_%d$") then dark_overrides[key] = value end
  end
  return vim.tbl_deep_extend("force", result, dark_overrides)
end

--- Apply palette-specific light/intensity overrides
---@param result table
---@param palette_override table
---@param intensity number
---@return table
local function apply_light(result, palette_override, intensity)
  if palette_override.light then result = vim.tbl_deep_extend("force", result, palette_override.light) end

  local intensity_key = "light_" .. intensity
  if palette_override[intensity_key] then
    result = vim.tbl_deep_extend("force", result, palette_override[intensity_key])
  end

  return result
end

--- Apply palette-specific overrides for the active palette variant
---@param result table
---@param overrides table
---@param palette_variant string|nil
---@param is_light_mode boolean
---@param intensity number
---@return table
local function apply_palette(result, overrides, palette_variant, is_light_mode, intensity)
  if not palette_variant then return result end

  local palette_override = overrides[palette_variant]
  if type(palette_override) ~= "table" then return result end

  if is_light_mode then return apply_light(result, palette_override, intensity) end

  return apply_dark(result, palette_override)
end

--- Apply palette overrides to a loaded palette
--- Supports multi-level overrides: dark (default) -> light (all intensities) -> light_N (specific intensity)
---@param palette table The base palette
---@param palette_name string The name of the palette (e.g., "oasis_desert")
---@param config table The config object
---@return table palette The palette with overrides applied
function PaletteOverrides.resolve(palette, palette_name, config)
  local result = deepcopy(palette)
  local overrides = normalize(result, config and config.palette_overrides or {})
  local LIGHT_MODE = palette.light_mode or false
  local palette_variant = palette_name and palette_name:gsub("^oasis_", "") or nil
  local intensity = palette.light_intensity or (config and config.light_intensity) or 3

  if not overrides then return result end

  if LIGHT_MODE then result = apply_global_light(result, overrides, intensity) end

  result = apply_palette(result, overrides, palette_variant, LIGHT_MODE, intensity)

  return result
end

return PaletteOverrides
