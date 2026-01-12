-- lua/oasis/integrations/plugins/mini_map.lua
-- Highlights for mini.map plugin

return function(c)
  return {
    MiniMapNormal = { fg = c.fg.comment, bg = c.ui.float.bg },
    MiniMapSymbolCount = { fg = c.fg.comment },
  }
end
