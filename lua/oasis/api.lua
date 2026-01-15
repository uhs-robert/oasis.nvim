-- lua/oasis/api.lua
-- User command definitions and toggle functions for Oasis colorscheme

local Api = {}

--- Return sorted palette names on runtimepath, optionally filtered
---@param filter? fun(name: string): boolean
---@return string[]
local function list_palettes(filter)
  local paths = vim.fn.globpath(vim.o.rtp, "lua/oasis/color_palettes/*.lua", false, true)
  local out = {}

  for _, p in ipairs(paths) do
    local name = p:match("[\\/]color_palettes[\\/](.+)%.lua$")
    if name and name ~= "init" and (not filter or filter(name)) then table.insert(out, name) end
  end

  table.sort(out)
  return out
end

--- Create :Oasis command with palette completion
---@return nil
local function create_oasis_command()
  vim.api.nvim_create_user_command("Oasis", function(opts)
    require("oasis").apply(opts.args ~= "" and opts.args or nil)
  end, {
    nargs = "?",
    complete = function()
      local bg = vim.o.background
      local utils = require("oasis.utils") -- Lazy-load only on tab completion
      return list_palettes(function(name)
        local mode = utils.get_palette_mode(name)
        return mode == "dual" or mode == bg
      end)
    end,
    desc = "Apply Oasis palette variant",
  })
end

--- Create :OasisWCAG command to run contrast checks
---@return nil
local function create_wcag_command()
  vim.api.nvim_create_user_command("OasisWCAG", function(opts)
    local Wcag = require("oasis.tools.wcag_checker")
    local Utils = require("oasis.utils")

    if opts.args ~= "" then
      local palette_name = opts.args
      -- Check if it's a dual-mode palette without .dark/.light suffix
      if not palette_name:match("%.dark$") and not palette_name:match("%.light$") then
        local ok, palette = pcall(require, "oasis.color_palettes." .. palette_name)
        if ok and Utils.is_dual_mode_palette(palette) then
          -- Check both dark and light modes for dual-mode palettes
          Wcag.check_palette(palette_name .. ".dark")
          Wcag.check_palette(palette_name .. ".light")
          return
        end
      end
      Wcag.check_palette(palette_name)
    else
      Wcag.check_all()
    end
  end, {
    nargs = "?",
    complete = function()
      return list_palettes()
    end,
    desc = "Check WCAG contrast compliance for Oasis palettes",
  })
end

--- Toggle transparency and reapply the current theme
--- Examples:
---   require('oasis.api').toggle_transparency()
---   :OasisTransparency
function Api.toggle_transparency()
  local Config = require("oasis.config")
  local Oasis = require("oasis")
  local cfg = Config.get()
  cfg.transparent = not cfg.transparent
  Oasis.apply(Oasis.styles.current)
  local status = cfg.transparent and "enabled" or "disabled"
  vim.notify(string.format("Oasis transparency %s", status), vim.log.levels.INFO)
end

--- Toggle themed_syntax and reapply the current theme
--- Examples:
---   require('oasis.api').toggle_themed_syntax()
---   :OasisThemedSyntax
function Api.toggle_themed_syntax()
  local Config = require("oasis.config")
  local Oasis = require("oasis")
  local cfg = Config.get()
  cfg.themed_syntax = not cfg.themed_syntax
  Oasis.apply(Oasis.styles.current)
  local status = cfg.themed_syntax and "enabled" or "disabled"
  vim.notify(string.format("Oasis themed syntax %s", status), vim.log.levels.INFO)
end

--- Select light intensity via UI picker or cycle through light intensity (1→2→3→4→5→1→2...)
--- Examples:
---   require('oasis.api').cycle_intensity(true|nil) -- Shows UI picker
---   require('oasis.api').cycle_intensity(false)    -- Cycles intensity
---   :OasisIntensity                                -- Shows UI picker
---@param show_picker boolean|nil
function Api.cycle_intensity(show_picker)
  local Config = require("oasis.config")
  local Oasis = require("oasis")
  local cfg = Config.get()

  if show_picker ~= false then
    local option_names = { "Very Low", "Low", "Medium", "High", "Very High" }
    vim.ui.select(option_names, {
      prompt = "Select Oasis Light Intensity (1-5)",
      initial = option_names[cfg.light_intensity],
    }, function(selected_name)
      if selected_name then
        local selected_intensity_number
        for i, name in ipairs(option_names) do
          if name == selected_name then
            selected_intensity_number = i
            break
          end
        end
        cfg.light_intensity = selected_intensity_number
        Oasis.apply(Oasis.styles.current)
        local indicator = string.rep("●", cfg.light_intensity) .. string.rep("○", 5 - cfg.light_intensity)
        vim.notify(
          string.format("Oasis light intensity: **%d/5 %s**", cfg.light_intensity, indicator),
          vim.log.levels.INFO
        )
      else
        vim.notify("Oasis light intensity selection cancelled", vim.log.levels.INFO)
      end
    end)
  else -- Increment and wrap around
    local next_intensity = cfg.light_intensity + 1
    if next_intensity > 5 then next_intensity = 1 end

    cfg.light_intensity = next_intensity
    Oasis.apply(Oasis.styles.current)
    local indicator = string.rep("●", next_intensity) .. string.rep("○", 5 - next_intensity)
    vim.notify(string.format("Oasis light intensity: %d/5 %s", next_intensity, indicator), vim.log.levels.INFO)
  end
end

--- Create :OasisTransparency toggle command
---@return nil
local function create_transparency_command()
  vim.api.nvim_create_user_command("OasisTransparency", function()
    Api.toggle_transparency()
  end, {
    desc = "Toggle transparency for Oasis theme",
  })
end

--- Create :OasisThemedSyntax toggle command
---@return nil
local function create_themed_syntax_command()
  vim.api.nvim_create_user_command("OasisThemedSyntax", function()
    Api.toggle_themed_syntax()
  end, {
    desc = "Toggle themed syntax using primary color for statements/conditionals (dark themes only)",
  })
end

--- Create :OasisIntensity cycling command
---@return nil
local function create_intensity_command()
  vim.api.nvim_create_user_command("OasisIntensity", function()
    Api.cycle_intensity()
  end, {
    desc = "Show UI picker for light background intensity (1-5)",
  })
end

--- Setup all user commands
---@return nil
function Api.setup()
  create_oasis_command()
  create_wcag_command()
  create_transparency_command()
  create_themed_syntax_command()
  create_intensity_command()
end

return Api
