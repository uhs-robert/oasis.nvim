-- lua/oasis/integrations/plugins/mini_starter.lua
-- Highlights for mini.starter plugin

return function(c, hl)
	hl.MiniStarterFooter = "Comment"
	hl.MiniStarterInactive = { fg = c.fg.muted }
	hl.MiniStarterSection = "OasisSecondary"
	hl.MiniStarterItemPrefix = { fg = c.theme.strong_primary, bold = true }
	hl.MiniStarterQuery = { fg = c.theme.accent, bold = true }
end
