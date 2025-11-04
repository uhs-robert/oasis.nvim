-- lua/oasis/integrations/plugins/gitsigns.lua
-- Highlights for gitsigns.nvim plugin

return function(c)
  local LIGHT_MODE = c.light_mode or false

  local highlights = {
    GitSignsAdd    = { fg=c.diff.add },
    GitSignsChange = { fg=c.diff.change },
    GitSignsDelete = { fg=c.diff.delete },
  }

  -- Light mode overrides
  if LIGHT_MODE then
    highlights.GitSignsAdd    = { fg=c.diff.add,    bg=c.bg.core }
    highlights.GitSignsChange = { fg=c.diff.change, bg=c.bg.core }
    highlights.GitSignsDelete = { fg=c.diff.delete, bg=c.bg.core }
  end

  return highlights
end
