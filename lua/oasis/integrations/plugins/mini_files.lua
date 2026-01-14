-- lua/oasis/integrations/plugins/mini_files.lua
-- Highlights for mini.files plugin

return function(c, hl)
	hl.MiniFilesCursorLine = "PmenuSel"
	hl.MiniFilesBorderModified = { fg = c.ui.diag.warn.fg, bg = c.ui.float.bg }
	hl.MiniFilesTitleFocused = { fg = c.theme.secondary, bg = c.ui.float.bg, bold = true }
end
