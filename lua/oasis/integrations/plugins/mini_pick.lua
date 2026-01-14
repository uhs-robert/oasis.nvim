-- lua/oasis/integrations/plugins/mini_pick.lua
-- Highlights for mini.pick plugin

return function(c, hl)
	hl.MiniPickBorderBusy = { fg = c.ui.diag.warn.fg, bg = c.ui.float.bg }
	hl.MiniPickMatchCurrent = "PmenuSel"
	hl.MiniPickMatchMarked = "Search"
	hl.MiniPickMatchRanges = "PmenuMatch"
	hl.MiniPickPreviewLine = { bg = c.ui.visual.bg }
	hl.MiniPickPrompt = { fg = c.ui.float.fg, bg = c.ui.float.bg, bold = true }
	hl.MiniPickPromptPrefix = { fg = c.ui.float.title, bg = c.ui.float.bg, bold = true }
end
