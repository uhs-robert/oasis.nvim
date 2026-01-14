-- lua/oasis/integrations/plugins/mini_diff.lua
-- Highlights for mini.diff plugin

return function(c, hl)
	hl.MiniDiffSignAdd = { fg = c.git.add }
	hl.MiniDiffSignChange = { fg = c.git.change }
	hl.MiniDiffSignDelete = { fg = c.git.delete }
end
