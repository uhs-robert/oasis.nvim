-- lua/oasis/integrations/plugins/mini_trailspace.lua
-- Highlights for mini.trailspace plugin

return function(c)
  return {
    MiniTrailspace = { bg = c.syntax.exception },
  }
end
