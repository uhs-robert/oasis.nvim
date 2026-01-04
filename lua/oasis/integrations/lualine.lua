-- lua/oasis/integrations/lualine.lua
-- Lualine integration for oasis colorscheme

local Lualine = {}

--- Check if lualine is using oasis theme
---@return boolean
local function is_using_oasis()
  if not package.loaded["lualine"] then return false end

  local ok, lualine = pcall(require, "lualine")
  if not ok then return false end

  local config = lualine.get_config()
  return config and config.options and config.options.theme == "oasis"
end

--- Refresh lualine theme
function Lualine.refresh()
  if is_using_oasis() then require("lualine").setup({}) end
end

-- Auto-register this integration
require("oasis.integrations").register("lualine", Lualine)

return Lualine
