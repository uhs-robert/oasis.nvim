-- lua/lualine/themes/oasis.lua

-- Dynamically detect current oasis palette
local current_palette = vim.g.colors_name or "oasis_moonlight"
local palette_suffix = current_palette:match("^oasis%-(.+)") or current_palette:match("^oasis_(.+)") or "moonlight"

return require("lualine.themes._oasis").get(palette_suffix)
