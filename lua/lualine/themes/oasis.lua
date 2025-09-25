-- lua/lualine/themes/oasis.lua

-- Dynamically detect current oasis palette
local current_palette = vim.g.colors_name or "oasis_lagoon"
local palette_suffix = current_palette:match("^oasis_(.+)") or "lagoon"

return require("lualine.themes._oasis").get(palette_suffix)
