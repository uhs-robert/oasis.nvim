-- lua/oasis/integrations/plugins/mini_map.lua
-- Highlights for mini.map plugin

return function(c, hl)
	hl.MiniMapNormal = { fg = c.fg.comment, bg = c.ui.float.bg }
	hl.MiniMapSymbolCount = { fg = c.fg.comment }
end
