-- lua/oasis/integrations/plugins/gitsigns.lua
-- Highlights for gitsigns.nvim plugin

return function(c)
  local LIGHT_MODE = c.light_mode or false

  local highlights = {
    GitSignsAdd = { fg = c.git.add },
    GitSignsChange = { fg = c.git.change },
    GitSignsDelete = { fg = c.git.delete },
  }

  -- Light mode overrides
  if LIGHT_MODE then
    highlights.GitSignsAdd = { fg = c.git.add, bg = c.bg.core }
    highlights.GitSignsChange = { fg = c.git.change, bg = c.bg.core }
    highlights.GitSignsDelete = { fg = c.git.delete, bg = c.bg.core }
  end

  return highlights
end
