-- lua/oasis/integrations/plugins/mini_jump.lua
-- Highlights for mini.jump plugin

return function(c, hl)
	hl.MiniJump = { undercurl = true, sp = c.theme.cursor }
end
