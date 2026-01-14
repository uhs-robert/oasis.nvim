-- lua/oasis/integrations/plugins/mini_clue.lua
-- Highlights for mini.clue plugin

return function(_, hl)
	hl.MiniClueNextKey = "Statement"
	hl.MiniClueDescGroup = "OasisSecondary"
	hl.MiniClueDescSingle = "OasisLightPrimary"
end
