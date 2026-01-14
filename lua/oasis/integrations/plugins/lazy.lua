-- lua/oasis/integrations/plugins/lazy.lua
-- Highlights for lazy.nvim plugin manager

return function(c, hl)
	hl.LazyH1 = { fg = c.theme.primary, bold = true }
	hl.LazyH2 = { fg = c.theme.light_primary, bold = true }
	hl.lazyActiveBorder = "Identifier"
end
