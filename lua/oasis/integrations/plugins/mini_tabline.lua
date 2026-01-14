-- lua/oasis/integrations/plugins/mini_tabline.lua
-- Highlights for mini.tabline plugin

return function(c, hl)
	hl.MiniTablineCurrent = { fg = c.theme.secondary, bg = c.bg.surface, bold = true }
	hl.MiniTablineFill = "TabLineFill"
	hl.MiniTablineHidden = "TabLine"
	hl.MiniTablineModifiedCurrent = { fg = c.bg.core, bg = c.theme.secondary, bold = true }
	hl.MiniTablineModifiedHidden = { fg = c.bg.core, bg = c.ui.border }
	hl.MiniTablineModifiedVisible = { fg = c.bg.core, bg = c.ui.border, bold = true }
	hl.MiniTablineTabpagesection = { fg = c.bg.core, bg = c.theme.accent }
	hl.MiniTablineVisible = { fg = c.ui.border, bg = c.bg.surface, bold = true }
end
