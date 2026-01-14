-- lua/oasis/integrations/plugins/mini_cmdline.lua
-- Highlights for mini.cmdline plugin

return function(c, hl)
	hl.MiniCmdlinePeekSep = { fg = c.fg.muted, bg = c.ui.float.bg }
end
